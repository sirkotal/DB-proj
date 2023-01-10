.mode columns
.headers ON
.nullvalue NULL

PRAGMA FOREIGN_KEYS = ON;

SELECT Equipa.nome AS EQUIPAS, Equipa.pais AS PAIS,  codGrupo AS GRUPO
FROM Equipa, Grupo
WHERE (Equipa.nome=grupo.equipa1
OR Equipa.nome=grupo.equipa2
OR Equipa.nome=grupo.equipa2
OR Equipa.nome=grupo.equipa3
OR Equipa.nome=grupo.equipa4)
AND (Equipa.pais='Brasil' OR Equipa.pais='Chile')
AND (Equipa.ranking < 100)
ORDER BY codGrupo;