set_element_at_nth0([_ | List1], CurrentIndex, Index, Elem, List2) :-
    CurrentIndex = Index,
    List2 = [Elem | List1].
set_element_at_nth0([First | List1], CurrentIndex, Index, Elem, List2) :-
    NextIndex is CurrentIndex + 1,
    set_element_at_nth0(List1, NextIndex, Index, Elem, List3),
    List2 = [First | List3].

/* set_element_at_nth0(+List1, +Index, +Elem, -List2)
 * Altera o elemento de List1 no Index para o Elem, gerando List2. */
set_element_at_nth0(List1, Index, Elem, List2) :-
    set_element_at_nth0(List1, 0, Index, Elem, List2).


/* winning_sequence(?Sequence)
 * É verdade se Sequence representa uma lista de índices que formam uma 
 * senquencia vencedora no Qubic. */
% Diagonais através dos planos
winning_sequence([0, 21, 42, 63]).
winning_sequence([3, 22, 41, 60]).
winning_sequence([12, 25, 38, 51]).
winning_sequence([15, 26, 37, 48]).
% Diagonais dentro de um plano
winning_sequence([0, 5, 10, 11]).
winning_sequence([3, 6, 9, 12]).
winning_sequence([16, 21, 26, 31]).
winning_sequence([19, 22, 25, 28]).
winning_sequence([32, 37, 42, 47]).
winning_sequence([35, 38, 41, 44]).
winning_sequence([48, 53, 58, 63]).
winning_sequence([51, 54, 57, 60]).
winning_sequence([0, 20, 40, 60]).
winning_sequence([12, 24, 36, 48]).
winning_sequence([1, 21, 41, 61]).
winning_sequence([13, 25, 37, 49]).
winning_sequence([2, 22, 42, 62]).
winning_sequence([14, 26, 38, 50]).
winning_sequence([3, 23, 43, 63]).
winning_sequence([15, 27, 39, 51]).
winning_sequence([0, 17, 34, 51]).
winning_sequence([3, 18, 33, 48]).
winning_sequence([4, 21, 38, 55]).
winning_sequence([7, 22, 37, 52]).
winning_sequence([8, 25, 42, 59]).
winning_sequence([11, 26, 41, 56]).
winning_sequence([12, 29, 46, 63]).
winning_sequence([15, 30, 45, 60]).
% Eixo x (linhas através dos tabuleiros)
winning_sequence([0, 16, 32, 48]).
winning_sequence([1, 17, 33, 49]).
winning_sequence([2, 18, 34, 50]).
winning_sequence([3, 19, 35, 51]).
winning_sequence([4, 20, 36, 52]).
winning_sequence([5, 21, 37, 53]).
winning_sequence([6, 22, 38, 54]).
winning_sequence([7, 23, 39, 55]).
winning_sequence([8, 24, 40, 56]).
winning_sequence([9, 25, 41, 57]).
winning_sequence([10, 26, 42, 58]).
winning_sequence([11, 27, 43, 59]).
winning_sequence([12, 28, 44, 60]).
winning_sequence([13, 29, 45, 61]).
winning_sequence([14, 30, 46, 62]).
winning_sequence([15, 31, 47, 63]).
% Eixo y (linhas verticais dentro de um tabuleiro)
winning_sequence([0, 4, 8, 12]).
winning_sequence([1, 5, 9, 13]).
winning_sequence([2, 6, 10, 14]).
winning_sequence([3, 7, 11, 15]).
winning_sequence([16, 20, 24, 28]).
winning_sequence([17, 21, 25, 29]).
winning_sequence([18, 22, 26, 30]).
winning_sequence([19, 23, 27, 31]).
winning_sequence([32, 36, 40, 44]).
winning_sequence([33, 37, 41, 45]).
winning_sequence([34, 38, 42, 46]).
winning_sequence([35, 39, 43, 47]).
winning_sequence([48, 52, 56, 60]).
winning_sequence([49, 53, 57, 61]).
winning_sequence([50, 54, 58, 62]).
winning_sequence([51, 55, 59, 63]).
% Eixo z (linhas horizontais dentro de um tabuleiro)
winning_sequence([0, 1, 2, 3]).
winning_sequence([4, 5, 6, 7]).
winning_sequence([8, 9, 10, 11]).
winning_sequence([12, 13, 14, 15]).
winning_sequence([16, 17, 18, 19]).
winning_sequence([20, 21, 22, 23]).
winning_sequence([24, 25, 26, 27]).
winning_sequence([28, 29, 30, 31]).
winning_sequence([32, 33, 34, 35]).
winning_sequence([36, 37, 38, 39]).
winning_sequence([40, 41, 42, 43]).
winning_sequence([44, 45, 46, 47]).
winning_sequence([48, 49, 50, 51]).
winning_sequence([52, 53, 54, 55]).
winning_sequence([56, 57, 58, 59]).
winning_sequence([60, 61, 62, 63]).


