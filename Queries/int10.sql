.mode columns
.headers on
.nullvalue NULL

PRAGMA FOREIGN_KEYS = ON;

select EQUIPA_CASA EQUIPA_CASA, RESULTADO RESULTADO, EQUIPA_FORA EQUIPA_FORA, djg DATA_DO_JOGO
from (
    select dataJogo djg, equipaCasa EQUIPA_CASA, resultado RESULTADO, equipaFora EQUIPA_FORA
    from Jogo
    where cast(substr(djg,7,1) as int) = 3
    );