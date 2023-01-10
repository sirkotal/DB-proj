.mode columns
.headers on
.nullvalue NULL

PRAGMA FOREIGN_KEYS = ON;

select nome JOGADOR, clube EQUIPA, max(golos) GOLOS_JOGADOR 
from jogador,
        (
        select idJogador idJog, count(g.idGolo) golos 
        from golo g
        group by 1
        )

    where idJogador = idJog
    group by 2
    order by 3 desc
    ;