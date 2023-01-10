.mode columns
.headers ON
.nullvalue NULL

PRAGMA FOREIGN_KEYS = ON;

SELECT tab.team AS EQUIPA, Equipa.treinador AS TREINADOR, tab.fase AS FASE, tab.res AS SALDO
FROM 
(select Resultados.nomeEquipa as team, Resultados.golosMarcados-Resultados.golosSofridos as res, Resultados.faseAtual as fase
from Resultados) AS tab, Equipa
WHERE Equipa.nome=tab.team
AND SALDO >=1
ORDER BY SALDO desc;