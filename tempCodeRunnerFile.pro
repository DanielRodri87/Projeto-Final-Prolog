diagnosticar_diabetes(Nome, Sexo, Idade, Hiper, Card, Fumante, IMC, Hemoglobina, Glicose, Sedentario, HistDiabetes, SedeFrequente, StatusDiabetes) :-
    (Hiper == sim -> Cont1 is 2; Cont1 is 0),
    (Card == sim -> Cont2 is Cont1 + 1; Cont2 is Cont1),
    (Fumante == sim -> Cont3 is Cont2 + 2; (Fumante == passado -> Cont3 is Cont2 + 1; Cont3 is Cont2)),

    (IMC > 24.9, IMC < 29.9 -> Cont4 is Cont3 + 1; (IMC >= 30 -> Cont4 is Cont3 + 2; Cont4 is Cont3)),

    intervalo_hemoglobina_status_sim_diabetes(MediaHemoglobinaSim, MinHemo),
    intervalo_glicose_status_sim_diabetes(MediaGlicoseSim, MinGlicose),

    (Hemoglobina > 8.9, Glicose > MediaGlicoseSim -> 
        (Cont5 is Cont4 + 11, StatusDiabetes = sim);
        (Cont5 is Cont4, StatusDiabetes = nao)),

    (Glicose > MediaGlicoseSim -> Cont6 is Cont5 + 2; Cont6 is Cont5),
    (Hemoglobina > MinHemo -> Cont7 is Cont6 + 2; Cont7 is Cont6),

    (Sedentario == sim -> Cont8 is Cont7 + 1; Cont8 is Cont7),
    (HistDiabetes == sim -> Cont9 is Cont8 + 2; Cont9 is Cont8),
    (SedeFrequente == sim -> Cont10 is Cont9 + 3; Cont10 is Cont9),

    write('Contador final: '), write(Cont10), nl,
    (Cont10 >= 5 -> StatusDiabetes = sim; StatusDiabetes = nao).
