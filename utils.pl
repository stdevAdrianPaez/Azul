
% inside(L,I)
% Comprueba que el índice I esté dentro de los límites de la lista L
%
inside(L,I) :-
    I >= 0,
    length(L,EC),
    I < EC.

or([false], false).
or([true|_], true).
or([false|R], Or):-
    or(R, Or).

% getByIndex(L,I,E)
% Devuelve en E el elemento que está en la posición I de L
%

getByIndex([X|_],0,X) :- !.

getByIndex([X|R],I,E) :-
    inside([X|R],I),
    !,
    NewIndex is I-1,
    getByIndex(R,NewIndex,E).

changeIndex(L, Index, NewE,LR):-
    pushByIndex(LTemp, Index, _, L),
    pushByIndex(LTemp, Index, NewE, LR).


pushByIndex(L, 0, E, [E|L]):-!.
pushByIndex([X|L], I, E, [X|R]):-
    NewI is I-1,
    pushByIndex(L, NewI, E, R).

% removeValue(L,X,R)
% Devuelve en R el resultado de eliminar la primera ocurrencia de X en L
removeValue([X|R],X,R) :- !.

removeValue([Y|R],X,[Y|ListResult]) :-
    removeValue(R,X,ListResult).

% countCountinous(W,I,J,T,P)
% Devuelve en P la cantidad de índices activos en W 
% a partir de la posición I con incremento J y tope T
countCountinous(W,I,_,I,0) :-
    getByIndex(W,I,0), !.

countCountinous(W,I,_,I,1) :-
    getByIndex(W,I,1), !.

countCountinous(W,I,_,_,0) :-
    getByIndex(W,I,0), !.

countCountinous(W,I,J,T,P) :-
    getByIndex(W,I,1), 
    K is I + J, 
    countCountinous(W,K,J,T,PR), 
    P is PR + 1.

max(A, B, A):- A > B.
max(_, B, B).


concatLists([], L, L).
concatLists(L, [], L).

concatLists([X|L1], L2, [X|R]):-
    concatLists(L1, L2, R).
