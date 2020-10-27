first_column_to_row([], [], []) :- !.
first_column_to_row([[First | RemainderFirstRow] | Matrix], [First | RemainderRow], [RemainderFirstRow | RemainderMatrix]) :-
    first_column_to_row(Matrix, RemainderRow, RemainderMatrix).


transpose(EmptyMatrix, Ans, Ans) :-
    flatten(EmptyMatrix, []), !.
transpose(Matrix, Accum, Ans) :-
    first_column_to_row(Matrix, Row, RemainderMatrix),
    append(Accum, [Row], NewAccum),
    transpose(RemainderMatrix, NewAccum, Ans).

transpose(Matrix, Ans) :-
    transpose(Matrix, [], Ans).


apply_to_all_times([], Ans, Ans) :- !.
apply_to_all_times([[First1, First2] | List], Accum, Ans) :-
    F1tF2 is First1 * First2,
    append(Accum, [F1tF2], NewAccum),
    apply_to_all_times(List, NewAccum, Ans).

apply_to_all_times(List, Ans) :-
    apply_to_all_times(List, [], Ans).


insert_add([], Ans, Ans) :- !.
insert_add([First | List], Accum, Ans) :-
    NewAccum is Accum + First,
    insert_add(List, NewAccum, Ans).

insert_add(List, Ans) :-
    insert_add(List, 0, Ans).


inner_product(V, U, Ans) :-
    M = [V, U],
    transpose(M, M1),
    apply_to_all_times(M1, M2),
    insert_add(M2, Ans).


distr([[], _], []) :- !.
distr([[First | List], X], [[First, X] | List1]) :-
    distr([List, X], List1).


distl([_, []], []) :- !.
distl([X, [First | List]], [[X, First] | List1]) :-
    distl([X, List], List1).


apply_to_all_distl([], []) :- !.
apply_to_all_distl([First | Matrix], [First1 | Matrix1]) :-
    distl(First, First1),
    apply_to_all_distl(Matrix, Matrix1).


apply_to_all_inner_product([], []) :- !.
apply_to_all_inner_product([First | Matrix], [InnerProduct | List]) :-
    [U, V] = First,
    inner_product(U, V, InnerProduct),
    apply_to_all_inner_product(Matrix, List).


apply_to_all_apply_to_all_inner_product([], []) :- !.
apply_to_all_apply_to_all_inner_product([First | Matrix], [First1 | Matrix1]) :-
    apply_to_all_inner_product(First, First1),
    apply_to_all_apply_to_all_inner_product(Matrix, Matrix1).


matrix_multiplication(M, N, Ans) :-
    transpose(N, N1),
    A = [M, N1],
    distr(A, A1),
    apply_to_all_distl(A1, A2),
    apply_to_all_apply_to_all_inner_product(A2, Ans).
