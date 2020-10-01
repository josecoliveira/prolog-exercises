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
