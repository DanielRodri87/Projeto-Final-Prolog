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
diabetes([isis, feminino, 80.0, nao, nao, nunca, 22.04, 9.0, 209], sim).
diabetes([francivaldo, masculino, 63.0, nao, sim, passado, 27.32, 6.6, 300], sim).
diabetes([juvelino, masculino, 58.0, nao, nao, passado, 32.38, 6.6, 159], sim).
diabetes([maya, feminino, 43.0, sim, nao, nunca, 34.21, 9.0, 160], sim).
diabetes([genetildes, masculino, 56.0, nao, nao, nunca, 37.59, 4.0, 159], nao).
diabetes([waldisney, masculino, 60.0, nao, nao, passado, 25.4, 4.0, 200], nao).
diabetes([reinaldo, masculino, 27.0, nao, nao, passado, 27.32, 3.5, 100], nao).
diabetes([frederico, masculino, 54.0, nao, nao, passado, 30.41, 5.0, 158], nao).

intervalo_hemoglobina_status_sim_diabetes(MediaH, MinHemo) :-
    findall(Hemoglobina, diabetes([_, _, _, _, _, _, _, Hemoglobina, _], sim), ListaHemoglobina),
    length(ListaHemoglobina, Tamanho),
    (Tamanho > 0 -> 
        sumlist(ListaHemoglobina, Soma),
        MediaH is Soma / Tamanho,
        min_list(ListaHemoglobina, MinHemo)
    ; 
        MediaH is 0,
        MinHemo is 0
    ).

intervalo_glicose_status_sim_diabetes(MediaG, MinGlicose) :-
    findall(Glicose, diabetes([_, _, _, _, _, _, _, _, Glicose], sim), ListaGlicose),
    length(ListaGlicose, Tamanho),
    (Tamanho > 0 -> 
        sumlist(ListaGlicose, Soma),
        MediaG is Soma / Tamanho,
        min_list(ListaGlicose, MinGlicose)
    ; 
        MediaG is 0,
        MinGlicose is 0
    ).


    diagnosticar_diabetes(Nome, Sexo, Idade, Hiper, Card, Fumante, IMC, Hemoglobina, Glicose, Sedentario, HistDiabetes, SedeFrequente, StatusDiabetes) :-
        (Hiper == sim -> Counter1 is 2; Counter1 is 0),
        (Card == sim -> Counter2 is Counter1 + 1; Counter2 is Counter1),
        (Fumante == sim -> Counter3 is Counter2 + 2; (Fumante == passado -> Counter3 is Counter2 + 1; Counter3 is Counter2)),
    
        (IMC > 24.9, IMC < 29.9 -> Counter4 is Counter3 + 1; (IMC >= 30 -> Counter4 is Counter3 + 2; Counter4 is Counter3)),
    
        intervalo_hemoglobina_status_sim_diabetes(MediaHemoglobinaSim, MinHemo),
        intervalo_glicose_status_sim_diabetes(MediaGlicoseSim, MinGlicose),
    
        (Hemoglobina > MediaHemoglobinaSim -> Counter5 is Counter4 + 11; Counter5 is Counter4),
    
        (Glicose > MediaGlicoseSim -> Counter6 is Counter5 + 2; Counter6 is Counter5),
        (Hemoglobina > MinHemo -> Counter7 is Counter6 + 2; Counter7 is Counter6),
    
        (Sedentario == sim -> Counter8 is Counter7 + 1; Counter8 is Counter7),
        (HistDiabetes == sim -> Counter9 is Counter8 + 2; Counter9 is Counter8),
        (SedeFrequente == sim -> Counter10 is Counter9 + 3; Counter10 is Counter9),
    
        (Counter10 >= 5 -> StatusDiabetes = sim; StatusDiabetes = nao).
    

calcular_imc(Altura, Peso, IMC) :-
    write('Digite a altura do paciente: (em metros) '), nl,
    read(Altura),
    write('Digite o peso do paciente: (em kg) '), nl,
    read(Peso),
    IMC is Peso / (Altura * Altura),
    write('IMC: '), write(IMC), nl.