/* query_symbols_by_indexes(+Indexes, +Board, -Symbols)
 * As posições na lista Indexes em Board correspondem aos símbolos na lista 
 * Symbols */
query_symbols_by_indexes([], _, []) :- !.
query_symbols_by_indexes([Index | Indexes], Board, [Symbol | Symbols]) :-
    nth0(Index, Board, Symbol),
    query_symbols_by_indexes(Indexes, Board, Symbols).


/* child(+Board, +Turn, -Child)
 * Dado o tabuleiro Board, se Turn ('X' ou 'O') jogar em alguma posição vazia
 * de Board, irá gerar Child */
child(Board, Turn, Child) :-
    nth0(Index, Board, ' '),
    set_element_at_nth0(Board, 0, Index, Turn, Child).


children(Board, _, []) :-
    bagof(Symbols, Indexes^(
        winning_sequence(Indexes),
        query_symbols_by_indexes(Indexes, Board, Symbols),
        (Symbols = ['X', 'X', 'X', 'X']; Symbols = ['O', 'O', 'O', 'O'])),
        Sequences), !,
    Sequences \= [].
children(Board, Turn, Children) :-
    (   bagof(Child, Turn^child(Board, Turn, Child), Children), !
    ;   Children = []).


max(A, B, A) :-
    A >= B, !.
max(A, B, B) :-
    B > A.


min(A, B, A) :-
    A =< B, !.
min(A, B, B) :-
    B < A.


ab_max_children([], _, _, Max, Max).
ab_max_children([Child | Children], Alpha, Beta, Max1, Max) :-
    ab_minimax(min, Child, Alpha, Beta, Score),
    (   Score > Beta ->
        Max = Beta
    ;   max(Score, Alpha, Alpha1),
        max(Score, Max1, Max2),
        ab_max_children(Children, Alpha1, Beta, Max2, Max)).


ab_min_children([], _, _, Min, Min).
ab_min_children([Child | Children], Alpha, Beta, Min1, Min) :-
    ab_minimax(max, Child, Alpha, Beta, Score),
    (   Alpha > Score ->
        Min = Alpha
    ;   min(Score, Beta, Beta1),
        min(Score, Min1, Min2),
        ab_min_children(Children, Alpha, Beta1, Min2, Min)).


ab_minimax(max, Board, Alpha, Beta, Score) :-
    children(Board, 'X', Children),
    (   Children = [] ->
        Score = 1
        % writeln('achou folha'),
        % print_board(Board),
        % writeln(Score)
    ;   ab_max_children(Children, Alpha, Beta, -inf, Score)).
ab_minimax(min, Board, Alpha, Beta, Score) :-
    children(Board, 'O', Children),
    (   Children = [] ->
        Score = -1
        % writeln('achou folha'),
        % print_board(Board),
        % writeln(Score)
    ;   ab_min_children(Children, Alpha, Beta, inf, Score)).


alpha_beta(Player, StartBoard, NextScore) :-
    ab_minimax(Player, StartBoard, -inf, inf, NextScore).


start_board([' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ',
    ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ',
    ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ',
    ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ',
    ' ', ' ', ' ', ' ', ' ', ' ']).


run :-
    start_board(StartBoard),
    Player = max,
    alpha_beta(Player, StartBoard, NextScore),
    write(NextScore).