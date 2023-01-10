.mode columns
.header on
.nullvalue NULL

PRAGMA foreign_keys = ON;

.print 'Condicao de update que testa o Trigger Groups no grupo A'
.print ' '

UPDATE Grupo
SET equipa1 = 'Porto'
WHERE codGrupo='A';

.print 'Testar novamente noutra coluna'
.print ' ' 

UPDATE Grupo
SET equipa3 = 'Benfica'
WHERE codGrupo='A';

.print 'Verificar se houve alguma alteracao nas equipas do grupo A'
.print ' ' 

SELECT *
FROM Grupo
WHERE codGrupo='A';

