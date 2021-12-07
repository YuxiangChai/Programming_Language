% 1

member1(X, [X|_]).
member1(X, [Y|Ys]) :- X \= Y, member1(X, Ys).

remove_items(_, [], []).
remove_items(I, [L|Ls], O) :- member1(L, I), !, remove_items(I, Ls, O).
remove_items(I, [L|Ls], [L|O]) :- remove_items(I, Ls, O).

% 2

% lst_set will convert a list to a set
lst_set([], []).
lst_set([X|L1], [X|L2]) :- \+ member1(X, L1), lst_set(L1, L2).
lst_set([X|L1], L2) :- member1(X, L1), lst_set(L1, L2).

% helper1 will find the intersection of two sets
helper1([], _, []).
helper1([X|S1], S2, O) :- \+ member1(X, S2), helper1(S1, S2, O).
helper1([X|S1], S2, [X|O]) :- member1(X, S2), helper1(S1, S2, O).

intersection2([], _, []).
intersection2(L1, L2, F) :- lst_set(L1, L3), lst_set(L2, L4), helper1(L3, L4, F).

% 3

% helper2 will find the union of two sets
helper2([], S2, S2).
helper2([X|S1], S2, O) :- member1(X, S2), helper2(S1, S2, O).
helper2([X|S1], S2, [X|O]) :- \+ member1(X, S2), helper2(S1, S2, O).

% helper3 will find the disjunct union of two sets
helper3([], _, []).
helper3([X|U], I, O) :- member1(X, I), helper3(U, I, O).
helper3([X|U], I, [X|O]) :- \+ member1(X, I), helper3(U, I, O).

disjunct_union(L1, L2, U) :- lst_set(L1, L3), lst_set(L2, L4), helper1(L3, L4, I), helper2(L3, L4, U1), helper3(U1, I, U).

% 4

my_flatten([], []).
my_flatten([X|L1], L2) :- my_flatten(X, NewX), my_flatten(L1, NewL1), append(NewX, NewL1, L2).
my_flatten(L1, [L1]).

% 5

compress([], []).
compress([X], [X]).
compress([X, X|L1], L2) :- compress([X|L1], L2).
compress([X1, X2|L1], [X1|L2]) :- X1 \= X2, compress([X2|L1], L2).

% 6

encode([], []).
encode([X], [[1, X]]).
encode([X, X|L1], [[G|Ys]|L2]) :- encode([X|L1], [[Y|Ys]|L2]), G is Y+1.
encode([X, Z|L1], [[1, X]|L2]) :- X \= Z, encode([Z|L1], L2).

% 7

encode_modified([], []).
encode_modified([X], [X]).
encode_modified([X, X|L1], [[G|Ys]|L2]) :- encode_modified([X|L1], [[Y|Ys]|L2]), G is Y+1.
encode_modified([X, X|L1], [[2, Y]|L2]) :- encode_modified([X|L1], [Y|L2]).
encode_modified([X, Z|L1], [X|L2]) :- X \= Z, encode_modified([Z|L1], L2).

% 8

% length1 will find the length of a list.
length1([], 0).
length1([_|Xs], L) :- length1(Xs, L1), L is L1+1.

rotate([X|L1], 1, L2) :- append(L1, [X], L2).
rotate([X|L1], N, L2) :- N > 0, append(L1, [X], L3), M is N-1, rotate(L3, M, L2).
rotate(L1, N, L2) :- N =< 0, length1(L1, Le), P is Le+N, rotate(L1, P, L2).