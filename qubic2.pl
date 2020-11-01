print_board_content([]) :- !.
print_board_content([A, B, C, D | Board]) :-
    write('│ '),
    write(A),
    write(' │ '),
    write(B),
    write(' │ '),
    write(C),
    write(' │ '),
    write(D), 
    write(' │'), nl,
    (Board \= [] ->
        write('├───┼───┼───┼───┤'), nl;
        true),
    print_board_content(Board).


/* print_board(?Board)
 * Imprime um tabuleiro do Qubic */
print_board(Board) :-
    writeln('┌───┬───┬───┬───┐'),
    print_board_content(Board),
    writeln('└───┴───┴───┴───┘').


/* print_boards(?Board)
 * Imprime os 4 tabuleiros de um Qubic */
print_boards(Board) :-
    append(B1, B234, Board),
    length(B1, 16),
    append(B2, B34, B234),
    length(B2, 16),
    append(B3, B4, B34),
    length(B3, 16),
    length(B4, 16),
    print_board(B1),
    print_board(B2),
    print_board(B3),
    print_board(B4).


print_all_boards([]) :- !.
print_all_boards([Board | Boards]) :-
    print_boards(Board),
    (   Board \= [] ->
        nl, nl, nl
    ;   true),
    print_all_boards(Boards).


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


/* child(+Board, +Turn, -Child)
 * Dado o tabuleiro Board, se Turn ('X' ou 'O') jogar em alguma posição vazia
 * de Board, irá gerar Child */
child(Board, Turn, Child) :-
    nth0(Index, Board, ' '),
    set_element_at_nth0(Board, 0, Index, Turn, Child).
    

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


/* children(+Board, +Turn, -Children)
 * Children é uma lista de todos o tabuleiros possíveis quando Turn ('X', 'O') 
 * joga no tabuleiro Board. */
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


/* count(+List, +Elem, -Count)
 * Count é a quantidade de elementos Elem na lista List. */
count([], _, Ans, Ans) :- !.
count([E | T], E, Accum, Ans) :- !,
    NewAcumm is Accum + 1,
    count(T, E, NewAcumm, Ans).
count([_ | T], E, Accum, Ans) :-
    count(T, E, Accum, Ans).

count(L, E, Ans) :-
    count(L, E, 0, Ans).


/* symbols_list_score(+List, -Score)
 * Score é uma pontuação para uma lista de símbolos List que quantifica o quão
 * favorável é aquela lista para o jogador maximizador ('X'). */
symbols_list_score(List, [0, 0, 0, 0]) :-
    member('X', List),
    member('O', List), !.
symbols_list_score(List, [0, 0, 0, 0]) :-
    \+ member('X', List),
    \+ member('O', List), !.
symbols_list_score(List, Score) :-
    member('X', List), !,
    count(List, 'X', Count),
    (   Count = 1 ->
        Score = [0, 0, 0, 1]
    ;   Count = 2 ->
        Score = [0, 0, 1, 0]
    ;   Count = 3 ->
        Score = [0, 1, 0, 0]
    ;   Count = 4 ->
        Score = [1, 0, 0, 0]).
symbols_list_score(List, Score) :-
    member('O', List),
    count(List, 'O', Count),
    (   Count = 1 ->
        Score = [0, 0, 0, -1]
    ;   Count = 2 ->
        Score = [0, 0, -1, 0]
    ;   Count = 3 ->
        Score = [0, -1, 0, 0]
    ;   Count = 4 ->
        Score = [-1, 0, 0, 0]).


/* winning_sequences_to_symbols(+ListIndexes, +Board, -ListSymbols)
 * ListSymbols é a lista de símbolos que estão nas posições em ListIndexes do
 * tabuleiro Board. */
winning_sequences_to_symbols([], _, []) :- !.
winning_sequences_to_symbols([List | Lists], Board, [List1 | Lists1]) :-
    query_symbols_by_indexes(List, Board, List1),
    winning_sequences_to_symbols(Lists, Board, Lists1).


sum_list_scores([], BoardScore, BoardScore) :- !.
sum_list_scores([[S4, S3, S2, S1] | Scores], [A4, A3, A2, A1], BoardScore) :-
    NA4 is A4 + S4,
    NA3 is A3 + S3,
    NA2 is A2 + S2,
    NA1 is A1 + S1,
    sum_list_scores(Scores, [NA4, NA3, NA2, NA1], BoardScore).


/* sum_list_scores(+Scores, -BoardScore) 
 * BoardScore é a soma das pontuações na lista Score. */
sum_list_scores(Scores, BoardScore) :-
    sum_list_scores(Scores, [0, 0, 0, 0], BoardScore).


