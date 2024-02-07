:- dynamic diabetes/2.

diabetes([maria, feminino, 37.0, nao, nao, passado, 30.5, 5.7, 100], nao).
diabetes([gorete, feminino, 53.0, nao, nao, passado, 26.37, 4.5, 112], nao).
diabetes([pedro, masculino, 54.0, nao, nao, nunca, 31.86, 6.6, 145],nao).
diabetes([juliana, feminino, 37.0, nao, nao, passado, 21.25, 6.1, 200], nao).
diabetes([catisvalda, feminino, 56.0, nao, nao, nunca, 30.95, 6.5, 145], nao).
diabetes([ursulino, masculino, 79.0, nao, nao, passado, 31.19, 5.8, 155], nao).
diabetes([jose, masculino, 67.0, nao, nao, sim, 27.32, 6.8, 220], sim).
diabetes([marta, feminino, 74.0, nao, nao, sim, 29.51, 8.2, 240], sim).
diabetes([jussara, feminino, 37.0, nao, nao, passado, 36.87, 8.8, 160], sim).
diabetes([katia, feminino, 65.0, sim, sim, nunca, 33.55, 8.9, 202], sim).
diabetes([marcelo, masculino, 55.0, nao, sim, passado, 30.42, 6.2, 300], sim).
diabetes([ayla, feminino, 61.0, nao, nao, passado, 34.45, 6.5, 280], sim).
diabetes([rafaela, feminino, 58.0, sim, nao, nunca, 38.31, 7.0, 200], sim).
diabetes([cassia, feminino, 61.0, nao, nao, sim, 30.11, 6.2, 240], sim).
diabetes([elisa, feminino, 26.0, nao, nao, passado, 27.32, 4.0, 200], nao).
diabetes([alice, feminino, 74.0, nao, nao, passado, 28.12, 5.0, 100], nao).
diabetes([jade, feminino, 45.0, sim, nao, nunca, 23.05, 4.8, 130], nao).
diabetes([heloise, masculino, 56.0, nao, nao, nunca, 26.78, 4.8, 200], nao).
diabetes([benicio, masculino, 20.0, nao, nao, passado, 23.04, 5.7, 160], nao).
diabetes([paulo, masculino, 70.0, nao, nao, passado, 15.94, 5.8, 158], nao).
diabetes([otavio, masculino, 30.0, nao, nao, passado, 15.8, 6.2, 90], nao).
diabetes([isis, feminino, 80.0, nao, nao, nunca, 25.04, 9.0, 209], sim).
diabetes([francivaldo, masculino, 63.0, nao, sim, passado, 27.32, 6.6, 300], sim).
diabetes([juvelino, masculino, 58.0, nao, nao, passado, 32.38, 6.6, 159], sim).
diabetes([maya, feminino, 43.0, sim, nao, nunca, 34.21, 9.0, 160], sim).
diabetes([genetildes, masculino, 56.0, nao, nao, nunca, 37.59, 4.0, 159], nao).
diabetes([waldisney, masculino, 60.0, nao, nao, passado, 25.4, 4.0, 200], nao).
diabetes([reinaldo, masculino, 27.0, nao, nao, passado, 27.32, 3.5, 100], nao).
diabetes([frederico, masculino, 54.0, nao, nao, passado, 30.41, 5.0, 158], nao).

diagnosticar_diabetes(Nome, Sexo, Idade, Hiper, Card, Fumante, IMC, Hemoglobina, Glicose, StatusDiabetes) :-
    Counter is 0,
    (Hiper == sim -> Counter1 is Counter + 2; Counter1 is Counter),
    (Card == sim -> Counter2 is Counter1 + 1; Counter2 is Counter1),
    (Fumante == sim -> Counter3 is Counter2 + 2; (Fumante == nunca -> Counter3 is Counter2 + 1; Counter3 is Counter2)),
    (Hemoglobina >= 6.1 -> Counter4 is Counter3 + 3; Counter4 is Counter3),
    (Glicose > 100 -> Counter5 is Counter4 + 3; Counter5 is Counter4),
    (Glicose > 126 -> Counter6 is Counter5 + 5; Counter6 is Counter5),
    (Counter6 >= 11 -> StatusDiabetes = sim; StatusDiabetes = nao).


calcular_imc :-
    write('Digite o peso do paciente (em kg): '), nl,
    read(Peso),
    write('Digite a altura do paciente (em metros): '), nl,
    read(Altura),
    IMC is Peso / (Altura * Altura),
    write('O IMC do paciente é: '), write(IMC), nl.

imc(Peso, Altura, IMC) :-
    IMC is Peso / (Altura * Altura).

