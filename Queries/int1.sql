.mode columns
.headers ON
.nullvalue NULL

PRAGMA FOREIGN_KEYS = ON;

SELECT Equipa.nome AS Equipa, Equipa.pais AS País, Equipa.ranking AS Ranking, count(*) AS Número FROM Equipa, Jogador WHERE 
Equipa.ranking <= 50 AND Equipa.apuramento AND Jogador.país = "Brasil" AND Jogador.clube = Equipa.nome <> 0 GROUP BY 1 ORDER BY 4 DESC LIMIT 1;