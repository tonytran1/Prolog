/**
*	Filename: relatives.pl
*	Author: Tony Tran
*
*	This prolog program contains facts and rules loosely based
*       on my family members.
*/

%facts:
	%male:
	is_male(tony).
	is_male(hanry).
	is_male(danny).
	is_male(mark).
	is_male(bob).
	is_male(ken).
	is_male(bang).
	is_male(tuan).
	is_male(theu).
	is_male(dinh).

	%female:
	is_female(diane).
	is_female(hanh).
	is_female(jess).
	is_female(ann).
	is_female(liu).
	is_female(thien).
	is_female(noi).

	%parents:
	is_parent_of(danny, tony).
	is_parent_of(hanh, tony).

	is_parent_of(danny, hanry).
	is_parent_of(hanh, hanry).

	is_parent_of(danny, diane).
	is_parent_of(hanh, diane).

	is_parent_of(bob, ken).
	is_parent_of(jess, ken).

	is_parent_of(bob, ann).
	is_parent_of(jess, ann).

	is_parent_of(bang, danny).
	is_parent_of(liu, danny).

	is_parent_of(tuan, hanh).
	is_parent_of(thien, hanh).

	is_parent_of(theu, jess).
	is_parent_of(thien, jess).
    
	is_parent_of(theu, mark).
	is_parent_of(thien, mark).
    
	is_parent_of(dinh, tuan).
	is_parent_of(noi, tuan).


%rules:
	%parents:
	father(FATHER, CHILD) :- is_male(FATHER), is_parent_of(FATHER, CHILD).
	mother(MOTHER, CHILD) :- is_female(MOTHER), is_parent_of(MOTHER, CHILD).

	%siblings_with_atleast_one_common_parrent:
	siblinga1(NAME1, NAME2) :- 
		is_parent_of(PARENT, NAME1), is_parent_of(PARENT, NAME2),
		NAME1 \= NAME2.

	brothera1(BROTHER, NAME) :- is_male(BROTHER), siblinga1(BROTHER, NAME).
	sistera1(SISTER, NAME) :- is_female(SISTER), siblinga1(SISTER, NAME).
	

	%siblings_with_both_same_parrents:
	sibling2(NAME1, NAME2) :- 
		is_parent_of(PARENT1, NAME1), is_parent_of(PARENT1, NAME2),
		is_parent_of(PARENT2, NAME1), is_parent_of(PARENT2, NAME2), 
		PARENT1 \= PARENT2, NAME1 \= NAME2.

	brother2(BROTHER, NAME) :- is_male(BROTHER), sibling2(BROTHER, NAME).
	sister2(SISTER, NAME) :- is_female(SISTER), sibling2(SISTER, NAME).

	%sibling_with_only_one_same_parent:
	sibling1(NAME1, NAME2) :- 
		is_parent_of(PARENT1, NAME1), 
		is_parent_of(PARENT1, NAME2),
		NAME1 \= NAME2, not(sibling2(NAME1, NAME2)).

	brother1(BROTHER, NAME) :- 
		is_male(BROTHER), 
		sibling1(BROTHER, NAME), 
		BROTHER \= NAME.
	sister1(SISTER, NAME) :- 
		is_female(SISTER), 
		ibling1(SISTER, NAME), 
		SISTER \= NAME.
	

	%relatives:
	cousin(NAME1, NAME2) :- 
		is_parent_of(PARENT1, NAME1), 
		is_parent_of(PARENT2, NAME2), 
		PARENT1 \= PARENT2, 
		NAME1 \= NAME2, 
		siblinga1(PARENT1, PARENT2).
	aunt(AUNT, NAME) :- 
		cousin(COUSIN, NAME), 
		mother(AUNT, COUSIN), 
		COUSIN \= NAME.
	uncle(UNCLE, NAME) :- 
		cousin(COUSIN, NAME), 
		father(UNCLE, COUSIN), 
		COUSIN \= NAME.

	%grandparents:
	grandparent(GRANDPARENT, NAME) :- 
		is_parent_of(GRANDPARENT, PARENT), 
		is_parent_of(PARENT, NAME).
	grandfather(GRANDPARENT, NAME) :- 
		is_male(GRANDPARENT), 
		grandparent(GRANDPARENT, NAME).
	grandmother(GRANDPARENT, NAME) :- 
		is_female(GRANDPARENT), 
		grandparent(GRANDPARENT, NAME).
	grandchild(NAME, GRANDPARENT) :- 
		is_parent_of(PARENT, NAME), 
		is_parent_of(GRANDPARENT, PARENT).
	greatgrandparent(GREATGRANDPARENT, NAME) :- 
		is_parent_of(GREATGRANDPARENT, GRANDPARENT), 
		grandparent(GRANDPARENT, NAME).

	ancestor(ANCESTOR, NAME) :- 
		is_parent_of(ANCESTOR, NAME); 
		grandparent(ANCESTOR, NAME);
		greatgrandparent(ANCESTOR,NAME).
