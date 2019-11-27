CREATE DATABASE site;

USE site;

CREATE TABLE CURSO
(
	IdCurso INT IDENTITY NOT NULL PRIMARY KEY,
	Nome VARCHAR(30) NOT NULL UNIQUE,
	DataInicio DATETIME DEFAULT GETDATE(),
	DataTermino DATETIME DEFAULT GETDATE() + 30
);

INSERT INTO CURSO(Nome) VALUES('PHP');

UPDATE CURSO SET Nome = 'Javascript' WHERE IdCurso = 1;

SELECT * FROM CURSO;

CREATE TABLE CANDITADO
(
	IdCandidato INT IDENTITY NOT NULL,
	Nome VARCHAR(30) NOT NULL UNIQUE,
	Endereco VARCHAR(50) NOT NULL,
	Cpf CHAR(11) NOT NULL,
	CONSTRAINT Cpf_Digitos CHECK(LEN(Cpf) = 11 ),
	IdCurso INT FOREIGN KEY REFERENCES CURSO(IdCurso)

);

INSERT INTO CANDITADO(Nome, Endereco, Cpf, IdCurso) VALUES('Alef', 'Rua Augusta, 123', '45627489820', 1);

SELECT * FROM CANDITADO

SELECT CA.Nome, CA.Cpf, C.Nome, C.DataInicio, C.DataTermino FROM CURSO AS C INNER JOIN CANDITADO AS CA ON CA.IdCurso = C.IdCurso;
