% Questão 1

set_element_at_nth0([_ | List1], CurrentIndex, Index, Elem, List2) :-
    CurrentIndex = Index,
    List2 = [Elem | List1].
set_element_at_nth0([First | List1], CurrentIndex, Index, Elem, List2) :-
    NextIndex is CurrentIndex + 1,
    set_element_at_nth0(List1, NextIndex, Index, Elem, List3),
    List2 = [First | List3].
set_element_at_nth0(List1, Index, Elem, List2) :-
    set_element_at_nth0(List1, 0, Index, Elem, List2).

swap_two_elements(List1, Index1, Index2, List2) :-
    nth0(Index1, List1, Elem1),
    nth0(Index2, List1, Elem2),
    set_element_at_nth0(List1, Index1, Elem2, List3),
    set_element_at_nth0(List3, Index2, Elem1, List2).

valid_index(Index) :-
    Index >= 0,
    Index < 9.

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

goal([1, 2, 3, 8, b, 4, 7, 6, 5]).

expand(Board, NextBoards) :-
    nth0(Index, Board, b),
    bagof(Board2, Direction^movement(Board, Index, Direction, Board2), NextBoards).


%% Wrong Squares

wrong_squares([], [], 0) :- !.
wrong_squares([First1 | Board1], [First2 | Board2], WrongSquares1) :-
    First1 \= First2, !,
    wrong_squares(Board1,  Board2, WrongSquares2),
    WrongSquares1 is WrongSquares2 + 1.
wrong_squares([_ | Board1], [_ | Board2], WrongSquares) :-
    wrong_squares(Board1, Board2, WrongSquares).

compare_wrong_squares(Operator, Board1, Board2) :-
    goal(BoardGoal),
    wrong_squares(Board1, BoardGoal, WrongSquares1),
    wrong_squares(Board2, BoardGoal, WrongSquares2),
    compare(Operator, WrongSquares1, WrongSquares2).


%% Manhattan Distance

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

board_manhattan_distance(Board, Distance) :-
    board_manhattan_distance(Board, 0, 0, Distance).

compare_board_manhattan_distance(Operator, Board1, Board2) :-
    board_manhattan_distance(Board1, BoardManhattanDistance1),
    board_manhattan_distance(Board2, BoardManhattanDistance2),
    compare(Operator, BoardManhattanDistance1, BoardManhattanDistance2).


%% Hill Climbing with Wrong Squares
%% Time Limit Exceeded

hill_climb1([Node | _], Node) :-
    goal(Node), !.
hill_climb1([Node | _], Solution) :-
    expand(Node, Children),
    predsort(compare_wrong_squares, Children, SortedChildren),
    append(SortedChildren, [], Nodes1),
    hill_climb1(Nodes1, Solution).

hill_climbing1([], _) :- !,
    fail.
hill_climbing1(Nodes, Solution) :-
    predsort(compare_board_manhattan_distance, Nodes, SortedNodes),
    hill_climbing1(SortedNodes, Solution).


%% Hill Climbing with Manhattan Distance
%% Time limit Exceeded

hill_climb2([Node | _], Node) :-
    goal(Node), !.
hill_climb2([Node | _], Solution) :-
    expand(Node, Children),
    predsort(compare_board_manhattan_distance, Children, SortedChildren),
    append(SortedChildren, [], Nodes1),
    hill_climb2(Nodes1, Solution).

hill_climbing2([], _) :- !,
    fail.
hill_climbing2(Nodes, Solution) :-
    predsort(compare_board_manhattan_distance, Nodes, SortedNodes),
    hill_climbing2(SortedNodes, Solution).


%% Best-first with Wrong Squares
%% Stack limit exceeded

best_first1([], _) :- !,
    fail.
best_first1(Nodes, Solution) :-
    predsort(compare_wrong_squares, Nodes, [Solution | _]),
    goal(Solution).
best_first1(Nodes, Solution) :-
    predsort(compare_wrong_squares, Nodes, [Node | Remainder]),
    expand(Node, Children),
    append(Children, Remainder, Nodes1),
    best_first1(Nodes1, Solution).


%% Best-first with Manhattan Distance
%% Stack limit exceeded 

best_first2([], _) :- !,
    fail.
best_first2(Nodes, Solution) :-
    predsort(compare_board_manhattan_distance, Nodes, [Solution | _]),
    goal(Solution).
best_first2(Nodes, Solution) :-
    predsort(compare_board_manhattan_distance, Nodes, [Node | Remainder]),
    expand(Node, Children),
    append(Children, Remainder, Nodes1),
    best_first2(Nodes1, Solution).

