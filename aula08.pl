/*  Professor, eu consigo mostrar o yes pelas modificações que fiz,
    porém, testando uma meta que falha da false no predicado embutido/1.
*/

do_goal(true, yes) :- !.
do_goal(Goal, Res) :-
    embutido(Goal),
    !,
    (   call(Goal) ->
        Res = yes
    ;   Res = no).
do_goal(Goal, Res) :-
    interpretado(Goal),
    clause(Goal, Body),
    do_body(Body, AfterCut, HadCut, Res0),
    (   HadCut = yes,
        !,
        do_body(AfterCut, Res1),
        Res = Res1
    ;   HadCut = no,
        Res = Res0
    ).

embutido(A):-
    predicate_property(A,P),
    memberchk(P, [built_in]),!.

interpretado(A):-
    \+ embutido(A),
    predicate_property(A,P),
    memberchk(P, [interpreted]),!.

do_body(Body, Res) :-
    do_body(Body, AfterCut, HadCut, Res0),
    (   HadCut = yes,
        !,
        do_body(AfterCut, Res1),
        Res = Res1
    ;   HadCut = no,
        Res = Res0
    ).
do_body((!, AfterCut), AfterCut, yes, _) :- !.
do_body((Goal, Body), AfterCut, HadCut, Res) :- !,
    do_goal(Goal, Res0),
    (   Res0 = no ->
        Res = no
    ;   do_body(Body, AfterCut, HadCut, Res)
    ).
do_body(!, true, yes, yes).
do_body((Disj1;  _), AfterCut, HadCut, Res) :-
    do_body(Disj1, AfterCut, HadCut, Res).
do_body((_; Disj2), AfterCut, HadCut, Res) :- !,
    do_body(Disj2, AfterCut, HadCut, Res).
do_body(Goal, true, no, Res) :-
    do_goal(Goal, Res).