adicionar_paciente :-
    write('----------------------------- ADICIONAR PACIENTE -----------------------------'), nl,
    write('                                                                              '), nl,
    write('  Preencha os campos abaixo para adicionar um novo paciente.                  '), nl,
    write('  Perguntas Obrigatorias (*)                                                  '), nl,
    write('  Opcionais podem ser respondidas por _                                       '), nl,
    write('                                                                              '), nl,
    write('------------------------------------------------------------------------------'), nl,
    write('Digite o nome do paciente: (*) '), nl,
    read(Nome),
    (
        Nome = '_',
        write('Atributo obrigatorio\n\n'),
        !, main
    ;
        true
    ),
    write('Digite o sexo do paciente: (*) '), nl,
    read(Sexo),
    (
        Sexo = '_',
        write('Atributo obrigatorio\n\n'),
        !, main
    ;
        true
    ),
    write('Digite a idade do paciente: (*) '), nl,
    read(Idade),
    (
        Idade = '_',
        write('Atributo obrigatorio\n\n'),
        !, main
    ;
        true
    ),
    write('Digite o nivel de Hemoglobina do paciente: (*) '), nl,
    read(Hemoglobina),
    (
        Hemoglobina = '_',
        write('Atributo obrigatorio\n\n'),
        !, main
    ;
        true
    ),
    write('Digite o nivel de Glicose do paciente: (*) '), nl,
    read(Glicose),
    (
        Glicose = '_',
        write('Atributo obrigatorio\n\n'),
        !, main
    ;
        true
    ),
    write('O paciente tem hipertensao? (sim, nao, _ ): '), nl,
    read(Hiper),
    write('O paciente tem problemas cardiacos? (sim, nao, _): '), nl,
    read(Card),
    write('O paciente e fumante? (sim, passado, nunca, _): '), nl,
    read(Fumante),
    write('Digite o IMC do paciente ou 0 para vazio: '), nl,
    read(IMC),
    count_responded([Hiper, Card, Fumante, IMC], Count),

    (
        Count =:= 0 ->
            write('Sugiro novos exames e para novo diagnostico.\n\n'), nl,
            main
        ;
        Count =:= 1 ->
            write('Voce se considera uma pessoa sedentaria? (sim, nao, _): '), nl,
            read(Sedentario),
            write('Voce tem historico de diabetes familiar? (sim, nao, _): '), nl,
            read(HistDiabetes),
            write('Voce sente sede frequentemente? (sim, nao, _): '), nl,
            read(SedeFrequente),
            diagnosticar_diabetes(Nome, Sexo, Idade, Hiper, Card, Fumante, IMC, Hemoglobina, Glicose, Sedentario, HistDiabetes, SedeFrequente, StatusDiabetes),
            assertz(diabetes([Nome, Sexo, Idade, Hiper, Card, Fumante, IMC, Hemoglobina, Glicose, Sedentario, HistDiabetes, SedeFrequente], StatusDiabetes))
        ;
        Count =:= 2 ->
            write('Voce se considera uma pessoa sedentaria? (sim, nao, _): '), nl,
            read(Sedentario),
            write('Voce tem historico de diabetes familiar? (sim, nao, _): '), nl,
            read(HistDiabetes),
            diagnosticar_diabetes(Nome, Sexo, Idade, Hiper, Card, Fumante, IMC, Hemoglobina, Glicose, Sedentario, HistDiabetes, SedeFrequente, StatusDiabetes),
            assertz(diabetes([Nome, Sexo, Idade, Hiper, Card, Fumante, IMC, Hemoglobina, Glicose, Sedentario, HistDiabetes], StatusDiabetes))
        ;
        Count >= 3 ->
            diagnosticar_diabetes(Nome, Sexo, Idade, Hiper, Card, Fumante, IMC, Hemoglobina, Glicose, Sedentario, HistDiabetes, SedeFrequente, StatusDiabetes),
            assertz(diabetes([Nome, Sexo, Idade, Hiper, Card, Fumante, IMC, Hemoglobina, Glicose], StatusDiabetes))
    ).


count_responded([], 0).
count_responded([Resposta | Resto], Count) :-
    (Resposta \= '_', Resposta \= 0 ->
        count_responded(Resto, CountResto),
        Count is CountResto + 1 
    ;
        count_responded(Resto, CountResto),
        Count is CountResto
    ).

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
    Atributo = 'Hipertensao' -> editar_hipertensao(NomePaciente, NovoValor);
    Atributo = 'Problemas Cardiacos' -> editar_problemas_cardiacos(NomePaciente, NovoValor);
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
    write('Digite o novo valor para Hipertensao (sim, nao): '), nl, read(NovoValor),
    retract(diabetes([NomePaciente, Sexo, Idade, _, Card, Fumante, IMC, Hemoglobina, Glicose], StatusDiabetes)),
    assertz(diabetes([NomePaciente, Sexo, Idade, NovoValor, Card, Fumante, IMC, Hemoglobina, Glicose], StatusDiabetes)).

