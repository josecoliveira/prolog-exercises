% Questão 1

% valid_position([X, Y], D) :-
%     X >= 0,
%     Y >= 0,
%     X < D,
%     Y < D.

% jump([X1, Y2]), D, [X1 + 1, Y1 + 2]) :-
%     valid_position

% Questão 2

todas_ocorrencias(_, [], []) :- !.
todas_ocorrencias(Elemento, [Elemento | Lista], [Elemento | ListaOcorrencias]) :-
    todas_ocorrencias(Elemento, Lista, ListaOcorrencias), !.
todas_ocorrencias(Elemento, [_ | Lista], ListaOcorrencias) :-
    todas_ocorrencias(Elemento, Lista, ListaOcorrencias).


% Questão 3

frequencia(_, [], 0) :- !.
frequencia(Elemento, [Primeiro | Lista], NovaFrequencia) :-
    Elemento = Primeiro,
    frequencia(Elemento, Lista, Frequencia),
    NovaFrequencia is Frequencia + 1, !.
frequencia(Elemento, [Primeiro | Lista], Frequencia) :-
    Elemento \= Primeiro,
    frequencia(Elemento, Lista, Frequencia).

% Questão 4

nao_ocorre(_, [], []) :- !.
nao_ocorre(Elemento, [Primeiro | Lista], [Primeiro | ListaNaoOcorrencias]) :-
    Elemento \== Primeiro, !,
    nao_ocorre(Elemento, Lista, ListaNaoOcorrencias).
nao_ocorre(Elemento, [Primeiro | Lista], ListaNaoOcorrencias) :-
    Elemento == Primeiro,
    nao_ocorre(Elemento, Lista, ListaNaoOcorrencias).


% Questão 5

freq_nao_ocorre(_, [], 0) :- !.
freq_nao_ocorre(Elemento, [Primeiro | Lista], NovaFrequencia) :-
    Elemento \= Primeiro, !,
    freq_nao_ocorre(Elemento, Lista, Frequencia),
    NovaFrequencia is Frequencia + 1.
freq_nao_ocorre(Elemento, [Primeiro | Lista], Frequencia) :-
    Elemento = Primeiro,
    freq_nao_ocorre(Elemento, Lista, Frequencia).


% Questão 6