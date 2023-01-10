CREATE TRIGGER Groups
AFTER UPDATE ON Grupo
FOR EACH ROW
BEGIN
SELECT CASE
WHEN ((select Grupo.equipa1 from Grupo) NOT IN (select Equipa.nome from Equipa))
OR ((select Grupo.equipa2 from Grupo) NOT IN (select Equipa.nome from Equipa))
OR ((select Grupo.equipa3 from Grupo) NOT IN (select Equipa.nome from Equipa))
OR ((select Grupo.equipa4 from Grupo) NOT IN (select Equipa.nome from Equipa)) THEN
RAISE(ABORT, 'A equipa introduzida nao esta na Copa Libertadores') END;
END;