editar_problemas_cardiacos(NomePaciente, NovoValor) :-
    write('Digite o novo valor para Problemas Cardiacos (sim, nao): '), nl, read(NovoValor),
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
        assertz(diabetes([NomePaciente, Sexo, Idade, Hiper, Card, Fumante, IMC, NovoValor, Glicose], StatusDiabetes)),
        diagnosticar_diabetes(NomePaciente, Sexo, Idade, Hiper, Card, Fumante, IMC, NovoValor, Glicose, Sedentario, HistDiabetes, SedeFrequente, NovoStatus),
        retract(diabetes([NomePaciente, Sexo, Idade, Hiper, Card, Fumante, IMC, NovoValor, Glicose], _)),
        assertz(diabetes([NomePaciente, Sexo, Idade, Hiper, Card, Fumante, IMC, NovoValor, Glicose], NovoStatus)).
    
    editar_glicose(NomePaciente, NovoValor) :-
        write('Digite o novo valor para Glicose: '), nl, read(NovoValor),
        retract(diabetes([NomePaciente, Sexo, Idade, Hiper, Card, Fumante, IMC, Hemoglobina, _], StatusDiabetes)),
        assertz(diabetes([NomePaciente, Sexo, Idade, Hiper, Card, Fumante, IMC, Hemoglobina, NovoValor], StatusDiabetes)),
        diagnosticar_diabetes(NomePaciente, Sexo, Idade, Hiper, Card, Fumante, IMC, Hemoglobina, NovoValor, Sedentario, HistDiabetes, SedeFrequente, NovoStatus),
        retract(diabetes([NomePaciente, Sexo, Idade, Hiper, Card, Fumante, IMC, Hemoglobina, NovoValor], _)),
        assertz(diabetes([NomePaciente, Sexo, Idade, Hiper, Card, Fumante, IMC, Hemoglobina, NovoValor], NovoStatus)).

editar_status_diabetes(NomePaciente, NovoValor) :-
    write('Digite o novo valor para Status de Diabetes (sim, nao): '), nl, read(NovoValor),
    retract(diabetes([NomePaciente, Sexo, Idade, Hiper, Card, Fumante, IMC, Hemoglobina, Glicose], _)),
    assertz(diabetes([NomePaciente, Sexo, Idade, Hiper, Card, Fumante, IMC, Hemoglobina, Glicose], NovoValor)).

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
        main
    ;
        write('Paciente nao encontrado.')
    ).
    
remover_paciente :-
    write('Digite o nome do paciente que deseja remover: '), nl,
    read(NomePaciente),
    (
        diabetes(PacienteRemover, StatusDiabetes),
        nth0(0, PacienteRemover, NomePaciente), 
        retract(diabetes(PacienteRemover, StatusDiabetes)), 
        write('Paciente removido com sucesso.')
    ;
        write('Nenhum paciente encontrado com esse nome.')
    ).
    

main :-
    write('----------------------------------------------------------------------------'), nl,
    write('|                                                                          |'), nl,
    write('|                                                                          |'), nl,
    write('|          ::: ( )_( )...*...*...*...*...*...*...*...( )_( )               |'), nl,
    write('|                                                                          |'), nl,
    write('|            :: -->    SISTEMA DE APOIO DIABETICOS                         |'), nl,
    write('|                                                                          |'), nl,
    write('|          ::: ( )_( )...*...*...*...*...*...*...*...( )_( )               |'), nl,
    write('|                                                                          |'), nl,
    write('|                                                                          |'), nl,
    write('----------------------------------------------------------------------------'), nl,

    write('----------------------------- MENU -----------------------------------------'), nl,
    write('| 1 - Adicionar paciente'), nl,
    write('| 2 - Listar todos os pacientes'), nl,
    write('| 3 - Editar paciente'), nl,
    write('| 4 - Remover paciente'), nl,
    write('| 5 - Sair'), nl,
    write('----------------------------------------------------------------------------'), nl,
    write('-> '),
    
    read(Opcao),
    (
        Opcao = 1 -> adicionar_paciente, main;
        Opcao = 2 -> listar_todos_pacientes, main;
        Opcao = 3 -> editar_paciente, main;
        Opcao = 4 -> remover_paciente, main;
        Opcao = 5 -> sair
    ).

sair :- halt.