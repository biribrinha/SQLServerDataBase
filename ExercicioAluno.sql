CREATE DATABASE turma;

DROP DATABASE turma;

USE TURMA;

CREATE TABLE RESPONSAVEL
(
	IdResponsavel INT IDENTITY NOT NULL PRIMARY KEY,
	Nome VARCHAR(30) NOT NULL,
	Endereco VARCHAR(40) NOT NULL,
	Cpf CHAR(11) NOT NULL,
	CONSTRAINT ValidaCpf CHECK(LEN(Cpf) = 11 ),
);


CREATE TABLE TURMA
(
	IdTurma INT IDENTITY NOT NULL PRIMARY KEY,
	Classe CHAR(1) NOT NULL UNIQUE
);


CREATE TABLE CADASTRO
(
	IdCadastro INT IDENTITY NOT NULL PRIMARY KEY,
	DataCad DATETIME DEFAULT GETDATE(),
	IdAluno INT NOT NULL,
	IdResponsavel INT FOREIGN KEY REFERENCES RESPONSAVEL(IdResponsavel)
);

CREATE TABLE ALUNO
(
	IdAluno INT IDENTITY NOT NULL PRIMARY KEY,
	Nome VARCHAR(30),
	Data_Nasc VARCHAR(10) NOT NULL,
	IdResponsavel INT FOREIGN KEY REFERENCES RESPONSAVEL(IdResponsavel),
	Serie CHAR(1) NOT NULL,
	IdTurma INT FOREIGN KEY REFERENCES TURMA(IdTurma)
);


-- Inserindo dados na tabela turma
INSERT INTO TURMA(Classe) VALUES('A'),('B'),('C'),('D');

SELECT * FROM TURMA


-- Inserindo dados na tabela responsavel
INSERT INTO RESPONSAVEL(Nome, Endereco, Cpf) VALUES('Manuelle', 'Diadema', '33344499912');
INSERT INTO RESPONSAVEL(Nome, Endereco, Cpf) VALUES('Natalia', 'Tatuape', '33344488912');

SELECT * FROM RESPONSAVEL


-- Inserindo dados na tabela cadastro
INSERT INTO CADASTRO(IdAluno, IdResponsavel) VALUES(1, 1);
INSERT INTO CADASTRO(IdAluno, IdResponsavel) VALUES(2, 2);

SELECT * FROM CADASTRO

-- Inserindo dados na tabela Aluno
INSERT INTO ALUNO(Nome, Data_Nasc, IdResponsavel, Serie, IdTurma) VALUES('João', '22/01/1999', 1, '2', 2),('Fernando', '11/05/2001', 2, '1', 1);
INSERT INTO ALUNO(Nome, Data_Nasc, IdResponsavel, Serie, IdTurma) VALUES('Miguel', '10/01/1994', 2, '3', 1);

SELECT * FROM ALUNO


SELECT AL.Nome, AL.Data_Nasc, RE.Nome AS Nome_Responsavel, AL.Serie, TR.Classe, CA.DataCad AS 'Data do Cadastro' FROM ALUNO AS AL 
INNER JOIN RESPONSAVEL AS RE ON AL.IdResponsavel = RE.IdResponsavel
INNER JOIN CADASTRO AS CA ON CA.IdAluno = AL.IdAluno 
INNER JOIN TURMA AS TR ON AL.IdTurma = TR.IdTurma; 