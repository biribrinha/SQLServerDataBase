-- Criar Banco   
CREATE DATABASE boletim;

-- Excluir Banco de Dados
DROP DATABASE boletim;

-- Usar o Banco
USE boletim;

-- Criar Tabela de Aluno
-- Not Null - Serve para obrigar o dado a ser preenchido
-- Identity - Serve para autoincrementar um dado
CREATE TABLE ALUNO 
(
	IdAluno INT IDENTITY PRIMARY KEY NOT NULL,
	Nome VARCHAR(100) NOT NULL,
	Ra VARCHAR(20) UNIQUE NOT NULL,
	Idade INT

);

CREATE TABLE MATERIA
(
	Id_Materia INT IDENTITY PRIMARY KEY NOT NULL,
	Materia VARCHAR(30) UNIQUE
);

CREATE TABLE TRABALHO
(
	IdTrabalho INT IDENTITY PRIMARY KEY NOT NULL,
	-- Nota DATETIME DEFAULT GETDATE(),
	Nota DECIMAL NOT NULL,
	Id_Materia INT FOREIGN KEY REFERENCES MATERIA(Id_Materia),
	IdAluno INT FOREIGN KEY REFERENCES ALUNO(IdAluno)
);


/* Incluir uma nova coluna */
ALTER TABLE MATERIA ADD Teste VARCHAR(2);

/* Excluir Coluna */
ALTER TABLE MATERIA DROP COLUMN Teste;

/* Alterar Coluna*/
ALTER TABLE MATERIA ALTER COLUMN Teste VARCHAR(10);
-- Altera Nome da Coluna
EXEC SP_RENAME 'MATERIA.[Teste]', 'TesteDois', 'COLUMN'


/* Inserir dados do aluno */
INSERT INTO ALUNO(Nome, Ra, Idade) VALUES('Alef', 'R123', 23);
INSERT INTO ALUNO(Nome, Ra, Idade) VALUES('Bruna', 'R124', 22);
INSERT INTO ALUNO(Nome, Ra, Idade) VALUES('Bruno', 'R321', 19);
INSERT INTO ALUNO(Nome, Ra, Idade) VALUES('Ana Banana', 'R451', 23 );
INSERT INTO ALUNO(Nome, Ra, Idade) VALUES('Maria Donardi Santos', 'R450', 18 );


/* Inserir dados na tabela materia */
INSERT INTO MATERIA(Materia) VALUES('Português'),('Matemática'); 

-- Inserindo dados na tabela trabalho
INSERT INTO TRABALHO(Nota, Id_Materia, IdAluno) VALUES(9.8, 1, 1);


/* Atualizando registro */
UPDATE ALUNO SET Nome = 'Bruna Silva' WHERE IdAluno = 4;

/* Excluir Dados */
DELETE FROM MATERIA WHERE Id_Materia = 2;

/* Mostrar dados */
SELECT * FROM MATERIA;

SELECT * FROM ALUNO WHERE IdAluno = 3;

SELECT * FROM ALUNO;

SELECT * FROM ALUNO ORDER BY Nome ASC; -- Ordenar por nome do aluno de forma ascendente 

SELECT * FROM ALUNO ORDER BY Nome DESC; -- Ordenar por nome do aluno de forma decrescente 

-- Buscar com Like
SELECT * FROM ALUNO WHERE Nome LIKE 'a%';


SELECT IdTrabalho, Nome, Ra, Materia, Nota FROM TRABALHO AS TR 
INNER JOIN ALUNO AS AL ON AL.IdAluno = TR.IdAluno 
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

