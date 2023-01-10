.mode columns
.headers ON
.nullvalue NULL

PRAGMA FOREIGN_KEYS = ON;

SELECT Tcartoes.nome AS Nome, Tcartoes.clube AS Clube, Tgolos.golos AS Golos, count(Tcartoes.idJogador) AS CartõesAmarelos
FROM ((SELECT DISTINCT Jogador.idJogador, nome, clube, idFalta, cartao FROM Jogador 
JOIN Falta ON 
Jogador.idJogador = Falta.idJogador) as Tcartoes, (SELECT Golo.idJogador, count(Golo.idJogador) AS golos FROM Golo, Jogo, Evento
WHERE Golo.idEvento = Evento.idEvento AND Evento.idJogo = Jogo.idJogo GROUP BY 1) AS Tgolos) WHERE Tgolos.idJogador = Tcartoes.idJogador
AND Tcartoes.cartao = "Y"
GROUP BY 1 ORDER BY 3 DESC, 4 DESC, 2 ASC;