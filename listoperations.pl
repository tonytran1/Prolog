/**
*   Filename:listoperations.pl
*   Author: Tony Tran
*
*   This program contains list operations without the use
*   of library functions.
*/

is_member(X, [X|_]). 
is_member(X, [_|T]) :- 
    is_member(X, T).

is_first_element(X, [X|_]).

is_last_element(X,[X]).
is_last_element(X,[_|T]) :- 
    is_last_element(X,T).

is_two_adjacent(X, Y, [X,Y|_]).
is_two_adjacent(X, Y, [_|T]) :- 
    is_two_adjacent(X, Y, T).

is_three_adjacent(X, Y, Z, [X,Y,Z|_]).
is_three_adjacent(X, Y, Z, [_|T]) :- 
    is_three_adjacent(X, Y, Z, T).

append_list([], L2, L2). 
append_list([X|T1], L2, [X|T3]):- 
    append_list(T1,L2,T3).

delete_element(X, [X|T], T).
delete_element(X, [H|T], [H|T1]) :- 
    delete_element(X, T, T1).

append_element(L, [], [L]).
append_element(E, [X|T1], [X|T3]) :- 
    append_list(T1,[E],T3).

insert_element(X, L, XL) :- 
    delete_element(X, XL, L).

list_length([], 0).
list_length([_|T], N) :- 
    list_length(T, N1), N is 1 + N1.

accRev([H|T],A,R):-  accRev(T,[H|A],R). 
accRev([],A,A).
reverse_list(L,R):-  accRev(L,[],R).

is_palindrome(L) :- 
    reverse_list(L,R), 
    L == R.

display([]).
display([H|T]) :- 
    write(H), write(,), 
    tab(1), display(T).
