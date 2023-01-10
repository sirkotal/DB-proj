.mode columns
.headers ON
.nullvalue NULL

PRAGMA FOREIGN_KEYS = ON;

SELECT clube CLUBE , sum(faltas) FALTAS
from (SELECT count(*) faltas, clube
FROM falta f, Jogador j, evento e, jogo jo
where f.idjogador = j.idjogador and e.idevento = f.idevento and e.idjogo = jo.idjogo and jo.fasejogo = 'FI'
group by f.idjogador)
group by 1;