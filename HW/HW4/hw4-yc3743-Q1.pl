% Original order
% 
% male(brian).
% male(kevin).
% male(zhane).
% male(fred).
% male(jake).
% male(bob).
% male(stephen).
% male(tom).
% male(paul).
% 
% parent(melissa,brian).
% parent(mary,sarah).
% parent(stephen,jennifer).
% parent(bob,jane).
% parent(paul,kevin).
% parent(tom,mary).
% parent(jake,bob).
% parent(zhane,melissa).
% parent(tom,stephen).
% parent(stephen,paul).
% parent(emily,bob).
% parent(zhane,mary).
% 
% grandfather(X,Y) :- male(X), parent(X,Z),parent(Z,Y).


% My order. I placed parent(tom,stephen). before parent(tom,mary).

male(brian).
male(kevin).
male(zhane).
male(fred).
male(jake).
male(bob).
male(stephen).
male(tom).
male(paul).

parent(melissa,brian).
parent(mary,sarah).
parent(stephen,jennifer).
parent(bob,jane).
parent(paul,kevin).
parent(tom,stephen).
parent(tom,mary).
parent(jake,bob).
parent(zhane,melissa).
parent(stephen,paul).
parent(emily,bob).
parent(zhane,mary).

grandfather(X,Y) :- male(X), parent(X,Z), parent(Z,Y).

% question 4 rules.

uncle(X, Y) :- male(X), grandfather(Z, Y), parent(Z, X).
aunt(X, Y) :- \+ male(X), grandfather(Z, Y), parent(Z, X).