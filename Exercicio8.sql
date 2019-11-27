CREATE DATABASE empresa;

USE empresa;


/* CRIAÇÃO DAS TABELAS */
CREATE TABLE departamento
(
	IdDepartamento INT IDENTITY NOT NULL PRIMARY KEY,
	Nome VARCHAR(40) NOT NULL
);

CREATE TABLE localizacao
(
	IdLocalizacao INT IDENTITY NOT NULL PRIMARY KEY,
	Estado CHAR(2) NOT NULL, CONSTRAINT Valida_Estado CHECK(LEN(Estado) = 2),
	Cidade VARCHAR(30) NOT NULL,
	Endereco VARCHAR(50) NOT NULL,
	IdDepartamento INT CONSTRAINT fk_depart_loca FOREIGN KEY REFERENCES departamento(IdDepartamento) NOT NULL
);

CREATE TABLE empregado
(
	IdEmpregado INT IDENTITY NOT NULL PRIMARY KEY,
	Nome VARCHAR(40) NOT NULL,
	Salario MONEY DEFAULT 1000.00,
	IdDepartamento INT CONSTRAINT fk_depart_empreg FOREIGN KEY REFERENCES departamento(IdDepartamento) NOT NULL
);

CREATE TABLE dependente
(
	IdDependente INT IDENTITY NOT NULL PRIMARY KEY,
	Nome VARCHAR(40) NOT NULL,
	Idade INT, 
	IdEmpregado INT CONSTRAINT fk_empreg_dep FOREIGN KEY REFERENCES empregado(IdEmpregado) NOT NULL
);


CREATE TABLE projeto
(
	IdProjeto INT IDENTITY NOT NULL PRIMARY KEY,
	Nome VARCHAR(40) NOT NULL,
	Descricao VARCHAR(40), 	
	Data_Inicio DATE DEFAULT GETDATE(),
	Data_Termino DATE DEFAULT GETDATE() + 30,
	IdDepartamento INT CONSTRAINT fk_depart_proj FOREIGN KEY REFERENCES departamento(IdDepartamento) 

);

CREATE TABLE execucao_projeto
(
	IdExec INT IDENTITY NOT NULL PRIMARY KEY,
	IdProjeto INT CONSTRAINT fk_proj_exec FOREIGN KEY REFERENCES projeto(IdProjeto) NOT NULL,
	IdEmpregado INT CONSTRAINT fk_empreg_exec FOREIGN KEY REFERENCES empregado(IdEmpregado) NOT NULL

);



/***** CRIAÇÃO DAS TABELAS */

/* INSERINDO DADOS NA TABELA DEPARTAMENTO */
	INSERT INTO departamento(Nome) VALUES('JURIDICO'),('T.I'),('RH'),('ADM');

	SELECT * FROM departamento
/***** DEPARTAMENTO */

/* INSERINDO DADOS NA TABELA DEPARTAMENTO */
	INSERT INTO localizacao(Estado, Cidade, Endereco, IdDepartamento) 
	VALUES('SP', 'São Paulo', 'Av Teste, 321', 2),('MG', 'Belo Horizonte', 'AV Teste, 555', 1),('BA', 'Salvador', 'Rua Teste, 888', 1);

	SELECT * FROM localizacao;
/***** DEPARTAMENTO */

/* INSERINDO DADOS NA TABELA EMPREGADO */
	INSERT INTO empregado(Nome, Salario, IdDepartamento) 
	VALUES('Alef Cauê White da Silva', 2500.50, 2),('Manuelle Santos Medeiros', 2000.00, 3),('Lucas Silva', 1500.00, 4);

	SELECT * FROM empregado;
/***** EMPREGADO */

/* INSERINDO DADOS NA TABELA DEPENDENTES */
	INSERT INTO dependente(Nome, Idade, IdEmpregado) 
	VALUES('Ana Clara Silva', 8, 1),('Luis Fernando Filho', 5, 2),('Higos Freitas Silva', 3, 1);

	SELECT * FROM dependente;