/* board_score(+Board, -BoardScore)
 * BoardScore é a soma de todas as pontuações obtidas pelas sequencias de
 * posições vencedoras no tabuleiro Board. Em outras palavras, BoardScore
 * mostra o quão favorável é o tabuleiro para o jogador maximizador ('X'). */
board_score(Board, BoardScore) :-
    bagof(Symbols, Indexes^(winning_sequence(Indexes),
        query_symbols_by_indexes(Indexes, Board, Symbols)), Sequences),
    bagof(Score, Sequence^(member(Sequence, Sequences),
        symbols_list_score(Sequence, Score)), Scores),
    sum_list_scores(Scores, BoardScore).


/* geq_score_list(Score1, Score2)
 * É verdade se a pontuação Score1 é maior ou igual a pontuação Score2. */
geq_score_list([], []) :- !.
geq_score_list([X1 | _], [X2 | _]) :-
    X1 > X2, !.
geq_score_list([X1 | L1], [X2 | L2]) :-
    X1 = X2,
    geq_score_list(L1, L2).


/* geq_board(Board1, Board2)
 * É verdade se a pontuação do tabuleiro Board1 é maior ou igual do que o
 * tabuleiro Board2. */
geq_board(Board1, Board2) :-
    board_score(Board1, Score1),
    board_score(Board2, Score2),
    geq_score_list(Score1, Score2).


max_board_list([], MaxBoard, MaxBoard) :- !.
max_board_list([Board | Boards], MaxBoard, MaxBoard1) :-
    (   geq_board(MaxBoard, Board) ->
        max_board_list(Boards, MaxBoard, MaxBoard1)
    ;   max_board_list(Boards, Board, MaxBoard1)).

/* max_board_list(+Boards, -MaxBoard)
 * MaxBoard é o tabuleiro na lista Boards com a maior pontuação. Em caso de
 * tabuleiros com a mesma pontuação, a prioriade é para o tabuleiro mais a
 * esquerda. */
max_board_list([Board], Board) :- !.
max_board_list([Board | Boards], MaxBoard) :-
    max_board_list(Boards, Board, MaxBoard).


/* leq_score_list(Score1, Score2)
 * É verdade se a pontuação Score1 é menor ou igual a pontuação Score2. */
leq_score_list([], []) :- !.
leq_score_list([X1 | _], [X2 | _]) :-
    X1 < X2, !.
leq_score_list([X1 | L1], [X2 | L2]) :-
    X1 = X2,
    leq_score_list(L1, L2).


/* leq_board(Board1, Board2)
 * É verdade se a pontuação do tabuleiro Board1 é menor ou igual do que o
 * tabuleiro Board2. */
leq_board(Board1, Board2) :-
    board_score(Board1, Score1),
    board_score(Board2, Score2),
    leq_score_list(Score1, Score2).


min_board_list([], MinBoard, MinBoard) :- !.
min_board_list([Board | Boards], MinBoard, MinBoard1) :-
    (   leq_board(MinBoard, Board) ->
        min_board_list(Boards, MinBoard, MinBoard1)
    ;   min_board_list(Boards, Board, MinBoard1)).

/* min_board_list(+Boards, -MinBoard)
 * MinBoard é o tabuleiro na lista Boards com a menor pontuação. Em caso de
 * tabuleiros com a mesma pontuação, a prioriade é para o tabuleiro mais a
 * esquerda. */
min_board_list([Board], Board) :- !.
min_board_list([Board | Boards], MinBoard) :-
    min_board_list(Boards, Board, MinBoard).


/* play(+Board, +Player, -NexBoard)
 * Dado um tabuleiro e a vez do jogador Player ('X', 'O'), NextBoard é a
 * melhor jogada. Se NextBoard é uma lista vazia, Player perdeu.*/
play(Board, 'X', NextBoard) :-
    children(Board, 'X', NextBoards),
    (   NextBoards = [] ->
        NextBoard = []
    ;   max_board_list(NextBoards, NextBoard)).
play(Board, 'O', NextBoard) :-
    children(Board, 'O', NextBoards),
    (   NextBoards = [] ->
        NextBoard = []
    ;   min_board_list(NextBoards, NextBoard)).


/* start_board(Board)
 * É uma "variável global", para representar um tabuleiro inicial, quando o
 * maximizador joga pela primeira vez. */
start_board([' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ',
    ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ',
    ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ',
    ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ',
    ' ', ' ', ' ', ' ', ' ', ' ']).


simulate(Board, 'X') :-
    play(Board, 'X', NextBoard),
    (   \+ member(' ', Board) ->
        write('Draw')
    ;   NextBoard = [] ->
        write('O won.')
    ;   writeln('X turn'),
        print_boards(NextBoard),
        board_score(NextBoard, Score),
        write('Score: '), writeln(Score),
        simulate(NextBoard, 'O')).
