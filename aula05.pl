% Questão 1

p(1).
p(2) :- !.
p(3).

% 1.1
%   X = 1;
%   X = 2.

% 1.2
%   X = 1, Y = 1;
%   X = 1, Y = 2;
%   X = 2, Y = 1;
%   X = 2, Y = 2.

% 1.3
%   X = 1, Y = 1;
%   X = 1, Y = 2.


% Questão 2

classe(Int, zero) :- Int = 0, !.
classe(Int, positivo) :- Int > 0, !.
classe(Int, negativo) :- Int < 0.


% Questão 3

separa1([], [], []).
separa1([Primeiro | Lista], [Primeiro | ListaPositivos], ListaNegativos) :-
    Primeiro > 0,
    separa1(Lista, ListaPositivos, ListaNegativos).
separa1([Primeiro | Lista], ListaPositivos, [Primeiro | ListaNegativos]) :-
    Primeiro < 0,
    separa1(Lista, ListaPositivos, ListaNegativos).

separa2([], [], []) :- !.
separa2([Primeiro | Lista], [Primeiro | ListaPositivos], ListaNegativos) :-
    Primeiro > 0, !,
    separa2(Lista, ListaPositivos, ListaNegativos).
separa2([Primeiro | Lista], ListaPositivos, [Primeiro | ListaNegativos]) :-
    Primeiro < 0,
    separa2(Lista, ListaPositivos, ListaNegativos).


% Questão 4

% member(Item, Candidatos), \+ member(Item, Excluidos).


% Questão 5

dif_conj([], _, []) :- !.
dif_conj([Item | Conj1], Conj2, [Item | Dif]) :-
    \+ member(Item, Conj2), !,
    dif_conj(Conj1, Conj2, Dif).
dif_conj([_ | Conj1], Conj2, Dif) :-
    dif_conj(Conj1, Conj2, Dif).


% Questão 6

unificavel([], _, []).
unificavel([Primeiro | Lista1], Termo, Lista2) :-
    \+ (Primeiro = Termo), !,
    unificavel(Lista1, Termo, Lista2).
unificavel([Primeiro | Lista1], Termo, [Primeiro | Lista2]) :-
    unificavel(Lista1, Termo, Lista2).