/***** DEPENDENTES */

/* INSERINDO DADOS NA TABELA PROJETOS */
	INSERT INTO projeto(Nome, Descricao, IdDepartamento) 
	VALUES('CodeExp', 'Projeto coorganicas', 2),('Erp Flex', 'Desenvolvimento de um Erp Completo', 2),('Green IT', 'Projeto Verde', 4);

	INSERT INTO projeto(Nome, Descricao) VALUES('Soft Blue', 'Projeto Blue'),('Kapuava Soft', 'Projeto de Integração');

	SELECT * FROM projeto;
/***** PROJETOS */

/* INSERINDO DADOS NA TABELA EXECUÇÃO PROJETOS */
	INSERT INTO execucao_projeto(IdProjeto, IdEmpregado) VALUES(4, 1),(5, 2),(4, 3);

	SELECT * FROM execucao_projeto;
/***** EXECUÇÃO */


SELECT * FROM projeto;


SELECT E.Nome, D.Nome AS 'Departamento', P.Nome AS 'Nome do Projeto', P.Descricao AS 'Descrição do Projeto', P.Data_Inicio, P.Data_Termino,
PJ.Nome AS 'Projeto Sem Controle de Departamento', PJ.Descricao AS 'Descrição do Projeto', PJ.Data_Inicio, PJ.Data_Termino
FROM empregado AS E 
INNER JOIN departamento AS D ON D.IdDepartamento = E.IdDepartamento 
INNER JOIN projeto as P  ON P.IdDepartamento = D.IdDepartamento 
INNER JOIN execucao_projeto AS EX ON EX.IdEmpregado = E.IdEmpregado
LEFT JOIN projeto AS PJ ON PJ.IdProjeto = EX.IdProjeto;

-- Projetos Não Controlados por Departamento
SELECT E.Nome, P.Nome, P.Descricao, P.IdProjeto FROM empregado AS E INNER JOIN execucao_projeto AS EX ON EX.IdEmpregado = E.IdEmpregado
INNER JOIN projeto AS P ON P.IdProjeto = EX.IdProjeto 

-- Projetos Controlados por Departamento
SELECT E.Nome, P.Nome, P.Descricao, P.IdProjeto
FROM empregado AS E 
INNER JOIN execucao_projeto AS EX ON EX.IdEmpregado = E.IdEmpregado
INNER JOIN projeto AS P ON P.IdDepartamento = E.IdDepartamento



/*
	Utilizamos a função nativa COUNT para teronar o numero de registros
	
	USAMOS O Alias "AS" para nomear a coluna

*/

SELECT COUNT(*) AS 'Quantidade de Projetos' FROM projeto;


/* Soma dos salarios */
SELECT SUM(Salario) AS 'Soma Total dos Salarios' FROM empregado;

/* Pegamos o salario maximo dos empregados */
SELECT MAX(Salario) AS 'Maior Salário' FROM empregado;


/* Pegamos o menor salario dos empregados */
SELECT MIN(Salario) AS 'Maior Salário' FROM empregado;


-- Pegamos a média dos salarios
SELECT AVG(Salario) AS 'Maior Salário' FROM empregado;


-- Juntamos todas as funções em uma unica consulta
SELECT
	COUNT(*) AS 'Total de Empregados',
	MAX(Salario) AS 'Maior Salario',
	MIN(Salario) AS 'Menor Salario',
	AVG(Salario) AS 'Média dos Salarios',
	SUM(Salario) AS 'Soma Total dos Salarios'
FROM empregado;



/*
	SUBSTRING
	Pegamos parte de uma string
*/

SELECT SUBSTRING(Nome, 1, 3) AS 'Parte Do Nome' FROM empregado;


/*
	UPPER
	Deixa tudo em maisculo
*/

SELECT UPPER(Nome) AS 'Nomes' FROM empregado;


/*
	LOWER
	Deixa tudo em minusculo
*/

SELECT LOWER(Nome) AS 'Nomes' FROM empregado;




