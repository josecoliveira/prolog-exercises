% Questão 1

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Algoritmo sem motificações
% levou 215 segundos para rodar.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% alfametico([S,E,I,T,V,N]):-
%     unifica([0,1,2,3,4,5,6,7,8,9],[S,E,I,T,V,N]),
%     V \= 0,
%     1000*S + 100*E + 10*I + S +
%     1000*S + 100*E + 10*T + E +
%     1000*S + 100*E + 10*T + E =:=
%     10000*V + 1000*I + 100*N + 10*T + E.

% unifica(_,[]).
% unifica(Num,[N|Vars]):-
%     del(N,Num,NumSemN),
%     unifica(NumSemN,Vars).

% del(X,[X|Xs],Xs).
% del(Xs,[Y|Ys],[Y|Zs]):-
%     del(Xs,Ys,Zs).

% roda([S,E,I,S],[S,E,T,E],[S,E,T,E],[V,I,N,T,E]):-
%     alfametico([S,E,I,T,V,N]).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Algoritmo unficando V primeiro
% levou 37 milisegundos para rodar.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% alfametico([S,E,I,T,V,N]):-
%     unifica([0,1,2,3,4,5,6,7,8,9],[V,S,E,I,T,N]),
%     V \= 0,
%     1000*S + 100*E + 10*I + S +
%     1000*S + 100*E + 10*T + E +
%     1000*S + 100*E + 10*T + E =:=
%     10000*V + 1000*I + 100*N + 10*T + E.

% unifica(_,[]).
% unifica(Num,[N|Vars]):-
%     del(N,Num,NumSemN),
%     unifica(NumSemN,Vars).

% del(X,[X|Xs],Xs).
% del(Xs,[Y|Ys],[Y|Zs]):-
%     del(Xs,Ys,Zs).

% roda([S,E,I,S],[S,E,T,E],[S,E,T,E],[V,I,N,T,E]):-
%     alfametico([S,E,I,T,V,N]).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Algoritmo unficando V primeiro e apenas com 1 ou 2
% levou 33 milisegundos para rodar.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

alfametico([S,E,I,T,V,N]):-
    unifica([0,1,2,3,4,5,6,7,8,9],[V,S,E,I,T,N]),
    V \= 0,
    (V = 1; V = 2),
    1000*S + 100*E + 10*I + S +
    1000*S + 100*E + 10*T + E +
    1000*S + 100*E + 10*T + E =:=
    10000*V + 1000*I + 100*N + 10*T + E.

unifica(_,[]).
unifica(Num,[N|Vars]):-
    del(N,Num,NumSemN),
    unifica(NumSemN,Vars).

del(X,[X|Xs],Xs).
del(Xs,[Y|Ys],[Y|Zs]):-
    del(Xs,Ys,Zs).

roda([S,E,I,S],[S,E,T,E],[S,E,T,E],[V,I,N,T,E]):-
    alfametico([S,E,I,T,V,N]).

% Com certeza há vantagem, pois irá encontrar a solução primeiro desta forma.