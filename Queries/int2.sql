.mode columns
.headers ON
.nullvalue NULL

PRAGMA FOREIGN_KEYS = ON;

SELECT Jogador.nome, Jogador.clube, count(GolosF.idJogador) AS Golos FROM Jogador, (SELECT Golo.idJogador FROM Golo, Jogo, Evento
WHERE Golo.idEvento = Evento.idEvento AND Evento.idJogo = Jogo.idJogo AND Jogo.faseJogo = "QF") AS GolosF WHERE Jogador.idJogador = GolosF.idJogador 
GROUP BY 1 ORDER BY 3 DESC, 2 ASC LIMIT 5;