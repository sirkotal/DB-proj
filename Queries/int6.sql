.mode columns
.headers on
.nullvalue NULL

PRAGMA FOREIGN_KEYS = ON;

select CLUBE CLUBE, j.nome NOME, count(g.idGolo) GOLOS
from golo g , jogador j, evento e,(select idj, max(DIF)  
from
(

select idjogo idj, abs(cast(substr(resultado,1,1) as int) - cast(substr(resultado,3,1) as int)) DIF

 from jogo 
))
where g.idevento = e.idevento and e.idjogo = idj and g.idjogador = j.idjogador
group by g.idjogador
order by 3 desc ,1,2;