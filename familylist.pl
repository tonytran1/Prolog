/**
*	Filename: familylist.pl
*	Author: Tony Tran
*
*	This prolog program contains facts and rules loosely based on
*	my family members using list concepts.
*/

%Facts:

    m([ tony, hanry, danny, mark, bob, ken, bang, tuan, theu, dinh ]).
    f([ diane, hanh, jess, ann, liu, thien, noi ]).
    family([ danny, hanh, [tony, hanry, diane] ]).
    family([ bob, jess, [ken, ann] ]).
    family([ bang, liu, [danny] ]).
    family([ tuan, thien, [hanh] ]).
    family([ theu, thien, [jess, mark] ]).
    family([ dinh, noi, [tuan] ]).

%Rules:

    %Member
    member1(X, [X|_]).
    member1(X, [_|T]) :- member1(X,T).
        
    %Gender:
    male(MALE) :- 
        m(LIST), member1(MALE,LIST).
    female(FEMALE) :- 
        f(LIST), member1(FEMALE,LIST).

    %Parents:
    father(FATHER, CHILD) :- 
        family([FATHER,_, LIST]), 
        member1(CHILD,LIST).
    mother(MOTHER, CHILD) :- 
        family([_,MOTHER, LIST]), 
        member1(CHILD,LIST).
    parent(PARENT, CHILD) :- 
        father(PARENT, CHILD);
        mother(PARENT, CHILD).
                         
    %Siblings_With_Both_Same_Parents:
    siblings2(NAME1, NAME2) :- 
        parent(PARENT1, NAME1), 
        parent(PARENT1, NAME2), 
        parent(PARENT2, NAME1), 
        parent(PARENT2, NAME2), 
        PARENT1 \= PARENT2, 
        NAME1 \= NAME2.
        
    brother2(BROTHER, NAME) :- 
        siblings2(BROTHER, NAME), 
        male(BROTHER).
    sister2(SISTER, NAME) :- 
        siblings2(SISTER, NAME), 
        female(SISTER).
    
	%Siblings_With_Only_One_Common_Parent:
        siblings1(NAME1, NAME2) :- 
        parent(PARENT, NAME1), 
        parent(PARENT, NAME2), 
        NAME1 \= NAME2,
        not(siblings2(NAME1,NAME2)).
    brother1(BROTHER, NAME) :- 
        siblings1(BROTHER, NAME),
        male(BROTHER).
    sister1(SISTER, NAME) :- 
        siblings1(SISTER, NAME),
        female(SISTER).
                             
    %Siblings_With_Atleast_One_Common_Parent:
    siblingsa1(NAME1, NAME2) :- 
        parent(PARENT, NAME1),
        parent(PARENT, NAME2),
        NAME1 \= NAME2.
        
    %Relatives:
    cousin(NAME1, NAME2) :- 
        parent(PARENT1, NAME1), 
        parent(PARENT2, NAME2),
        siblingsa1(PARENT1, PARENT2).
    uncle(UNCLE, NAME) :- 
        cousin(COUSIN, NAME), 
        parent(UNCLE, COUSIN),
        male(UNCLE).
    aunt(AUNT, NAME) :- 
        cousin(COUSIN, NAME), 
        parent(AUNT, COUSIN),
        female(AUNT).
                        
    %Grandparents:
    grandparent(GRANDPARENT, NAME) :- 
        parent(GRANDPARENT, PARENT),
        parent(PARENT, NAME).
    greatgrandparent(GGP, NAME) :- 
        parent(GGP, GRANDPARENT),
        grandparent(GRANDPARENT, NAME).
    grandchild(GRANDCHILD, GRANDPARENT) :- 
        parent(PARENT, GRANDCHILD),
        parent(GRANDPARENT, PARENT).
    grandson(GRANDSON, GRANDPARENT) :- 
        grandchild(GRANDSON,GRANDPARENT), 
        male(GRANDSON).
    granddaughter(GRANDDAUGHTER, GRANDPARENT) :- 
        grandchild(GRANDDAUGHTER, GRANDPARENT), 
        female(GRANDDAUGHTER).
    ancestor(ANCESTOR, NAME) :- 
        parent(ANCESTOR, NAME);
        grandparent(ANCESTOR, NAME);
        greatgrandparent(ANCESTOR, NAME).