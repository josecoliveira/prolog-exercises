
member(X, [X | _]).
member(X, [_ | T]) :-
    member(X, T).

conc([], L, L).
conc([X | L1], L2, [X | L3]) :-
    conc(L1, L2, L3).

add(X, L, [X | L]).

del(X, [X | T], T).
del(X, [Y | T], [Y | T1]) :-
    del(X, T, T1).

sublist(S, L) :-
    conc(_, L2, L),
    conc(S, _, L2).

permutation([], []).
permutation(L, [X | P]) :-
    del(X, L, L1),
    permutation(L1, P).


% Questão 1.1 
list([]).
list([_|_]).


% Questão 1.2
length_([], 0).
length_([_ | T], X) :-
    length_(T, Y),
    X is Y + 1.


% Questão 1.3 - 3.2 - 95 - 671
evenlength([]).
evenlength([_, _ | L]) :-
    evenlength(L).

oddlength([_]).
oddlength([_, _ | L]) :-
    oddlength(L).


% Questão 1.4 - 3.4 - 95 - 671
reverse([], []).
reverse([H | T], X) :-
    reverse(T, TR),
    conc(TR, [H], X).


% Questão 1.5 -
insert(X, L, L1) :-
    add(X, L, L1).
insert(X, [H | T], [H | L]) :-
    insert(X, T, L).


% Questão 1.6 - 3.6 - 95 - 671
shift([], []).
shift([H | T], L) :-
    conc(T, [H], L).


% Questão 1.7 - 3.11 - 96 - 672
flatten2([], []).
flatten2(X, [X]).
flatten2([H | T], L) :-
    flatten2(H, L1),
    flatten2(T, L2),
    conc(L1, L2, L).


% Questão 1.8 - 3.10 - 96 - 672
equal_length([], []).
equal_length([_ | T], [_ | T1]) :-
    equal_length(T, T1).


% Questão 1.9 - 3.9 - 96 - 672
dividelist([], [], []).
dividelist([X], [X], []).
dividelist([H1, H2 | T], [H1 | T1], [H2 | T2]) :-
    dividelist(T, T1, T2).


% Questão 2
sublist2([], _).
sublist2([H | T1], [H | T2]) :-
    sublist2(T1, T2).
sublist2([H | T1], [_ | T2]) :-
    sublist2([H | T1], T2).


% Questão 3
sublist3(S, L) :-
    conc(_, S, L2),
    conc(L2, _, L).


% Questão 4
prefix(P, L) :-
    conc(P, _, L).

suffix(S, L) :-
    conc(_, S, L).


% Questão 5
% sublist(S, L) :-
%     conc(_, L2, L),
%     conc(S, _, L2).


% Questão 6
% sublist2([], _).
% sublist2([H | T1], [H | T2]) :-
%     sublist2(T1, T2).
% sublist2([H | T1], [_ | T2]) :-
%     sublist2([H | T1], T2).


% Questão 7
permutation_([], []).
permutation_([X | L], P) :-
    permutation_(L, L1),
    insert(X, L1, P).


% Questão 8 - 3.8 - 96 - 671
subset([], []).
subset([H | S], [H | SS]) :-
    subset(S, SS).
subset([_ | S], SS) :-
    subset(S, SS).


% Questão 9.1 - 3.16 - 106 - 673
max(X, Y, X) :-
    X >= Y.
max(X, Y, Y) :-
    Y > X.


% Questão 9.2 - 82
gcd(X, X, X).
gcd(X, Y, D) :-
    Y > X,
    Y1 is Y - X,
    gcd(X, Y1, D).
gcd(X, Y, D) :-
    X > Y,
    X1 is X - Y,
    gcd(X1, Y, D).


% Questão 9.3 - 3.17 - 107 - 673
maxlist([X], X).
maxlist([H | T], H) :-
    maxlist(T, X),
    H > X.
maxlist([H | T], X) :-
    maxlist(T, X),
    H =< X.


% Questão 9.4 - 3.18 - 107 - 673
sumlist_([], 0).
sumlist_([H | T], S) :-
    S = SS + H,
    sumlist_(T, SS).


% questão 9.5 - 3.20 - 107 - 673
subsum([], 0, _).
subsum(S, X, SS) :-
    subset(S, SS),
    sumlist(SS, X).


% Questão 10
