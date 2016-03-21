/**
*   Filename: 8_queens.pl
*   Author: Tony Tran
*
*   This program produces all possible solutions to 
*   the 8 Queens problem.
*/

queens([]).
queens([X/Y|Others]) :- 
    queens(Others),
    member(Y, [1,2,3,4,5,6,7,8]),
    secure(X/Y, Others).

secure(_,[]).
secure(X/Y,[X1/Y1|Others]) :- 
    Y =\= Y1,
    abs(Y1-Y) =\= abs(X1-X),
    secure(X/Y,Others).
                            
template([1/Y1,2/Y2,3/Y3,4/Y4,5/Y5,6/Y6,7/Y7,8/Y8]).
main(Solution) :- 
    template(Solution), queens(Solution).