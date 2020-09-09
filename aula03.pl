
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
lista([]).
lista([_|_]).


% Questão 1.2
tam([], 0).
tam([_ | T], X) :-
    tam(T, Y),
    X is Y + 1.


% Questão 1.3
tam_par([]).
tam_par([_, _ | L]) :-
    tam_par(L).

tam_impar([_]).
tam_impar([_, _ | L]) :-
    tam_impar(L).


% Questão 1.4
inverte([], []).
inverte([H | T], X) :-
    reverse(T, TR),
    conc(TR, [H], X).


% Questão 1.5
insete(X, L, L1) :-
    add(X, L, L1).
insere(X, [H | T], [H | L]) :-
    insere(X, T, L).


% Questão 1.6
roda([], []).
roda([H | T], L) :-
    conc(T, [H], L).


% Questão 1.7
achata([], []).
achata(X, [X]).
achata([H | T], L) :-
    achata(H, L1),
    achata(T, L2),
    conc(L1, L2, L).


% Questão 1.8
tamanho_igual([], []).
tamanho_igual([_ | T], [_ | T1]) :-
    tamanho_igual(T, T1).


% Questão 1.9
divide_lista([], [], []).
divide_lista([X], [X], []).
divide_lista([H1, H2 | T], [H1 | T1], [H2 | T2]) :-
    divide_lista(T, T1, T2).


% Questão 2
sublista([], _).
sublista([H | T1], [H | T2]) :-
    sublista(T1, T2).
sublista([H | T1], [_ | T2]) :-
    sublista([H | T1], T2).


% Questão 3
sublista2(S, L) :-
    conc(_, S, L2),
    conc(L2, _, L).


% Questão 4
prefixo(P, L) :-
    conc(P, _, L).

sufixo(S, L) :-
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
permutacao2([], []).
permutacao2([X | L], P) :-
    permutacao2(L, L1),
    insere(X, L1, P).


% Questão 8
subconjunto([], []).
subconjunto([H | S], [H | SS]) :-
    subconjunto(S, SS).
subconjunto([_ | S], SS) :-
    subconjunto(S, SS).


% Questão 9.1
max(X, Y, X) :-
    X >= Y.
max(X, Y, Y) :-
    Y > X.


% Questão 9.2
mdc(X, X, X).
mdc(X, Y, D) :-
    Y > X,
    Y1 is Y - X,
    mdc(X, Y1, D).
mdc(X, Y, D) :-
    X > Y,
    X1 is X - Y,
    mdc(X1, Y, D).


% Questão 9.3
max_lista([X], X).
max_lista([H | T], H) :-
    max_lista(T, X),
    H > X.
max_lista([H | T], X) :-
    max_lista(T, X),
    H =< X.


% Questão 9.4
soma_da_lista([], 0).
soma_da_lista([H | T], S) :-
    S = SS + H,
    soma_da_lista(T, SS).


% Questão 9.5
subsoma([], 0, _).
subsoma(S, X, SS) :-
    subconjunto(S, SS),
    soma_da_lista(SS, X).

% Questão 9.6

% Questão 10
