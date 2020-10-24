% Questão 2

/* Predicados para manipulação de listas */

/* set_element_at_nth0(+List, +Index, +Element, -List2)
 * Altera o elemento de uma lista no índice especificado. */
set_element_at_nth0([_ | List1], CurrentIndex, Index, Elem, List2) :-
    CurrentIndex = Index,
    List2 = [Elem | List1].
set_element_at_nth0([First | List1], CurrentIndex, Index, Elem, List2) :-
    NextIndex is CurrentIndex + 1,
    set_element_at_nth0(List1, NextIndex, Index, Elem, List3),
    List2 = [First | List3].
set_element_at_nth0(List1, Index, Elem, List2) :-
    set_element_at_nth0(List1, 0, Index, Elem, List2).

/* swap_to_elements(+List1, +Index1, +Index2, -List2)
 * Troca dois elementos de uma lista. */
swap_two_elements(List1, Index1, Index2, List2) :-
    nth0(Index1, List1, Elem1),
    nth0(Index2, List1, Elem2),
    set_element_at_nth0(List1, Index1, Elem2, List3),
    set_element_at_nth0(List3, Index2, Elem1, List2).

/* valid_index é verdadeiro se index representa uma posição do tabuleiro */
valid_index(Index) :-
    Index >= 0,
    Index < 9.

/* movement(?Board, ?Index1, ?Movement, ?Board2).
 * Descreve de forma não-determinística os movimentos possíveis no tabuleiro
 * pelo índice e pela direção. */
movement(Board1, Index1, up, Board2) :-
    Index2 is Index1 - 3,
    valid_index(Index2),
    swap_two_elements(Board1, Index1, Index2, Board2).
movement(Board1, Index1, down, Board2) :-
    Index2 is Index1 + 3,
    valid_index(Index2),
    swap_two_elements(Board1, Index1, Index2, Board2).
movement(Board1, Index1, left, Board2) :-
    Index2 is Index1 - 1,
    valid_index(Index2),
    swap_two_elements(Board1, Index1, Index2, Board2).
movement(Board1, Index1, right, Board2) :-
    Index2 is Index1 + 1,
    valid_index(Index2),
    swap_two_elements(Board1, Index1, Index2, Board2).

/* Estado final do tabuleiro. */
goal([1, 2, 3, 8, b, 4, 7, 6, 5]).

/* expand(+BoardHeight, -NextBoards)
 * BoardHeight é uma lista de duas posições [Board, Height] onde:
 * Board é um tabuleiro, uma nó da árvore; e
 * Height é altura da árvore que o tabuleiro foi encontrado.
 * NextBoards retorna uma lista de nós e alturas que são filhos de Board */
expand(BoardHeight, NextBoards) :-
    nth0(Index, Board, b),
    [Board, Height] = BoardHeight,
    NewHeight is Height + 1,
    bagof([Board2, NewHeight], Direction^movement(Board, Index, Direction, Board2), NextBoards).


%% Wrong Squares

/* wrong_squares(+Board1, +Board2, -WrongSquares)
 * WrongSquares é a quantidade de valores diferentes entre duas listas
 * posição a posição. */
wrong_squares([], [], 0) :- !.
wrong_squares([First1 | Board1], [First2 | Board2], WrongSquares1) :-
    First1 \= First2, !,
    wrong_squares(Board1,  Board2, WrongSquares2),
    WrongSquares1 is WrongSquares2 + 1.
wrong_squares([_ | Board1], [_ | Board2], WrongSquares) :-
    wrong_squares(Board1, Board2, WrongSquares).

/* compare_wrong_squares(-Operator, +BoardHeight1, +BoardHeight2)
 * Precado usado como critério de comparação com o preditado build-in
 * predsort/3 para ordenar nós pelo valor da função heurística
 * mais a altura na árvore do nó. */
compare_wrong_squares(Operator, [Board1, Height1], [Board2, Height2]) :-
    goal(BoardGoal),
    wrong_squares(Board1, BoardGoal, WrongSquares1),
    wrong_squares(Board2, BoardGoal, WrongSquares2),
    F1 is Height1 + WrongSquares1,
    F2 is Height2 + WrongSquares2,
    compare(Operator, F1, F2).


%% Manhattan Distance

/* manhattan_distance(+Index1, +Index2, -Distance)
 * Distance é a distância de Manhattan entre os indexes Index1 e Index2 */
manhattan_distance(Index1, Index2, Distance) :-
    valid_index(Index1),
    valid_index(Index2),
    IndexDistance is abs(Index2 - Index1),
    XDistance is div(IndexDistance, 3),
    YDistance is mod(IndexDistance, 3),
    Distance is XDistance + YDistance.

board_manhattan_distance([], _, Distance, Distance) :- !.
board_manhattan_distance([First | Board], IndexFirst, Acc, Distance) :-
    goal(BoardGoal),
    nth0(IndexGoal, BoardGoal, First),
    manhattan_distance(IndexFirst, IndexGoal, ManhattanDistance),
    NewAcc is Acc + ManhattanDistance,
    NewIndex is IndexFirst + 1,
    board_manhattan_distance(Board, NewIndex, NewAcc, Distance).

/* board_manhattan_distance(+Board, +Distance)
 * Distance é a distância de manhattan de todos as posições de Board
 * para sua posição corresponente no tabuleiro objetivo */
board_manhattan_distance(Board, Distance) :-
    board_manhattan_distance(Board, 0, 0, Distance).

/* compare_manhattan_distance(-Operator, +BoardHeight1, +BoardHeight2)
 * Precado usado como critério de comparação com o preditado build-in
 * predsort/3 para ordenar nós pelo valor da função heurística
 * mais a altura na árvore do nó. */
compare_manhattan_distance(Operator, [Board1, Height1], [Board2, Height2]) :-
    board_manhattan_distance(Board1, BoardManhattanDistance1),
    board_manhattan_distance(Board2, BoardManhattanDistance2),
    F1 is Height1 + BoardManhattanDistance1,
    F2 is Height2 + BoardManhattanDistance2,
    compare(Operator, F1, F2).


%% A* with Wrong Squares

a_star_search1([], _) :- !,
    fail.
a_star_search1(NodesHeights, Solution) :-
    predsort(compare_wrong_squares, NodesHeights, [[Solution, _] | _]),
    goal(Solution).
a_star_search1(NodesHeights, Solution) :-
    predsort(compare_wrong_squares, NodesHeights, [NodeHeight | Remainder]),
    expand(NodeHeight, Children),
    append(Children, Remainder, NodesHeights1),
    a_star_search1(NodesHeights1, Solution).

a_star1(StartNode, Solution) :-
    a_star_search1([[StartNode, 0]], Solution).

% ?- a_star1([1, 2, 3, 7, 8, 4, 6, b, 5], Solution).


%% A* with Manhattan Distance

a_star_search2([], _) :- !,
    fail.
a_star_search2(NodesHeights, Solution) :-
    predsort(compare_manhattan_distance, NodesHeights, [[Solution, _] | _]),
    goal(Solution).
a_star_search2(NodesHeights, Solution) :-
    predsort(compare_manhattan_distance, NodesHeights, [NodeHeight | Remainder]),
    expand(NodeHeight, Children),
    append(Children, Remainder, NodesHeights1),
    a_star_search2(NodesHeights1, Solution).

a_star2(StartNode, Solution) :-
    a_star_search2([[StartNode, 0]], Solution).

% ?- a_star2([1, 2, 3, 7, 8, 4, 6, b, 5], Solution).
