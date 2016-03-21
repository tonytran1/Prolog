/**
*	Filename: schedule.pl
*	Author: Tony Tran
*
*	This program provides rules for information regarding 
*	instructors at SFSU and the classes they instruct.
*/

%facts:
	%classes:
	freshman(csc210).
	freshman(csc256).
	sophomore(csc340).
	junior(csc413).
	junior(csc415).
	senior(csc600).
	senior(csc648).
	
	%instructors:
	teaches(souza, csc210).
	teaches(sosnick, csc256).
	teaches(potter, csc340).
	teaches(sosnick, csc413).
	teaches(fuhrman, csc415).
	teaches(dujmovic, csc600).
	teaches(sosnick, csc648).

	%day:
	morning(csc210).
	morning(csc256).
	morning(csc340).
	morning(csc600).
	afternoon(csc415).
	afternoon(csc413).
	afternoon(csc648).

	%time:
	mwf(csc210).
	mwf(csc256).
	mwf(csc340).
	mwf(csc600).
	mwf(csc413).
	f(csc648).
	tth(csc415).

%rules:
	%undergraduate_level:
	teaches_freshman(INSTRUCTOR) :- freshman(CLASS), teaches(INSTRUCTOR, CLASS). 
	teaches_sophomore(INSTRUCTOR) :- sophomore(CLASS), teaches(INSTRUCTOR, CLASS).
	teaches_junior(INSTRUCTOR) :- junior(CLASS), teaches(INSTRUCTOR, CLASS).
	teaches_senior(INSTRUCTOR) :- senior(CLASS), teaches(INSTRUCTOR, CLASS).

	%times_worked:
	teaches_morning(INSTRUCTOR) :- morning(CLASS), teaches(INSTRUCTOR, CLASS).
	teaches_afternoon(INSTRUCTOR) :- afternoon(CLASS), teaches(INSTRUCTOR, CLASS).
	teaches_whole_day(INSTRUCTOR) :- teaches_morning(INSTRUCTOR), teaches_afternoon(INSTRUCTOR).

	%days_worked
	works_mwf(INSTRUCTOR) :- mwf(CLASS), teaches(INSTRUCTOR, CLASS).
	works_tth(INSTRUCTOR) :- tth(CLASS), teaches(INSTRUCTOR, CLASS).
	teaches_three_classes(INSTRUCTOR) :- teaches(INSTRUCTOR, CLASS1), teaches(INSTRUCTOR, CLASS2), 
                                         teaches(INSTRUCTOR, CLASS3), 
                                         CLASS1 \= CLASS2, CLASS2 \= CLASS3, CLASS1 \= CLASS3.
	
