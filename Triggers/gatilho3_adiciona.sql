CREATE TRIGGER teams
        BEFORE INSERT
            ON Equipa
      FOR EACH ROW
BEGIN
    SELECT CASE WHEN ( (
                           SELECT COUNT(idEquipa) 
                             FROM Equipa
                       )
=              47) THEN RAISE(ABORT, "Valor maximo de equipas atingido. Precisa remover uma equipa antes") END;
END;