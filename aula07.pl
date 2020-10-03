tam([], N, N).
tam([_ | T], Acum, N):-
    Acum1 is Acum + 1,
    tam(T, Acum1, N).

conc([], L, L).
conc([X | L1], L2, [X | L3]) :-
    conc(L1, L2, L3).

conc_dl(A-B, B-C, A-C).

% Quicksort

quicksort([],[]).
quicksort([X | Xs], O) :-
    particiona(X, Xs, Menores, Maiores),
    quicksort(Menores, MenoresO),
    quicksort(Maiores, MaioresO),
    conc(MenoresO, [X | MaioresO], O).

particiona(_, [], [], []) :- !.
particiona(X, [Y | Ys], [Y | Menores], Maiores) :-
    X > Y, !,
    particiona(X, Ys, Menores, Maiores).
particiona(X, [Y | Ys], Menores, [Y | Maiores]) :-
    particiona(X, Ys, Menores, Maiores).

% Quicksort com diferença de listas

quicksort1(L, O) :-
    qsort1(L,O-[]).

qsort1([], Z - Z).
qsort1([X | Xs], A1 - Z) :-
    particiona(X, Xs, Menores, Maiores),
    qsort1(Menores, A1 - [X | A2]),
    qsort1(Maiores, A2 - Z).


% Quicksort com acumulador

qsort2([], Ac, Ac) :- !.
qsort2([X | Xs], Ac, O) :-
    particiona(X, Xs, Menores, Maiores),
    qsort2(Maiores, Ac, MaioresO),
    qsort2(Menores, [X | MaioresO], O).

quicksort2(L, O) :-
    qsort2(L, [], O).



% Questão 1

% adiciona_ao_fim1(L1, X, L3) :-
%     L2 = [X | C]-C,
%     conc_dl(L1, L2, L3).

adiciona_ao_fim(A - [C | X], C, A - X).
