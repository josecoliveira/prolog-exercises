% Questão 1

% valid_position([X, Y], D) :-
%     X >= 0,
%     Y >= 0,
%     X < D,
%     Y < D.

% jump([X1, Y2]), D, [X1 + 1, Y1 + 2]) :-
%     valid_position

% Questão 2

todas_ocorrencias(_, [], _, []) :- !.
todas_ocorrencias(Elemento, [Elemento | Lista], Posicao, NovaListaOcorrencias) :-
    NovaPosicao is Posicao + 1,
    todas_ocorrencias(Elemento,  Lista, NovaPosicao, ListaOcorrencias),
    append(ListaOcorrencias, [Posicao], NovaListaOcorrencias).
todas_ocorrencias(Elemento, [_ | Lista], Posicao, ListaOcorrencias) :-
    NovaPosicao is Posicao + 1,
    todas_ocorrencias(Elemento, Lista, NovaPosicao, ListaOcorrencias). 



