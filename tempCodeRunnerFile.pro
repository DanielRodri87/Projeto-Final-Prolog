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
