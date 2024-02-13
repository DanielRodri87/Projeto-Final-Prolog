editar_paciente :-
    write('Escolha um paciente para editar (digite o nome): '), nl,
    read(NomePaciente),
    (
        diabetes(PacienteRemover, StatusDiabetes),
        nth0(0, PacienteRemover, NomePaciente),
        nth0(1, PacienteRemover, Sexo),
        nth0(2, PacienteRemover, Idade),
        nth0(3, PacienteRemover, Hiper),
        nth0(4, PacienteRemover, Card),
        nth0(5, PacienteRemover, Fumante),
        nth0(6, PacienteRemover, IMC),
        nth0(7, PacienteRemover, Hemoglobina),
        nth0(8, PacienteRemover, Glicose),
        write('---------------------------- INFO PACIENTE ----------------------------'), nl,
        write('|                                                                     |'), nl,
        write('|  Paciente encontrado. Atributos atuais:                             |'), nl,
        write('|                                                                     |'), nl,
        write('|  Nome: '), write(NomePaciente), nl,
        write('|  Sexo: '), write(Sexo), nl,
        write('|  Idade: '), write(Idade), nl,
        write('|  Hipertensao: '), write(Hiper), nl,
        write('|  Problemas Cardiacos: '), write(Card), nl,
        write('|  Fumante: '), write(Fumante), nl,
        write('|  IMC: '), write(IMC), nl,
        write('|  Hemoglobina: '), write(Hemoglobina), nl,
        write('|  Glicose: '), write(Glicose), nl,
        write('|  Status de Diabetes: '), write(StatusDiabetes), nl,
        write('|                                                                     |'), nl,
        write('|  Escolha o que deseja editar:                                       |'), nl,
        write('|                                                                     |'), nl,
        write('|  1 - Nome                                                           |'), nl,
        write('|  2 - Sexo                                                           |'), nl,
        write('|  3 - Idade                                                          |'), nl,
        write('|  4 - Hipertensao                                                    |'), nl,
        write('|  5 - Problemas Cardiacos                                            |'), nl,
        write('|  6 - Fumante                                                        |'), nl,
        write('|  7 - IMC                                                            |'), nl,
        write('|  8 - Hemoglobina                                                    |'), nl,
        write('|  9 - Glicose                                                        |'), nl,
        write('| 10 - Status de Diabetes                                             |'), nl,
        write('|                                                                     |'), nl,
        write('----------------------------------------------------------------------------'), nl,
        write('-> '),
        read(OpcaoEditar),
        (
            OpcaoEditar = 1 -> editar_atributo(NomePaciente, 'Nome', _);
            OpcaoEditar = 2 -> editar_atributo(NomePaciente, 'Sexo', _);
            OpcaoEditar = 3 -> editar_atributo(NomePaciente, 'Idade', _);
            OpcaoEditar = 4 -> editar_atributo(NomePaciente, 'Hipertensao', _);
            OpcaoEditar = 5 -> editar_atributo(NomePaciente, 'Problemas Cardiacos', _);
            OpcaoEditar = 6 -> editar_atributo(NomePaciente, 'Fumante', _);
            OpcaoEditar = 7 -> editar_atributo(NomePaciente, 'IMC', _);
            OpcaoEditar = 8 -> editar_atributo(NomePaciente, 'Hemoglobina', _);
            OpcaoEditar = 9 -> editar_atributo(NomePaciente, 'Glicose', _);
            OpcaoEditar = 10 -> editar_atributo(NomePaciente, 'Status de Diabetes', _)
        ),
        write('Paciente editado com sucesso.'),
        retract(diabetes(DadosAntigos, Status)),
        append([NomePaciente], Resto, DadosAntigos), 
        append([NomePaciente], NovosDados, NovosDadosCompleto), 
        assertz(diabetes(NovosDadosCompleto, Status)).
        main
    ;
        write('Paciente nao encontrado.')
    ).
    