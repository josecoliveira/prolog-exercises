filter(Condition, LI, LO) :-
    call(Condition),



    % jump([X1, Y1], D, [X2, Y2]) :- 
%     (
%         X2 =:= X1 + 1, Y2 =:= Y1 + 2;
%         X2 =:= X1 + 2, Y2 =:= Y1 + 1;
%         X2 =:= X1 + 2, Y2 =:= Y1 - 1;
%         X2 =:= X1 + 1, Y2 =:= Y1 - 2;
%         X2 =:= X1 - 1, Y2 =:= Y1 - 2;
%         X2 =:= X1 - 2, Y2 =:= Y1 - 1;
%         X2 =:= X1 - 2, Y2 =:= Y1 + 1;
%         X2 =:= X1 - 1, Y2 =:= Y1 + 2
%     ),
%     valid_position([X2, Y2], D),
%     valid_position([X1, Y2], D).

% path(D, [P]) :-
%     valid_position(P, D).
% path(D, [P0, P1]) :-
%     jump(P0, D, P1).
% path(D, [P0, P1 | P]) :-
%     jump(P0, D, P1),
%     path(D, [P1 | P]).

% hamiltonian_path(D, L) :-
%     is_set(L),
%     Size is D * D,
%     length(L, Size),
%     path(D, L).

% cicle(D, [P0 | L]) :-
%     last(L, PN),
%     jump(PN, D, P0).