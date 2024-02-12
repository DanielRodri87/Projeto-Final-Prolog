
adicionar_paciente :-
    write('Perguntas opcionais: use _ para não responder.'), nl,
    write('Digite o nome do paciente: (*) '), nl,
    read(Nome),
    write('Digite o sexo do paciente: (*) '), nl,
    read(Sexo),
    write('Digite a idade do paciente: (*) '), nl,
    read(Idade),
    write('O paciente tem hipertensão? (sim, nao, _ ): '), nl,
    read(Hiper),
    write('O paciente tem problemas cardíacos? (sim, nao, _): '), nl,
    read(Card),
    write('O paciente é fumante? (sim, passado, nunca, _): '), nl,
    read(Fumante),
    write('Digite o IMC do paciente ou _: '), nl,
    read(IMC_input),
    (IMC_input == '_' -> IMC = 0 ; IMC = IMC_input),
    write('Digite o nivel de Hemoglobina do paciente: (*) '), nl,
    read(Hemoglobina),
    write('Digite o nivel de Glicose do paciente: (*) '), nl,
    read(Glicose),

    count_responded([Hiper, Card, Fumante, IMC], Count),

    (Count < 2 -> 
        write('Erro: Responda pelo menos duas das perguntas opcionais.'), nl, 
        fail
    ;
        (Count =:= 2 ; Count =:= 3) ->
            write('Você se considera uma pessoa sedentária? (sim, nao, _): '), nl,
            read(Sedentario),
            write('Você tem histórico de diabetes familiar? (sim, nao, _): '), nl,
            read(HistDiabetes),
            diagnosticar_diabetes(Nome, Sexo, Idade, Hiper, Card, Fumante, IMC, Hemoglobina, Glicose, StatusDiabetes),
            assertz(diabetes([Nome, Sexo, Idade, Hiper, Card, Fumante, IMC, Hemoglobina, Glicose], StatusDiabetes))
        ;
            diagnosticar_diabetes(Nome, Sexo, Idade, Hiper, Card, Fumante, IMC, Hemoglobina, Glicose, StatusDiabetes),
            assertz(diabetes([Nome, Sexo, Idade, Hiper, Card, Fumante, IMC, Hemoglobina, Glicose], StatusDiabetes))
    ).

count_responded([], 0).
count_responded([Resposta | Resto], Count) :-
    (Resposta \= '_' -> count_responded(Resto, CountResto), Count is CountResto + 1 ;
        count_responded(Resto, CountResto), Count is CountResto).
