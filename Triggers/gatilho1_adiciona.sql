CREATE Trigger IF NOT EXISTS out_date BEFORE INSERT ON Jogo
    WHEN EXISTS (
        SELECT faseJogo, dataJogo FROM Jogo, Fase 
            WHERE (NEW.faseJogo = Fase.nomeFase 
                AND (
                    (NEW.dataJogo < Fase.dataInicio)
                    OR
                    (NEW.dataJogo > Fase.dataFim) 
                    )))
 
        BEGIN
            SELECT RAISE(ABORT, 'Essa fase da competição já passou!');
END;