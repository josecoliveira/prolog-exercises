% Questão 1

% conc_dl(A-B, B-C, A-C).

% adiciona_ao_fim1(L1, X, L3) :-
%     L2 = [X | C]-C,
%     conc_dl(L1, L2, L3).

adiciona_ao_fim(A - [C | X], C, A - X).


% Questão 3


% Questão 4

maxdl([], Max, Max).
maxdl([Primeiro | Lista], Max, MaxF) :-
    (Primeiro > Max ->
        NovoMax = Primeiro
    ;
        NovoMax = Max),
    maxdl(Lista, NovoMax, MaxF).


% Questão 5