simulate(Board, 'O') :-
    play(Board, 'O', NextBoard),
    (   NextBoard = [] ->
        write('X won.')
    ;   writeln('O turn'),
        print_boards(NextBoard),
        board_score(NextBoard, Score),
        write('Score: '), writeln(Score),
        simulate(NextBoard, 'X')).

/* simulate
 * Realiza um jogo do computador jogando contra ele mesmo. Este simulador
 * apresenta um exemplo claro da heurística não funcionar corretamente por
 * deixar o outro jogador ganhar a partida. */
simulate :-
    start_board(StartBoard),
    simulate(StartBoard, 'X').


/* coordinates_to_index(+Coordinates, -Index)
 * Index é a posição ordinal do tabuleiro (começando de 0), representado pelas
 * coordenadas em Coordinates, que é uma lista de 3 inteiros. Aqui, a origem é
 * [0, 0, 0] = 0. Além disto, o primeiro elemento representa o "andar", o
 * segundo representa a linha e o terceiro representa a coluna. */
coordinates_to_index([B, R, C], Index) :-
    Index is B * 16 + R * 4 + C.


/* valid_index(?Index)
 * É verdadeiro se Index é entre 0 e 63. */
valid_index(Index) :-
    Index >= 0,
    Index < 63.

/* index_to_coordinates(+Index, -Coordinates)
 * Coordinates é uma lista de três inteiros representando as coordenadas no
 * tabuleiros referentes ao índice Index. Veja coordinates_to_index. */
index_to_coordinates(Index, [B, R, C]) :-
    B is div(Index, 16),
    R1 is mod(Index, 16),
    R is div(R1, 4),
    C is mod(R1, 4).


find_movement([X1 | Board1], [X2 | Board2], CurrentIndex, Index) :-
    (   X1 = X2 ->
        NextIndex is CurrentIndex + 1,
        find_movement(Board1, Board2, NextIndex, Index)
    ;   X1 \= 2 ->
        Index = CurrentIndex).

/* find_movement(Board1, Board2, Index)
 * Supondo que Board2 é um tabuleiro com uma jogada a mais do que o Board1,
 * Index é a posição em que foi feita a jogada. */
find_movement(Board1, Board2, Index) :-
    find_movement(Board1, Board2, 0, Index).


/* player_first(Board)
 * Realiza um jogo do Qubic com o usuário jogando primeiro como 'X'. Board
 * é o tabuleiro inicial antes da jogada do usuário. */
player_first(Board) :-
    print_boards(Board),
    play(Board, 'X', PlayerPossibleBoard),
    (   PlayerPossibleBoard = [] ->
        writeln("Com won")
    ;   writeln("Player's turn. Make your play."),
        writeln("Format: [<Board>, <Row>, <Column>]."),
        read(PlayerCoordinates),
        coordinates_to_index(PlayerCoordinates, PlayerIndex),
        valid_index(PlayerIndex),
        set_element_at_nth0(Board, PlayerIndex, 'X', PlayerBoard),
        print_boards(PlayerBoard),
        play(PlayerBoard, 'O', ComBoard),
        (   ComBoard = [] ->
            writeln("Player won")
        ;   find_movement(PlayerBoard, ComBoard, ComIndex),
            index_to_coordinates(ComIndex, ComCoordinates),
            write("Com played "), writeln(ComCoordinates),
            player_first(ComBoard)
        )
    ).


/* first
 * Realiza um jogo do Qubic com o usuário jogando primeiro como 'X'. O
 * tabuleiro começa vazio. */
first :-
    start_board(StartBoard),
    player_first(StartBoard).


/* com_first(Board)
 * Realiza um jogo do Qubic com o computador jogando primeiro como 'X'. Board
 * é o tabuleiro inicial antes da jogada do computador. */
com_first(Board) :-
    print_boards(Board),
    play(Board, 'X', ComBoard),
    (   ComBoard = [] ->
        writeln("Player won")
    ;   find_movement(Board, ComBoard, ComIndex),
        index_to_coordinates(ComIndex, ComCoordinates),
        write("Com played "), writeln(ComCoordinates),
        print_boards(ComBoard),
        play(ComBoard, 'O', PlayerBoards),
        (   PlayerBoards = [] ->
            writeln("Com won")
        ;   writeln("Player's turn. Make your play."),
            writeln("Format: [<Board>, <Row>, <Column>]."),
            read(PlayerCoordinates),
            coordinates_to_index(PlayerCoordinates, PlayerIndex),
            valid_index(PlayerIndex),
            set_element_at_nth0(ComBoard, PlayerIndex, 'O', PlayerBoard),
            print(PlayerBoard),
            com_first(PlayerBoard)
        )
    ).


/* second
 * Realiza um jogo do Qubic com o computador jogando primeiro como 'X'. O
 * tabuleiro começa vazio. */
second :-
    start_board(StartBoard),
    com_first(StartBoard).

