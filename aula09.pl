% Questão 1.1

imprime_caracteres(_, 0) :- !.
imprime_caracteres(C, N) :-
    write(C),
    NovoN is N - 1,
    imprime_caracteres(C, NovoN).

tab(N) :-
    imprime_caracteres(' ', N).

mostra([], Tab) :-
    tab(Tab), write([]), nl.
mostra([E], Tab) :-
    tab(Tab), write(E), nl.
mostra([H, L, R], Tab) :-
    tab(Tab), write(H), nl,
    NovoTab is Tab + 2,
    mostra(L, NovoTab),
    mostra(R, NovoTab).
mostra(Tree) :-
    mostra(Tree, 0).

/*

1
  2
    4
      8
        []
        11
      9
    5
  3
    6
      10
      []
    7

*/

% Questão 1.2.1

visita(Valor, Tab) :-
    tab(Tab), write(Valor), nl.

prefixado([], Tab) :-
    visita([], Tab).
prefixado([E], Tab) :-
    visita(E, Tab).
prefixado([H, L, R], Tab) :-
    NewTab is Tab + 2,
    visita(H, Tab),
    prefixado(L, NewTab),
    prefixado(R, NewTab).
prefixado(Tree) :-
    prefixado(Tree, 0).

/*

1
  2
    4
      8
        []
        11
      9
    5
  3
    6
      10
      []
    7

*/


% Questão 1.2.2

simetrico([], Tab) :-
    visita([], Tab).
simetrico([E], Tab) :-
    visita(E, Tab).
simetrico([H, L, R], Tab) :-
    NewTab is Tab + 2,
    simetrico(L, NewTab),
    visita(H, Tab),
    simetrico(R, NewTab).
simetrico(Tree) :-
    simetrico(Tree, 0).

/*

        []
      8
        11
    4
      9
  2
    5
1
      10
    6
      []
  3
    7

*/

posfixado([], Tab) :-
    visita([], Tab).
posfixado([E], Tab) :-
    visita(E, Tab).
posfixado([H, L, R], Tab) :-
    NewTab is Tab + 2,
    posfixado(L, NewTab),
    posfixado(R, NewTab),
    visita(H, Tab).
posfixado(Tree) :-
    posfixado(Tree, 0).

/*

        []
        11
      8
      9
    4
    5
  2
      10
      []
    6
    7
  3
1

*/


% Questão 2

profundidade_1o_aux([]) :- !.
profundidade_1o_aux([[E, L, R] | T]) :-
    write(E), nl,
    append([L, R], T, NewT),
    profundidade_1o_aux(NewT).
profundidade_1o_aux([[E] | T]) :-
    write(E), nl,
    profundidade_1o_aux(T).
profundidade_1o_aux([[] | T]) :-
    write([]), nl,
    profundidade_1o_aux(T).

profundidade_1o(L) :-
    profundidade_1o_aux([L]).

/*
1
2
4
8
[]
11
9
5
3
6
10
[]
7

A ordem de visita é igual ao percurso prefixado.
*/

largura_1o_aux([]) :- !.
largura_1o_aux([[E, L, R] | T]) :-
    write(E), nl,
    append(T, [L, R], NewT),
    largura_1o_aux(NewT).
largura_1o_aux([[E] | T]) :-
    write(E), nl,
    largura_1o_aux(T).
largura_1o_aux([[] | T]) :-
    write([]), nl,
    largura_1o_aux(T).

largura_1o(L) :-
    largura_1o_aux([L]).

/*

1
2
3
4
5
6
7
8
9
10
[]
[]
11

A ordem de visita é diferente de todos os percursos anteriores.

*/