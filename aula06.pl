% Questão 1

listaTermos(Expressao, [Expressao]) :-
    number(Expressao), !; atom(Expressao).
listaTermos(Expressao, [TermoExpressao | Lista]) :-
    callable(Expressao),
    Expressao =.. [+, Expressao2, TermoExpressao],
    listaTermos(Expressao2, Lista).

contaRemoveVariavel(_, [], 0, []) :- !.
contaRemoveVariavel(Variavel, [Primeiro | Lista1], NovoN, Lista2) :-
    Variavel = Primeiro, !,
    contaRemoveVariavel(Variavel, Lista1, N, Lista2),
    NovoN is N + 1.
contaRemoveVariavel(Variavel, [Primeiro | Lista1], N, [Primeiro | Lista2]) :-
    contaRemoveVariavel(Variavel, Lista1, N, Lista2).

contaRemoveNumeros([], 0, []) :- !.
contaRemoveNumeros([Numero | Lista1], NovoN, Lista2) :-
    number(Numero), !,
    contaRemoveNumeros(Lista1, N, Lista2),
    NovoN is N + Numero.
contaRemoveNumeros([NaoNumero | Lista1], N, [NaoNumero | Lista2]) :-
    contaRemoveNumeros(Lista1, N, Lista2).

simplificaLista([], 0) :- !.
simplificaLista([Primeiro | Lista], NovaExpressao) :-
    atom(Primeiro), !,
    contaRemoveVariavel(Primeiro, Lista, QuantidadeNaLista, NovaLista),
    simplificaLista(NovaLista, Expressao),
    Quantidade is QuantidadeNaLista + 1,
    (Expressao = 0 ->
        (Quantidade = 1 ->
            NovaExpressao = Primeiro
        ;
            NovaExpressao = Quantidade * Primeiro)
    ;
        (Quantidade = 1 ->
            NovaExpressao = Primeiro + Expressao
        ;
            NovaExpressao = Quantidade * Primeiro + Expressao)).
simplificaLista([Primeiro | Lista], NovaExpressao) :-
    number(Primeiro),
    contaRemoveNumeros(Lista, SomaLista, NovaLista),
    simplificaLista(NovaLista, Expressao),
    Soma is SomaLista + Primeiro,
    (Soma = 0 ->
        NovaExpressao = Expressao
    ;
        NovaExpressao = Expressao + Soma).

simplifica(Expressao, Simplificada) :-
    listaTermos(Expressao, ListaExpressao),
    simplificaLista(ListaExpressao, Simplificada).
    

% Questão 2


% Questão 3

aterrado(Termo) :-
    atom(Termo), !.
aterrado(Termo) :-
    callable(Termo),
    Termo =.. L,
    forall(member(A, L), aterrado(A)).


% Questão 4

% substituir(Termo, Termo, Termo1, Termo1) :- !.
% substituir(_, Termo, _, Termo) :-
%     atomic(Termo), !.
% subsituir(Sub, Termo, Sub1, Termo1) :-
%     Termo =.. [F | Args],
%     subst_lista(Sub, Args, Sub1, Args1),
%     Termo1 =.. [F | Args1].

% % subst_lista(_, [], _, []) :- !.
% % subst_lista(Sub, [Termo | Termos], Sub1, [Termo1 | Termos1]) :-
% %     substituir(Sub, Termo, Sub1, Termo1),
% %     subst_lista(Sub, Termos, Sub1, Termos1).

% subst_lista(_, [], _, []) :- !.
% subst_lista(Sub, [Termo | Termos], Sub1, [Termo1 | Termos1]) :-
%     substituir(Sub, Termo, Sub1, Termo1).
% subst_lista(Sub, [_ | Termos], Sub1, Termos1) :-
%     subst_lista(Sub, Termos, Sub1, Termos1).


% Questão 5

subsume(X, Y) :-
    atomic(X), !,
    X = Y.
subsume(X, Y) :-
    var(X), !,
    X = Y.
subsume(X, Y) :-
    callable(X), !,
    X =.. L1,
    Y =.. L2,
    subsumeLista(L1, L2).

subsumeLista([], []) :- !.
subsumeLista([X | L1], [Y | L2]) :-
    subsume(X, Y),
    subsumeLista(L1, L2).


% Questão 6

tabuadas:-
    L = [0,1,2,3,4,5,6,7,8,9],
    member(X,L),
    member(Y,L),
    Z is X*Y,
    assertz(produto(X,Y,Z)),
    fail.

% retractall(produto(X, Y, Z)), fail.

% Item 6.6.
% retractall(produto(X, Y, 0)), fail.


% Questão 7


% Questão 8

subconjunto([], []).
subconjunto([H | S], [H | SS]) :-
    subconjunto(S, SS).
subconjunto([_ | S], SS) :-
    subconjunto(S, SS).

subconjuntos(Conj,  Subconjs) :-
    bagof(X, subconjunto(Conj, X), Subconjs).


% Questão 10

imprime_caracteres(_, 0) :- !.
imprime_caracteres(C, N) :-
    write(C),
    NovoN is N - 1,
    imprime_caracteres(C, NovoN).

imprime_triangulo(I, F) :-
    I =< F,
    NumCaracteres is 2 * F - 1,
    NumAsteriscos is 1 + 2 * (I - 1),
    NumEspacos is (NumCaracteres - NumAsteriscos) / 2,
    imprime_caracteres(' ', NumEspacos),
    imprime_caracteres('*', NumAsteriscos),
    imprime_caracteres(' ', NumEspacos),
    (I \= F -> nl),
    I2 is I + 1,
    imprime_triangulo(I2, F).

triangulo(N) :-
    imprime_triangulo(1, N).
