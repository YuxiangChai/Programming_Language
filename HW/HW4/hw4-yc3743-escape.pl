cross1(tokyo, 5).
cross1(rio, 10).
cross1(berlin, 20).
cross1(denver, 25).


left_same([], _).
left_same([X|L1], L2) :- member(X, L2), left_same(L1, L2).
same_list(L1, L2) :- left_same(L1, L2), left_same(L2, L1).

r([]).
r([_|L]) :- r(L).
l(_).

% 1

time(P, T) :- cross1(P, T).

% 2

team([berlin, denver, rio, tokyo]).

% 3

cost([], 0).
cost([X|L], C) :- cost(L, C1), time(X, T), T > C1, C = T.
cost([X|L], C) :- cost(L, C1), time(X, T), T =< C1, C = C1.

% 4

split(L,[X,Y],M) :- member(X,L), member(Y,L), compare(<,X,Y), subtract(L,[X,Y],M).

list_right([], Lr) :- team(Lr).
list_right([X|L1], Lr) :- list_right(L1, L2), subtract(L2, [X], Lr).

move(st(l,L1), st(r,L2), r(M), C) :- split(L1, [X, Y], L2), M=[X, Y], cost(M, C).

move(st(r,L1), st(l,L2), l(M), C) :- list_right(L1, Lr), member(M, Lr), append(L1, [M], L2), time(M, C).

% 5

trans(st(r, []), st(r, []), [], 0).
trans(I, F, [M|Ms], C) :- move(I, P, M, C1), trans(P, F, Ms, C2), C is C1+C2.


cross(M,D) :- team(T), trans(st(l,T),st(r,[]),M,D0), D0=<D.

solution(M) :- cross(M,60).