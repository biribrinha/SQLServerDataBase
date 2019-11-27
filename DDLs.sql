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
	Nota DECIMAL,
	Id_Materia INT FOREIGN KEY REFERENCES MATERIA(Id_Materia),
	IdAluno INT FOREIGN KEY REFERENCES ALUNO(IdAluno)
);

/* Incluir uma nova coluna */
ALTER TABLE MATERIA ADD Teste VARCHAR(2);

/* Excluir Coluna */
ALTER TABLE MATERIA DROP COLUMN Teste;




