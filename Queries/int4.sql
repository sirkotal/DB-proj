.mode columns
.headers on
.nullvalue NULL

PRAGMA FOREIGN_KEYS = ON;

select clube CLUBE, round(AVG(idade),1) IDADES_EQUIPA
    from Jogador
    group by 1
    order by 2 desc
    ;