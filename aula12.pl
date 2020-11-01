%% Questão 1

valid_index(Index) :-
    Index >= 0,
    Index < 9.


print_board([]) :- !.
print_board([A, B, C | Board]) :-
    write(A),
    write(' │ '),
    write(B),
    write(' │ '),
    write(C), nl,
    (Board \= [] ->
        write('──┼───┼───'), nl;
        true),
    print_board(Board).


set_element_at_nth0([_ | List1], CurrentIndex, Index, Elem, List2) :-
    CurrentIndex = Index,
    List2 = [Elem | List1].
set_element_at_nth0([First | List1], CurrentIndex, Index, Elem, List2) :-
    NextIndex is CurrentIndex + 1,
    set_element_at_nth0(List1, NextIndex, Index, Elem, List3),
    List2 = [First | List3].

set_element_at_nth0(List1, Index, Elem, List2) :-
    set_element_at_nth0(List1, 0, Index, Elem, List2).


child(Board, Turn, Child) :-
    nth0(Index, Board, ' '),
    set_element_at_nth0(Board, 0, Index, Turn, Child).

children(Board, _, []) :-
    % winning_sequence(WinningSequence),
    % query_symbols_by_indexes(WinningSequence, Board, Symbols),
    bagof(Symbols, Indexes^(
        winning_sequence(Indexes),
        query_symbols_by_indexes(Indexes, Board, Symbols),
        (Symbols = ['X', 'X', 'X']; Symbols = ['O', 'O', 'O'])), Sequences), !,
    Sequences \= [].
children(Board, Turn, Children) :-
    (   bagof(Child, Turn^child(Board, Turn, Child), Children)
    ;   Children = []).
    

print_all_boards([]) :- !.
print_all_boards([Board | Boards]) :-
    print_board(Board),
    (Boards \= [] ->
        nl
    ;   true),
    print_all_boards(Boards).


winning_sequence([0, 1, 2]).
winning_sequence([3, 4, 5]).
winning_sequence([6, 7, 8]).
winning_sequence([0, 3, 6]).
winning_sequence([1, 4, 7]).
winning_sequence([2, 5, 8]).
winning_sequence([0, 4, 8]).
winning_sequence([2, 4, 6]).


query_symbols_by_indexes([], _, []) :- !.
query_symbols_by_indexes([Index | Indexes], Board, [Symbol | Symbols]) :-
    nth0(Index, Board, Symbol),
    query_symbols_by_indexes(Indexes, Board, Symbols).


count([], _, Ans, Ans) :- !.
count([E | T], E, Accum, Ans) :- !,
    NewAcumm is Accum + 1,
    count(T, E, NewAcumm, Ans).
count([_ | T], E, Accum, Ans) :-
    count(T, E, Accum, Ans).

count(L, E, Ans) :-
    count(L, E, 0, Ans).


symbols_list_score(List, 0) :-
    member('X', List),
    member('O', List), !.
symbols_list_score(List, 0) :-
    \+ member('X', List),
    \+ member('O', List), !.
symbols_list_score(List, Score) :-
    member('X', List), !,
    count(List, 'X', Count),
    (Count = 1 ->
        Score = 10;
    Count = 2 ->
        Score = 100;
    Count = 3 ->
        Score = 1000).
symbols_list_score(List, Score) :-
    member('O', List),
    count(List, 'O', Count),
    (Count = 1 ->
        Score = -10;
    Count = 2 ->
        Score = -100;
    Count = 3 ->
        Score = -1000).
    

winning_sequences_to_symbols([], _, []) :- !.
winning_sequences_to_symbols([List | Lists], Board, [List1 | Lists1]) :-
    query_symbols_by_indexes(List, Board, List1),
    winning_sequences_to_symbols(Lists, Board, Lists1).


board_score(Board, BoardScore) :-
    bagof(Symbols, Indexes^(winning_sequence(Indexes), query_symbols_by_indexes(Indexes, Board, Symbols)), Sequences),
    bagof(Score, Sequence^(member(Sequence, Sequences), symbols_list_score(Sequence, Score)), Scores),
    sum_list(Scores, BoardScore).


% Alpha Beta

max(A, B, A) :-
    A >= B, !.
max(A, B, B) :-
    B > A.


min(A, B, A) :-
    A =< B, !.
min(A, B, B) :-
    B < A.


ab_max_children([], _, _, Max, Max, _).
ab_max_children([Child | Children], Alpha, Beta, Max1, Max, NextBoard) :-
    ab_minimax(min, Child, Alpha, Beta, Score, NextBoard),
    (   Score > Beta ->
        Max = Beta,
        NextBoard = Child
    ;   max(Score, Alpha, Alpha1),
        max(Score, Max1, Max2),
        ab_max_children(Children, Alpha1, Beta, Max2, Max, NextBoard)).


ab_min_children([], _, _, Min, Min, _).
ab_min_children([Child | Children], Alpha, Beta, Min1, Min, NextBoard) :-
    ab_minimax(max, Child, Alpha, Beta, Score, NextBoard),
    (   Alpha > Score ->
        Min = Alpha,
        NextBoard = Child
    ;   min(Score, Beta, Beta1),
        min(Score, Min1, Min2),
        ab_min_children(Children, Alpha, Beta1, Min2, Min, NextBoard)).


ab_minimax(max, Board, Alpha, Beta, Score, NextBoard) :-
    children(Board, 'X', Children),
    (   Children = [] ->
        board_score(Board, Score)
        % writeln('achou folha'),
        % print_board(Board),
        % writeln(Score)
    ;   ab_max_children(Children, Alpha, Beta, -inf, Score, NextBoard)).
ab_minimax(min, Board, Alpha, Beta, Score, NextBoard) :-
    children(Board, 'O', Children),
    (   Children = [] ->
        board_score(Board, Score)
        % writeln('achou folha'),
        % print_board(Board),
        % writeln(Score)
    ;   ab_min_children(Children, Alpha, Beta, inf, Score, NextBoard)).


alpha_beta(Player, StartBoard, NextScore, NextBoard) :-
    ab_minimax(Player, StartBoard, -inf, inf, NextScore, NextBoard).


% [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']

run :-
    Player = max,
    StartBoard = [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
    alpha_beta(Player, StartBoard, NextScore, NextBoard),
    writeln(NextScore),
    print_board(NextBoard).