/* Mostrar dados */
SELECT * FROM MATERIA;

SELECT * FROM ALUNO WHERE IdAluno = 3;

SELECT * FROM ALUNO;

SELECT * FROM ALUNO ORDER BY Nome ASC; -- Ordenar por nome do aluno de forma ascendente 

SELECT * FROM ALUNO ORDER BY Nome DESC; -- Ordenar por nome do aluno de forma decrescente 

-- Buscar com Like
SELECT * FROM ALUNO WHERE Nome LIKE 'a%';

SELECT IdTrabalho, Nome, Ra, Materia, Nota FROM TRABALHO AS TR INNER JOIN ALUNO AS AL ON AL.IdAluno = TR.IdAluno 
INNER JOIN MATERIA AS MA ON MA.Id_Materia = TR.Id_Materia;


--  Gatilho que printa que o registro foi inserido com sucesso
CREATE TRIGGER MsgSucesso
ON ALUNO
AFTER INSERT
AS
PRINT ' '
PRINT'Dados Inseridos Com Sucesso';

-- Exclui a trigger
DROP TRIGGER MsgSucesso
