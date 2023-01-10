.mode columns
.headers on
.nullvalue NULL

PRAGMA FOREIGN_KEYS = ON;

INSERT INTO Fase VALUES(4,'QF','2022-08-03', '2022-08-12');

SELECT * FROM Jogo;
INSERT INTO Jogo VALUES(24,'QF','2022-08-13', NULL, 'Corinthians', 'Flamengo', "4-3");
INSERT INTO Jogo VALUES(25,'QF','2022-07-01', NULL, 'Atlético-MG', 'Palmeiras', "0-1");
INSERT INTO Jogo VALUES(26,'QF','2022-08-04', NULL, 'Vélez Sarsfield', 'Talleres', "2-0");
SELECT * FROM Jogo;