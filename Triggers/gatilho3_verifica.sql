.mode columns
.headers on
.nullvalue NULL

PRAGMA FOREIGN_KEYS = ON;

SELECT * FROM Equipa;
INSERT INTO Equipa VALUES(48,'Botafogo','Luís Castro', 'Brasil',88,1);
INSERT INTO Equipa VALUES(64,'Racing Club','Fernando Gago', 'Argentina',91,1);
SELECT * FROM Equipa;