adicionar_paciente :-
    write('Digite o nome do paciente: '), nl,
    read(Nome),
    write('Digite o sexo do paciente: '), nl,
    read(Sexo),
    write('Digite a idade do paciente: '), nl,
    read(Idade),
    write('O paciente tem hipertensão? (sim, nao): '), nl,
    read(Hiper),
    write('O paciente tem problemas cardíacos? (sim, nao): '), nl,
    read(Card),
    write('O paciente é fumante? (sim, passado, nunca): '), nl,
    read(Fumante),
    calcular_imc, 
    write('Digite o nivel de Hemoglobina do paciente: '), nl,
    read(Hemoglobina),
    write('Digite o nivel de Glicose do paciente: '), nl,
    read(Glicose),
    diagnosticar_diabetes(Nome, Sexo, Idade, Hiper, Card, Fumante, IMC, Hemoglobina, Glicose, StatusDiabetes),
    assertz(diabetes([Nome, Sexo, Idade, Hiper, Card, Fumante, IMC, Hemoglobina, Glicose], StatusDiabetes)).

listar_todos_pacientes :-
    diabetes(Atributos, StatusDiabetes),
    write(Atributos), write(' - Status de Diabetes: '), write(StatusDiabetes), nl,
    fail.
listar_todos_pacientes. 

editar_atributo(NomePaciente, Atributo, NovoValor) :-
(
    Atributo = 'Nome' -> editar_nome(NomePaciente, NovoValor);
    Atributo = 'Sexo' -> editar_sexo(NomePaciente, NovoValor);
    Atributo = 'Idade' -> editar_idade(NomePaciente, NovoValor);
    Atributo = 'Hipertensão' -> editar_hipertensao(NomePaciente, NovoValor);
    Atributo = 'Problemas Cardíacos' -> editar_problemas_cardiacos(NomePaciente, NovoValor);
    Atributo = 'Fumante' -> editar_fumante(NomePaciente, NovoValor);
    Atributo = 'IMC' -> editar_imc(NomePaciente, NovoValor);
    Atributo = 'Hemoglobina' -> editar_hemoglobina(NomePaciente, NovoValor);
    Atributo = 'Glicose' -> editar_glicose(NomePaciente, NovoValor);
    Atributo = 'Status de Diabetes' -> editar_status_diabetes(NomePaciente, NovoValor)
).

editar_nome(NomePaciente, NovoValor) :-
    write('Digite o novo valor para Nome: '), nl, read(NovoValor),
    retract(diabetes([NomePaciente, Sexo, Idade, Hiper, Card, Fumante, IMC, Hemoglobina, Glicose], StatusDiabetes)),
    assertz(diabetes([NovoValor, Sexo, Idade, Hiper, Card, Fumante, IMC, Hemoglobina, Glicose], StatusDiabetes)).

editar_sexo(NomePaciente, NovoValor) :-
    write('Digite o novo valor para Sexo: '), nl, read(NovoValor),
    retract(diabetes([NomePaciente, _, Idade, Hiper, Card, Fumante, IMC, Hemoglobina, Glicose], StatusDiabetes)),
    assertz(diabetes([NomePaciente, NovoValor, Idade, Hiper, Card, Fumante, IMC, Hemoglobina, Glicose], StatusDiabetes)).

editar_idade(NomePaciente, NovoValor) :-
    write('Digite o novo valor para Idade: '), nl, read(NovoValor),
    retract(diabetes([NomePaciente, Sexo, _, Hiper, Card, Fumante, IMC, Hemoglobina, Glicose], StatusDiabetes)),
    assertz(diabetes([NomePaciente, Sexo, NovoValor, Hiper, Card, Fumante, IMC, Hemoglobina, Glicose], StatusDiabetes)).

editar_hipertensao(NomePaciente, NovoValor) :-
    write('Digite o novo valor para Hipertensão (sim, nao): '), nl, read(NovoValor),
    retract(diabetes([NomePaciente, Sexo, Idade, _, Card, Fumante, IMC, Hemoglobina, Glicose], StatusDiabetes)),
    assertz(diabetes([NomePaciente, Sexo, Idade, NovoValor, Card, Fumante, IMC, Hemoglobina, Glicose], StatusDiabetes)).

editar_problemas_cardiacos(NomePaciente, NovoValor) :-
    write('Digite o novo valor para Problemas Cardíacos (sim, nao): '), nl, read(NovoValor),
    retract(diabetes([NomePaciente, Sexo, Idade, Hiper, _, Fumante, IMC, Hemoglobina, Glicose], StatusDiabetes)),
    assertz(diabetes([NomePaciente, Sexo, Idade, Hiper, NovoValor, Fumante, IMC, Hemoglobina, Glicose], StatusDiabetes)).

editar_fumante(NomePaciente, NovoValor) :-
    write('Digite o novo valor para Fumante (sim, passado, nunca): '), nl, read(NovoValor),
    retract(diabetes([NomePaciente, Sexo, Idade, Hiper, Card, _, IMC, Hemoglobina, Glicose], StatusDiabetes)),
    assertz(diabetes([NomePaciente, Sexo, Idade, Hiper, Card, NovoValor, IMC, Hemoglobina, Glicose], StatusDiabetes)).

editar_imc(NomePaciente, NovoValor) :-
    write('Digite o novo valor para IMC: '), nl, read(NovoValor),
    retract(diabetes([NomePaciente, Sexo, Idade, Hiper, Card, Fumante, _, Hemoglobina, Glicose], StatusDiabetes)),
    assertz(diabetes([NomePaciente, Sexo, Idade, Hiper, Card, Fumante, NovoValor, Hemoglobina, Glicose], StatusDiabetes)).

