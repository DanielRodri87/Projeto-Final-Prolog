
listar_todos_pacientes :-
    write('------------------------------------------------------'), nl,
    write('|                LISTA DE PACIENTES                   |'), nl,
    write('------------------------------------------------------'), nl,
    listar_pacientes_aux.

listar_pacientes_aux :-
    diabetes(Atributos, StatusDiabetes),
    format('| Nome: ~w', [Atributos]),
    write(' - Status de Diabetes: '), write(StatusDiabetes), write(' |'), nl,
    fail.
listar_pacientes_aux :-
    write('------------------------------------------------------'), nl.