editar_hemoglobina(NomePaciente, NovoValor) :-
    write('Digite o novo valor para Hemoglobina: '), nl, read(NovoValor),
    retract(diabetes([NomePaciente, Sexo, Idade, Hiper, Card, Fumante, IMC, _, Glicose], StatusDiabetes)),
    assertz(diabetes([NomePaciente, Sexo, Idade, Hiper, Card, Fumante, IMC, NovoValor, Glicose], StatusDiabetes)).

editar_glicose(NomePaciente, NovoValor) :-
    write('Digite o novo valor para Glicose: '), nl, read(NovoValor),
    retract(diabetes([NomePaciente, Sexo, Idade, Hiper, Card, Fumante, IMC, Hemoglobina, _], StatusDiabetes)),
    assertz(diabetes([NomePaciente, Sexo, Idade, Hiper, Card, Fumante, IMC, Hemoglobina, NovoValor], StatusDiabetes)).

editar_status_diabetes(NomePaciente, NovoValor) :-
    write('Digite o novo valor para Status de Diabetes (sim, nao): '), nl, read(NovoValor),
    retract(diabetes([NomePaciente, Sexo, Idade, Hiper, Card, Fumante, IMC, Hemoglobina, Glicose], _)),
    assertz(diabetes([NomePaciente, Sexo, Idade, Hiper, Card, Fumante, IMC, Hemoglobina, Glicose], NovoValor)).

remover_paciente :-
    write('Digite o nome do paciente que deseja remover: '), nl, read(NomePaciente),
    retract(diabetes([NomePaciente, _, _, _, _, _, _, _, _], _)),
    write('Paciente removido com sucesso.').



editar_paciente :-
    write('Escolha um paciente para editar (digite o nome): '), nl,
    read(NomePaciente),
    (
        diabetes([NomePaciente, Sexo, Idade, Hiper, Card, Fumante, IMC, Hemoglobina, Glicose], StatusDiabetes),
        write('Paciente encontrado. Atributos atuais: '), nl,
        write('Nome: '), write(NomePaciente), nl,
        write('Sexo: '), write(Sexo), nl,
        write('Idade: '), write(Idade), nl,
        write('Hipertensão: '), write(Hiper), nl,
        write('Problemas Cardíacos: '), write(Card), nl,
        write('Fumante: '), write(Fumante), nl,
        write('IMC: '), write(IMC), nl,
        write('Hemoglobina: '), write(Hemoglobina), nl,
        write('Glicose: '), write(Glicose), nl,
        write('Status de Diabetes: '), write(StatusDiabetes), nl,
        write('Escolha o que deseja editar:'), nl,
        write('1 - Nome'), nl,
        write('2 - Sexo'), nl,
        write('3 - Idade'), nl,
        write('4 - Hipertensão'), nl,
        write('5 - Problemas Cardíacos'), nl,
        write('6 - Fumante'), nl,
        write('7 - IMC'), nl,
        write('8 - Hemoglobina'), nl,
        write('9 - Glicose'), nl,
        write('10 - Status de Diabetes'), nl,
        read(OpcaoEditar),
        (
            OpcaoEditar = 1 -> editar_atributo(NomePaciente, 'Nome', _);
            OpcaoEditar = 2 -> editar_atributo(NomePaciente, 'Sexo', _);
            OpcaoEditar = 3 -> editar_atributo(NomePaciente, 'Idade', _);
            OpcaoEditar = 4 -> editar_atributo(NomePaciente, 'Hipertensão', _);
            OpcaoEditar = 5 -> editar_atributo(NomePaciente, 'Problemas Cardíacos', _);
            OpcaoEditar = 6 -> editar_atributo(NomePaciente, 'Fumante', _);
            OpcaoEditar = 7 -> editar_atributo(NomePaciente, 'IMC', _);
            OpcaoEditar = 8 -> editar_atributo(NomePaciente, 'Hemoglobina', _);
            OpcaoEditar = 9 -> editar_atributo(NomePaciente, 'Glicose', _);
            OpcaoEditar = 10 -> editar_atributo(NomePaciente, 'Status de Diabetes', _)
        ),
        main
    ;
        write('Paciente não encontrado.')
    ).


main :-
    write('1 - Adicionar paciente'), nl,
    write('2 - Listar todos os pacientes'), nl,
    write('3 - Editar paciente'), nl,
    write('4 - Remover Paciente'), nl,
    write('5 - Calcular IMC'), nl,
    write('7 - Diagnosticar Paciente'), nl,
    write('8 - Sair'), nl,
    
    read(Opcao),
    (
        Opcao = 1 -> adicionar_paciente, main;
        Opcao = 2 -> listar_todos_pacientes, main;
        Opcao = 3 -> editar_paciente, main;
        Opcao = 4 -> remover_paciente, main;
        Opcao = 5 -> calcular_imc, main;
        Opcao = 6 -> diagnosticar_paciente, main;
        Opcao = 7 -> sair
    ).

sair :- halt.

:- initialization(main).