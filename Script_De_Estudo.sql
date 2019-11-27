
-- AULA 3 CREATE DATABASE

CREATE DATABASE db_Biblioteca 
ON PRIMARY(
NAME = db_Biblioteca,-- Nome do Banco de Dados
FILENAME = 'C:\SQL\db_Biblioteca.MDF', -- Filename caminho de onde ficara salvo o banco
SIZE=6MB, -- Tamanho do banco de dados inicial
MAXSIZE=15MB, -- Tamanho maximo do banco de dados
FILEGROWTH=10% -- Quando acabar o espaço do banco ele cresce de 10 em 10 %

)

USE db_Biblioteca 

sp_helpdb db_Biblioteca -- Informações sobre o banco de dados Criado


--Aula 4 Constraints(Restrições), Primary Key, Not Null
/*
	Principais SQL CONSTRAINTS(Restrições)
			Principais:
	. Not Null -- Não poderar recebar valores nulos, o campo sempre terá que ter um valor
	. Unique -- Unico o campo não pode repetir os dados
	. Primary Key -- Chave primaria deve se sempre ter um valor unico que não se repita
	. Foreign Key -- É um campo que aponta para chave primária em outra tabela
	. Check -- É usada para limitar uma faixa de valores que podem ser colocados em uma coluna. Exemplo - CHECK (ColumnD > 10 AND ColumnD < 50); 
 	. Default -- É usada para inserir um valor padrão em uma coluna

*/



-- Aula 5 - Create Table - Criação de Tabelas

CREATE TABLE tbl_livro 
(
	Id_livro SMALLINT PRIMARY KEY IDENTITY(1000,1), -- o Auto Incremento IDENTITY começa em 100 e vai de 1 em 1
	Nome_livro VARCHAR(50) NOT NULL,
	Isbn VARCHAR(30) NOT NULL UNIQUE,
	Id_autor SMALLINT NOT NULL,
	Data_pub DATETIME NOT NULL,
	Preco_livro MONEY NOT NULL
	
)

CREATE TABLE tbl_Autores
(
	Id_autor SMALLINT PRIMARY KEY,
	Nome_autor VARCHAR(50),
	SobreNome_autor VARCHAR(60)
)


CREATE TABLE tbl_Editoras
(
	Id_editora SMALLINT PRIMARY KEY IDENTITY,
	Nome_editora VARCHAR(50) NOT NULL
)


sp_help tbl_Editoras
sp_help tbl_Autores
sp_help tbl_livros



-- Aula 6 IDENTITY - auto-incremento de valores em colunas

CREATE TABLE tbl_teste_identidade
(
	ID_teste SMALLINT PRIMARY KEY IDENTITY,
	valor SMALLINT NOT NULL
)


INSERT INTO tbl_teste_identidade (valor) VALUES (10),(15)
INSERT INTO tbl_teste_identidade (valor) VALUES (20)
INSERT INTO tbl_teste_identidade (valor) VALUES (30)
INSERT INTO tbl_teste_identidade (valor) VALUES (40)


SELECT * FROM tbl_teste_identidade


-- Aula 7 Alter e Drop Table - altera e exluir tabelas e colunas

--Excluindo uma coluna da tabela
ALTER TABLE tbl_livro DROP COLUMN Id_autor
SELECT * FROM tbl_livro

-- Pode-se Excluir uma constraint tambem
-- ALTER TABLE tabela DROP CONSTRAINT nome_constraint

-- Alter Table - ADD

ALTER TABLE tbl_livro ADD Id_autor SMALLINT NOT NULL CONSTRAINT fk_Id_autor FOREIGN KEY(Id_autor) REFERENCES tbl_Autores

ALTER TABLE tbl_livro ADD Id_editora SMALLINT NOT NULL CONSTRAINT fk_id_editora FOREIGN KEY (Id_editora) REFERENCES tbl_Editoras

-- ALTER TABLE tbl_teste_identidade ADD CONSTRAINT fk_teste FOREIGN KEY (valor) REFERENCES tbl_livro (Id_autor)

ALTER TABLE tbl_livro ALTER COLUMN Id_autor SMALLINT
EXEC SP_RENAME 'tbl_livro.[teste]', 'Id_autor', 'COLUMN'
SELECT * FROM tbl_livro


-- ALTER TABLE CLIENTES ADD PRIMARY KEY (Id_cliente)

-- Exlcuir uma table
-- DROP TABLE nome_tabela
-- DROP TABLE Clientes



--  Aula 8 INSERT INTO - INSERIR DADOS

--INSERT INTO tabela(Coluna1,Coluna2,...) VALUES (Valor1,Valor2...)


INSERT INTO tbl_Autores(ID_Autor, Nome_Autor, SobreNome_Autor) VALUES (1,'Daniel','Barret')
INSERT INTO tbl_Autores(ID_Autor, Nome_Autor, SobreNome_Autor) VALUES (2,'Gerald','Carter')
INSERT INTO tbl_Autores(ID_Autor, Nome_Autor, SobreNome_Autor) VALUES (3,'Mark','Sobell')
INSERT INTO tbl_Autores(ID_Autor, Nome_Autor, SobreNome_Autor) VALUES (4,'William','Stanek')
INSERT INTO tbl_Autores(ID_Autor, Nome_Autor, SobreNome_Autor) VALUES (5,'Richard','Blum')

INSERT INTO tbl_Editoras(Nome_Editora) VALUES ('Prentice Hall')
INSERT INTO tbl_Editoras(Nome_Editora) VALUES ('O´ Reily')
INSERT INTO tbl_Editoras(Nome_Editora) VALUES ('Microsoft Press')
INSERT INTO tbl_Editoras(Nome_Editora) VALUES ('Wiley')


INSERT INTO tbl_livro(Nome_livro, ISBN, Data_Pub, Preco_livro, ID_Autor, ID_Editora) 
VALUES ('Linux Command Line and Shell Scripting', 143856969, '20091221', 68.35, 5, 4)

INSERT INTO tbl_livro(Nome_livro, ISBN, Data_Pub, Preco_livro, ID_Autor, ID_Editora) 
VALUES ('SSH', 12778273, '20091221', 58.30, 1, 2)


INSERT INTO tbl_livro(Nome_livro, ISBN, Data_Pub, Preco_livro, ID_Autor, ID_Editora) 
VALUES ('Using Samba', 12144269, '20001221', 61.45, 2, 2)


SELECT * FROM tbl_Editoras
SELECT * FROM tbl_livro
SELECT * FROM tbl_Autores



-- Aula 9 Truncate Table
-- Truncate remove todas as linhas de uma tabela sem respeitar a integridade dos dados

SELECT COUNT(*) AS TabelaAntes FROM Clientes
-- TRUNCATE TABLE clientes
SELECT COUNT(*) AS TabelaDepois FROM Clientes





-- Aula 10 Select From - Consulta Simples

USE db_Biblioteca

SELECT Nome_Autor FROM tbl_Autores

SELECT * FROM tbl_livro

SELECT Nome_livro FROM tbl_livro

SELECT Nome_livro, ID_Autor FROM tbl_livro

SELECT Nome_Autor,SobreNome_Autor FROM tbl_Autores



-- Aula 11 - Order By - Consulta com Ordenação

/* 
		ASC - ORDEM CRESCENTE
		DESC - ORDEM DECRECENTE
*/


SELECT * FROM tbl_livro 

SELECT * FROM tbl_livro ORDER BY Preco_livro

SELECT * FROM tbl_livro ORDER BY Nome_livro DESC

SELECT Nome_autor FROM tbl_Autores ORDER BY Nome_autor DESC






-- 12 Distinct - Consulta com valores distintos, sem repetição
SELECT Id_autor FROM tbl_livro

SELECT DISTINCT ID_Autor FROM tbl_livro



-- 13 WHERE - Filtrando registros em uma consulta

SELECT * FROM tbl_livro WHERE Id_autor = '1'

SELECT Id_autor FROM tbl_Autores WHERE SobreNome_autor = 'Stanek'




-- 14 AND e OR - Operadores Lógicos


SELECT * FROM tbl_livro WHERE ID_Autor > 2 AND ID_Autor < 3

SELECT * FROM tbl_livro WHERE ID_Autor > 1001 OR ID_Autor < 1003



-- 15 UPDATE - Atualiando Registro

-- UPDATE tabela SET coluna = valor WHERE 'filtro'

-- Ex 01
SELECT * FROM tbl_livro
-- UPDATE tbl_livro SET Preco_livro = 70.00 
WHERE Id_livro = 1002

SELECT * FROM tbl_livro WHERE Id_livro = 1002

SELECT * FROM tbl_Autores
-- UPDATE tbl_Autores SET SobreNome_autor = 'Cartman' 
WHERE Id_autor = 2


SELECT * FROM tbl_livro
-- UPDATE tbl_livro SET Preco_livro = 80.00, Isbn = '02020202' 
WHERE Id_livro = 1001


-- 15.2 TOP - Especificar numero de registros a Retornar

-- SELECT TOP numero/percentual colunas FROM tabela

-- SELECT TOP 20 PERCENT Nome_livro FROM tbl_livro

-- SELECT TOP 3 Nome_livro FROM tbl_livro


-- 16 ALIAS comm AS - Nomes alternativos oara colunas

-- SELECT colunas AS nome_alias FROM tabela

SELECT Nome_livro AS Livro FROM tbl_livro

SELECT Nome_livro AS Livro, Id_autor AS Autor FROM tbl_livro



-- 17 UNION - Unir Resultados de declaraçoes Select

/*
	SELECT colunas FROM tabela 1 UNION SELECT colunas FROM tabela 2

*/


SELECT Id_autor FROM tbl_Autores 
UNION -- ALL 
SELECT Id_autor FROM tbl_livro




-- 18 SELECT INTO - criar nova table a partir de uma tabela existente

-- SELECT * INTO nova_tabela FROM tabela_atual

SELECT Nome_livro, Id_autor, Id_livro INTO Livro FROM tbl_livro WHERE Id_livro > 100
SELECT * FROM Livro

SELECT * INTO tbl_livro_backup FROM tbl_livro
SELECT * FROM tbl_livro_backup



-- 19 Funções Agregadas - SUM, COUNT, MAX, MIN, AVG

/*
	MIN = VALOR MINIMO
	MAX = VALOR MAXIMO
	AVG = MEDIA ARITMETICA
	SUM = TOAL(SOMA)
	COUNT = CONTAR QUANTIDADE DE ITENS
*/


SELECT COUNT(Nome_autor) FROM tbl_Autores

SELECT MAX(Preco_livro) AS PreçoMaximo FROM tbl_livro

SELECT MIN(Preco_livro) AS PreloMinimo FROM tbl_livro

SELECT AVG(Preco_livro) AS MEDIA FROM tbl_livro

SELECT SUM(Preco_livro) AS PreçoTotal FROM tbl_livro





-- 20 Between(Entre) - SELEÇÃO DE INTERVALOS EM REGISTROS


-- SELECT colunas FROM tabela WHERE coluna BETWEEN valor 1 AND valor2

SELECT * FROM tbl_livro WHERE Data_pub BETWEEN '20040517' AND '20100517'


SELECT Nome_livro AS Livros, Preco_livro AS Preço 
FROM tbl_livro 
WHERE Preco_livro BETWEEN 60.00 AND 70.00



-- 21 Like e Not Like - Filtrar por padroes Especificos

/* 
	'%' - Qualquer cadeia 0 ou mais caracteres
	
	'_' - Sublinhado: qualquer caracter unico
	
	'[]' - Qualquer caracter unicos no intervalo ou conjunto especificado ([a-h]; [aeiou] )
	
	'[^]' - Qualquer caracter unico que nao estjea no intervalo ou conjunto especificado ([a-h]; [aeiou])
*/


SELECT Nome_livro FROM tbl_livro  WHERE Nome_livro LIKE 'S%'-- Começa com a letra S

SELECT Nome_livro FROM tbl_livro  WHERE Nome_livro LIKE '%G' -- Termina com a letra G

SELECT Nome_livro FROM tbl_livro  WHERE Nome_livro LIKE '_i%' -- So importa a segunda letra ex linux, microsoft

SELECT Nome_livro FROM tbl_livro  WHERE Nome_livro LIKE '[SL]%' -- Ira pesquisar o que vem depois de S e L E Nao importa o que vem depois de S e L

SELECT Nome_livro FROM tbl_livro  WHERE Nome_livro LIKE '%[GL]' -- Ira pesquisar os livros que terminem com G e L  e não importa o que vem antes o que importa e que termine com g e l

SELECT Nome_livro FROM tbl_livro  WHERE Nome_livro LIKE '_[iS]%'-- Ira pular a primeira letra e trazer o nome de livros que tenha o segundo caracter com I ou S e com o % nao importa as letras que ira vim depois

SELECT Nome_livro FROM tbl_livro  WHERE Nome_livro LIKE '_i__o%'

SELECT Nome_livro FROM tbl_livro  WHERE Nome_livro NOT LIKE 'M%' -- Ira pesquisar livros que não comecem com a letra M





-- 22 Joins e INNER JOIN - SELECIONAR DADOS DE DUAS OS MAIS TABELAS
/*

		INNER JOIN - Retorna linhas quando houver pelo menos uma correspondencia em ambas as tabelas
		OUTER JOIN - Retorna linhas mesmo quando nao houver pelo menos uma corresnpodencia em uma das tabelas
		(ou ambas). O outer join divide-se em LEFT JOIN, RIGHT JOIN E FULL JOIN.
		
*/



-- SELECT colunas FROM tabela1 INNER JOIN tabela2 ON tabela1.coluna = tabela2.coluna



SELECT * FROM tbl_livro INNER JOIN tbl_Autores ON tbl_livro.Id_autor = tbl_Autores.Id_autor


SELECT tbl_livro.Nome_livro, tbl_livro.ISBN, tbl_Autores.Nome_Autor 
FROM tbl_livro 
INNER JOIN tbl_Autores ON tbl_livro.ID_Autor = tbl_Autores.ID_Autor

-- Usando Alias - AS


SELECT L.Nome_livro, E.Nome_Editora FROM tbl_livro AS L INNER JOIN tbl_Editoras AS E ON L.ID_Editora = E.ID_Editora




-- 23 OUTER JOINS

-- LEFT JOIN RETORNA TODAS AS LINHAS DA TABELA A ESQUERDA MESMO SE NAO HOUVER NENHUMA CORRESPONDENCIA NA TABELA A DIREITA

-- RIGHT JOIN RETORNA TODAS AS LINHAS DA TABELA A DIREITA MESMO SE NAO HOUVER NENHUMA CORRESPONDENCIA NA TABELA A ESQUERDA

-- FULL JOIN RETORNA LINHAS QUANDO HOUVER UMA CORRESPONDENCIA EM QUALQUER UMA DAS TABELAS É UMA COMBINAÇÃO DE LEFT E RIGHT JOIN

INSERT INTO tbl_livro(Nome_livro, ISBN, Data_Pub, Preco_livro, ID_Editora) 
VALUES ('teste123', 456856969, '20021221', 98.35, 2)


SELECT * FROM tbl_livro INNER JOIN tbl_Autores ON tbl_livro.ID_Autor = tbl_Autores.ID_Autor

SELECT * FROM tbl_livro LEFT JOIN tbl_Autores ON tbl_livro.ID_Autor = tbl_Autores.ID_Autor

-- Obtendo Apenas os Livros que não tem autor eliminando correspondencia
SELECT * FROM tbl_livro LEFT JOIN tbl_Autores ON tbl_livro.ID_Autor = tbl_Autores.ID_Autor WHERE tbl_Autores.ID_Autor IS NULL




-- Right Join

SELECT * FROM tbl_Autores RIGHT JOIN tbl_livro ON tbl_livro.ID_Autor = tbl_Autores.ID_Autor

SELECT * FROM tbl_Autores RIGHT JOIN tbl_livro ON tbl_livro.ID_Autor = tbl_Autores.ID_Autor WHERE tbl_Autores.ID_Autor IS NULL




-- 24 Full Join - Selecionar dados de varias tabelas

SELECT B.Nome_livro, A.ID_Autor, A.Nome_Autor FROM tbl_Autores AS A FULL JOIN tbl_livro AS B ON A.ID_Autor = B.ID_Autor

SELECT B.Nome_livro, A.ID_Autor, A.Nome_Autor FROM tbl_Autores AS A FULL JOIN tbl_livro AS B ON A.ID_Autor = B.ID_Autor
WHERE B.ID_Autor IS NULL OR A.ID_Autor IS NULL






--25 Operadores IN e NOT IN - Filtros de Multiplas Condiçoes

SELECT * FROM tbl_Autores WHERE ID_Autor IN (1,2)

SELECT * FROM tbl_Autores WHERE ID_Autor NOT IN (1,2)

SELECT * FROM tbl_Autores




-- 26 Campos Calculados - Calculos


USE db_Biblioteca

CREATE TABLE Produtos 
(
	CodProduto SMALLINT,
	NomeProduto VARCHAR(20),
	Preco Money,
	Quant SMALLINT,
	Total AS (Preco * Quant),
	CONSTRAINT validaPreco CHECK (Preco >= 100.00), 
	CONSTRAINT validaQuantidade CHECK (Quant > 0)

)


-- Bloco Try Catch para pegar um possivel erro
BEGIN TRY  
    -- Inserindo um valor para quantidade menor que 0 e preco menor que 100 para forçar o erro
    INSERT INTO Produtos(CodProduto, NomeProduto, Preco, Quant) VALUES(10001, 'Tv_SempToshiba', 99.00, 0)
END TRY  
BEGIN CATCH  
    -- Mesangem de Erro
    SELECT 'Quantidade tem que ser maior que zero e Preço deve ser maior ou igual a 100' AS Erro
	SELECT ERROR_MESSAGE() AS ErrorMessage;
	SELECT ERROR_MESSAGE() AS 'Deu Ruim';
	  
END CATCH;  


BEGIN TRY  
    -- Inserindo um Registro
    INSERT INTO Produtos(CodProduto, NomeProduto, Preco, Quant) VALUES(10004, 'Tv_SmartPhilco', 250.00, 0)
	EXEC MensagemSucesso
END TRY  
BEGIN CATCH  
    -- Mesangem de Erro
    SELECT 'Quantidade tem que ser maior que zero e Precço deve ser maior ou igual a 100' AS Erro
	SELECT ERROR_MESSAGE() AS ErrorMessage;
	SELECT ERROR_MESSAGE() AS 'Deu Ruim';
	PRINT 'DEU RUIM DE VERDADE'
	  
END CATCH;  

--  Criando Trigger de Teste
CREATE TRIGGER MensagemSuccess
ON Produtos
AFTER INSERT
AS
BEGIN 
	SELECT 'Registro Inserido Com Sucesso' AS MsgTriggerAutomatica
END
GO


-- Criando Proc de Teste
CREATE PROCEDURE MensagemSucesso
AS
SELECT 'Registro Inserido Com Sucesso' AS MsgProc


CREATE PROCEDURE ProcuraProduto(@Id_produto int) 
AS
BEGIN
	SELECT TOP 1 * FROM Produtos WHERE CodProduto = @Id_produto 
END

drop procedure ProcuraProduto


EXEc ProcuraProduto 10002


/*

BEGIN TRY  
    -- Generate a divide-by-zero error.  
    SELECT 1/0;  
END TRY  
BEGIN CATCH  
    SELECT  
        ERROR_NUMBER() AS ErrorNumber  
        ,ERROR_SEVERITY() AS ErrorSeverity  
        ,ERROR_STATE() AS ErrorState  
        ,ERROR_PROCEDURE() AS ErrorProcedure  
        ,ERROR_LINE() AS ErrorLine  
        ,ERROR_MESSAGE() AS ErrorMessage;  
END CATCH;  
GO  

*/


INSERT INTO Produtos(CodProduto, NomeProduto, Preco, Quant) VALUES(101, 'Tv_SempToshiba', 99.00, 0)
INSERT INTO Produtos(CodProduto, NomeProduto, Preco, Quant) VALUES(102, 'Tv_SempToshibaSmartTv', 99.00, 0)

SELECT * FROM Produtos


-- CHECK [ NOT FOR REPLICATION ] (column_name condition)
-- CONSTRAINT check_employee_id CHECK (employee_id BETWEEN 1 and 10000)


INSERT INTO Produtos VALUES (1, 'Mouse', 15.00, 2)
INSERT INTO Produtos VALUES (2, 'Teclado', 18.00, 1)
INSERT INTO Produtos VALUES (3, 'Fones', 25.00, 1)
INSERT INTO Produtos VALUES (4, 'PenDrive', 25.00, 3)
INSERT INTO Produtos VALUES (5, 'SD Card', 29.00, 2)
INSERT INTO Produtos VALUES (6, 'DVR-R', 1.30, 12)
INSERT INTO Produtos VALUES (7, 'Notebook', 2000.00, 2)

SELECT * FROM Produtos

SELECT SUM(Total) FROM Produtos




-- 27 Indices - CREATE INDEX

-- Permitem que as aplicações de Banco de Dados encontrem os dados mais rapidamente, sem ter que ler a tabela toda
-- Obs: Apenas crie indices em tabelas que recebam muitas consultas

-- CREATE INDEX NOME_INDICE ON NOME_TABELA (NOME_COLUNA)

USE db_Biblioteca


CREATE INDEX incice_nome_livro on tbl_livro (Nome_livro)

DROP TABLE Livro

SELECT * FROM 




-- 28 Regras - CREATE RULE 

/* As regras são configurações que permitem especificar como determinados parâmetros do banco de dados devem se comportar
	como exemplo, limitar faixas de valores em colunas, ou especificar valores invalidos para registros. 
*/

-- CREATE RULE NOME_REGRA AS PARAMETROS


CREATE RULE regra_preco AS @VALOR > 10.00

				--Nome da regra   tabela.coluna
EXECUTE SP_BINDRULE regra_preco, 'tbl_livro.Preco_livro' 

SELECT * FROM tbl_livro

UPDATE tbl_livro SET Preco_livro = 50.00 WHERE ID_livro = 105

UPDATE tbl_livro SET Preco_livro = 9.90 WHERE ID_livro = 101





-- 29 Backup de Banco de Dados e Restauração


USE teste
GO

-- Backup do Banco de Dados

BACKUP DATABASE teste TO DISK = 'C:\arquivos\teste.bak';
GO

/*  Apos efeturar o backup exluir o banco de dados teste, depois ir no icone Banco de Dados clicar com o botão direito
	Entrar em restaurar banco de dados, escolher a opçao dispositivo depois selecionar o arquivo de backup .bak
*/

USE db_Biblioteca -- Usando o banco db_biblioteca para poder excluir o teste

USE teste






-- 30 Concatenação de Strings 
-- E possivel concatenar strings usando-se o operador de concatenação +
-- Sintaxe:
-- String1 |coluna + String2 | coluna


Use db_Biblioteca

SELECT * FROM tbl_livro

--Exemplos:

-- Concatenando String com String
SELECT 'Fábio ' + 'da Bóson Treinamentos ' AS Boson 

-- Concatenando Coluna com coluna
SELECT Nome_autor + ' ' + Sobrenome_autor AS 'Nome Completo' FROM tbl_Autores 

-- Concatenando Strig Com coluna
SELECT 'Eu gosto do livro ' + Nome_Livro AS 'Meu Livro' FROM tbl_livro WHERE ID_Autor = 2




-- 31 Collation - Agrupamento de Caracteres ou Colação
-- Collation ('colação / agrupamento')

-- Trata-se da condificação dos caracteres em uma ordem padrão. Muitos sistemas de colaçao sao baseados em ordem numero ou alfabetica
-- A colocao e usada pelos banco de dados e configurada durante a instalaçao do sistema

--Para ver as Opçoes de agrupamento disponiveis
SELECT * FROM fn_helpcollations()

-- Para ver o esquema de colaçao usado atualmente pelo servidor
SELECT SERVERPROPERTY('Collation') AS Colacao_Usado


-- Alterar o esquema de colocao de um banco de dados, 
ALTER DATABASE Biblioteca2 COLLATE Greek_CI_AI



-- Verificar o esquema de agrupamento de banco de dados
SELECT DATABASEPROPERTYEX('Biblioteca2','Collation') AS Colação

-- Outra forma de alterar ir ate o banco de dados desejado clicar com o botão direito escolher propriedades clicar em opções

-- Esquema de colocao por coluna
-- SELECT * FROM tbl_livro ORDER BY Nome_Livro COLLATE Icelandic_CI_AI






-- 32  Clausula WITH TIES 
CREATE DATABASE CampeonatoItaliano
USE CampeonatoItaliano

CREATE TABLE Class (
	
	Nome_Time varchar(40),
	Pontos SmallINT,
	PRIMARY KEY (Nome_Time)

)
ALTER TABLE Class ADD ID_Time SMALLINT IDENTITY
SELECT * FROM Class

INSERT INTO Class VALUES ('Juventus', 82)
INSERT INTO Class VALUES ('Milan', 80)
INSERT INTO Class VALUES ('Udinese', 62)
INSERT INTO Class VALUES ('Lazio', 62)
INSERT INTO Class VALUES ('Napoli', 61)
INSERT INTO Class VALUES ('Internazionale', 61)
INSERT INTO Class VALUES ('Roma', 60)
INSERT INTO Class VALUES ('Parma', 60)
INSERT INTO Class VALUES ('Bologna',60 )
INSERT INTO Class VALUES ('Chievo',59 )
INSERT INTO Class VALUES ('Catania', 55)


SELECT * FROM Class ORDER BY Pontos Desc

SELECT TOP(3) Nome_Time, Pontos FROM Class ORDER BY Pontos DESC

-- A clausula WITH TIES verifica se o ultimo item tem algum item abaixo dele com o mesmo valor se tiver ele retorna junto
-- Ja o top apenas o numero que eu passar por parametro, Sempre Utilizar COM WITH TIES COM Order by e colocar ele apos o TOP() 
SELECT TOP(8) WITH TIES Nome_Time, Pontos FROM Class ORDER BY Pontos DESC







-- 33 VIEWS(Exibiçoes | Visoes) - Criar , Alterar e Excluir
/* 
	Uma exibiçao(Visao) é uma tabela virtual baseada no conjunto de resultados de uma consulta sql.
	Contem linhas e colunas como uma tabela real, e pode receber comandos como declarações JOIN, WHERE e Funcoes como
	tabela normal. 
	Mostra que resultados de dados atualizados, pois o motor do banco de dados recria os dados toda vez que um usuario
	consulta a visao.

*/

-- CREATE VIEW [NOME DA VIEW] AS SELECT colunas FROM tabela WHERE condicao

USE db_Biblioteca

CREATE VIEW vw_LivroAutores AS
SELECT L.Nome_livro AS Livro, A.Nome_autor AS Autor
FROM tbl_livro AS L INNER JOIN tbl_Autores AS A ON L.Id_autor = A.Id_autor

SELECT * FROM vw_LivroAutores
SELECT Livro,Autor FROM vw_LivroAutores
SELECT Livro,Autor FROM vw_LivroAutores WHERE Livro LIKE 'S%'


-- Alterando a View para mostras os preços dos livros tambem
ALTER VIEW vw_LivroAutores AS 
SELECT L.Nome_livro AS Livro, A.Nome_autor AS Autor, L.Preco_livro AS Valor
FROM tbl_livro AS L INNER JOIN tbl_Autores AS A ON L.Id_autor = A.Id_autor


SELECT * FROM vw_LivroAutores

-- Excluindo Uma Exibiçao
-- DROP VIEW vw_LivroAutores



-- 34 SubConsultas(SubQuery) - Com tabelas Derivadas
/*
	Uma subconsulta e uma declaracao sql embutida em uma consulta externa.
	A subconsulta fornece uma resposta a consulta externa na forma de um valor escalar, lista de valores, ou conjutos de
	dados, equivalente a uma expressão, lista ou tabela para consulta externa.
	Exemplo simples: SELECT (SELECT 'ALEF') AS SUBCONSULTA

*/
/* 
	SELECT Resultado.Cliente, SUM(Resultado.Total) AS TOTAL FROM
	(SELECT CL.NOME_Cliente AS Cliente, PR.Preco_Produto * CO.Quantidade AS TOTAL
	FROM Clientes AS CL
	INNER JOIN Compras AS CO
	ON CL.ID_Cliente =  CO.ID_Cliente
	INNER JOIN Produtos. AS PR
	ON CO.ID_Produto = PR.ID_Produto) AS Resultado 
	GROUP BY Resultado.Cliente
	ORDER BY TOTAL


*/









-- 35 CTE - COMMON TABLE EXPRESSION (Subconsulta) 

-- Variaçao sintatica de uma subconsulta, similiar a uma exibiçao (view)
--Pode ser acessada multiplas vezes dentro  da consulta principal, como se fosse uma exibiçao ou tela



/* 
		WITH ConsultarCTE (Cliente, Total)
		AS (SELECT CL.Nome_Cliente AS Cliente,
		PR.Preco_Produto * CO.Quantidade AS Total
		FROM Clientes AS CL
		INNER JOIN Compras AS CO
		ON CL.ID_Cliente = CO.ID_Cliente
		INNER JOIN Produtos AS PR 
		ON CO.ID_PRODUTO = PR.ID_Produto

*/

					-- REFAZER AS AULAS 34 E 35 PARA MELHOR ENTENDIMENTO
		








-- 36 VARIAVEIS - DECLARAÇÃO E ATRIBUIÇÃO
-- AS VARIAVEIS PODEM SER DECLARADAS NO CORPO DE UM BATCH OU PROCEDIMENTO, PODE SE ATRIBUIR VALORES USANDO SE
-- DECLARACAO SET OU SELECT, AS VARIAS SAO INICIALIZADAS POR PADRAO COM NULL

-- Exemplo: @nome_var tipo
/* 
Declare
		@valor INT,
		@texto VARCHAR(40),
		@data_nasc DATE,
		@nada Money

*/
-- USA SE A PALAVRA DECLARE APENAS UMA VEZ PARA TODAS AS VARIAVEIS.


-- ATRIBUIR VALORES COM SET 
-- EX. SET nome_da_variavel = Valor
          
		  --EX
/* 
	SET @valor = 50
	SET @texto = 'Alef'
	SET @data_nasc = GETDATE()
*/



USE db_Biblioteca
	
	
DECLARE @valor INT,
		@texto VARCHAR(40),
		@data_nasc DATE,
		@nada Money,
		

	
SET @data_nasc = 'TESTE'
SET @valor = 50		
SET @texto = 'TESTE'
SET @data_nasc = GETDATE()

SELECT @valor AS VALOR, @texto AS TEXTO, @data_nasc AS 'Data de Nascimento', @nada AS SALARIO


-----------------------------------------------------------------------------------------------------------------------------

DECLARE @livro VARCHAR(30)
SELECT @livro = nome_livro FROM tbl_livro WHERE ID_livro = 101


SELECT @livro AS 'NOME DO LIVRO'

----------------------------------------------------------------------------------------------------------------------------

DECLARE @preco Money, @quantidade INT, @nome VARCHAR(30)

SET @quantidade = 5


SELECT @preco = Preco_livro, @nome = Nome_livro FROM tbl_livro WHERE ID_livro = 101

SELECT @nome AS 'NOME DO LIVRO',@preco * @quantidade AS 'PREÇOS DO LIVRO'

------------------------------------------------------------------------------------------------------------------------------


-- 37 Conversão de tipos de Dados no SQL COM CAS E CONVERT

-- CAST(expressão AS novo_tipo_dados)


SELECT 'O preço do livro ' + Nome_livro + ' é de R$' + CAST(Preco_livro AS VARCHAR(6) ) AS ITEM FROM tbl_livro
WHERE ID_Autor = 2



-- Convert(novo_tipo_dados, expressão, estilo)
-- Estilo é uso normalmente para converter datas ou trabalhar com float/real

-- Ex

SELECT 'O preço do livro ' + Nome_livro + ' é de R$' + CONVERT(VARCHAR(6),Preco_livro) FROM tbl_livro

--Sem alterar o Estilo
SELECT 'A data de publicação ' + CONVERT(VARCHAR(15), Data_Pub ) FROM tbl_livro WHERE ID_livro = 102


--Com o estilo BRITANICO/FRANCES(103) DA TABELA DE ESTILOS
SELECT 'A data de publicação ' + CONVERT(VARCHAR(15), Data_Pub,103 ) FROM tbl_livro WHERE ID_livro = 102






-- 38 Condicional IF/ELSE no SQL SERVER
-- Sintaxe
/* 
	Usa-se o BEGIN E END se for executar mais do que uma linha de codigo
	
	IF condição
	
		IF condição
		BEGIN	
			bloco de codigo
		END	
		
		ELSE
		BEGIN
			bloco de codigo
		END	

*/


DECLARE @numero INT,
		@texto2 VARCHAR(20)


SET @numero = 20
SET @texto2 = 'ALEF'

	IF @numero = 20
		SELECT 'Numero Correto'


IF @texto2 = 'ALEF'
BEGIN
	
	SET @numero = 30
	SELECT @numero

END;


	ELSE
	BEGIN
		SET @numero = 40
		SELECT 'Numero Incorreto'

	END;	







DECLARE @NOME2 VARCHAR (30),
		@MEDIA REAL,
		@RESULTADO VARCHAR(10)

SELECT
		@NOME2 = nome_aluno
		@MEDIA = (tbl_aluno.nota1 + tbl_aluno.nota2 + tbl_aluno.nota3 + tbl_aluno.nota4)/4

FROM tbl_alunos

WHERE nome_aluno = 'ALEF'

		IF @MEDIA > 7
		BEGIN
			SELECT @RESULTADO = 'Aprovado'
		END
		
		ELSE
		BEGIN
			SELECT @RESULTADO = 'Reprovado'
		END

SELECT 'O aluno ' + @NOME2 + ' Está ' + @RESULTADO + ' com média ' + CAST(@MEDIA AS VARCHAR);






-- 39 Loop While - Estrutura de Repetição

-- Sintaxe
/* 
	WHILE condição
	BEGIN
		bloco de Codigos
	END
*/

DECLARE @VALOR2 INT

SET @VALOR2 = 0


			WHILE @VALOR2 < 10
			BEGIN
				-- SELECT OU PRINT
				PRINT 'Numero: ' + CAST(@VALOR2 AS VARCHAR(2))
	
				SET @VALOR2 = @VALOR2 + 1
			END;

USE db_Biblioteca

	DECLARE @codigo INT

	SET @codigo = 100

	
WHILE @codigo < 104
BEGIN
SELECT ID_livro AS ID, Nome_livro AS Livro, Preco_livro AS Preço FROM tbl_livro WHERE ID_livro = @codigo 

SET @codigo = @codigo + 1
END;








-- 40	STORED PROCEDURES - CRIAÇÃO E EXECUÇÃO NO SQL SERVER PARTE 1
/* 
	São lotes (batches) de declarações sql que podem ser executadas como uma subrotina

	permitem centralizar a logica de acesso aos em um unico local, facilitando a manutenção e otimização do codigo.
*/


/* SINTAXE
	CREATE PROCEDURE nome_procedimento
		(@Parametro Tipo_dados)
		AS
	Bloco de códigos		
=========================================================================================================	
	Exemplo 1

	CREATE PROCEDURE teste
	AS
	SELECT 'ALEF' AS NOME

	PARA EXECUTAR
	EXEC(CUTE) teste

	
		
*/


USE db_Biblioteca

CREATE PROCEDURE teste
AS
SELECT 'ALEF' AS NOME

EXEC teste


CREATE PROCEDURE LivroValor
AS
SELECT Nome_livro, Preco_livro FROM tbl_livro

EXEC LivroValor

EXEC sp_helptext LivroValor


-- Criando o Stored Procedure Criptografado

CREATE PROCEDURE Livroisbn WITH ENCRYPTION
 AS 
 SELECT Nome_livro, ISBN FROM tbl_livro

EXEC sp_helptext Livroisbn



-- 41 Alteração e Parâmetros de entrada no sql server PART 2

/* 
	Modificar Stored Procedure
	
	ALTER PROCEDURE


	ALTER PROCEDURE nome_procedimento
	bloco de codigo da sp



	PARAMETROS DE ENTRADA
	CREATE PROCEDURE teste(@parl AS INT)
	AS
	SELECT @parl



	EXECUTE teste 22


*/
	


ALTER PROCEDURE teste(@parl INT)
AS
SELECT @parl AS 'VALOR DA VARIAVEL'

EXEC teste 22 



ALTER PROCEDURE Livroisbn(@ID SMALLINT)
AS
SELECT Nome_livro as Livro, Preco_livro AS Preço FROM tbl_livro WHERE ID_livro = @ID


EXEC Livroisbn 103


-- Multiplos Parametros de Entrada

ALTER PROCEDURE teste(@p1 AS INT, @p2 AS VARCHAR(20))
AS
SELECT @p1
SELECT @p2


--EXECUTAR PASSANDO UM PARAMETRO
EXEC teste 22,'Laranja' --Por posição
EXEC teste @p1 = 25, @p2 = 'Abacate' --Por nome




-- 42 STORED PROCEDURE - PARAMETROS DE ENTRADA E INSERT PART3

ALTER PROCEDURE Livroisbn(@ID SMALLINT, @PRECO MONEY)
AS
SELECT Nome_livro AS Livro, Preco_livro AS Preço FROM tbl_livro WHERE ID_livro > @ID AND Preco_livro > @PRECO

EXEC Livroisbn @ID = 103, @PRECO = 60

SELECT * FROM tbl_livro



-- Desejo fornecer o ID ea quantidade de um titulo adquirido, e saber o valor total a pagar pelos livros

ALTER PROCEDURE Livroisbn(@quantidade SMALLINT, @id SMALLINT)
AS
SELECT Nome_livro AS Livro, Preco_livro * @quantidade AS Preço FROM tbl_livro WHERE ID_livro = @id


EXEC Livroisbn @id = 103, @quantidade = 10

SELECT * FROM tbl_livro



--Exemplo de INSERÇAO DE DADOS

CREATE PROCEDURE InsereEditora(@nome VARCHAR(50))
AS
INSERT INTO tbl_Editoras (Nome_Editora) VALUES (@nome)

EXEC InsereEditora @nome = 'Editora1'

SELECT * FROM tbl_Editoras



-- 43 - STORED PROCEDURE - PARAMETROS E SAIDA E RETURN PART 4
-- Testando Valor padrao na declaração da variavel (pa2)
CREATE PROCEDURE teste2(@pa1 INT, @pa2 VARCHAR(20) = 'Valor Padrão!')
AS
SELECT 'VALOR DO PARAMETRO 1: ' + CAST(@pa1 AS VARCHAR)
SELECT 'VALOR DO PARAMETRO 2: ' + @pa2


EXEC teste2 30

EXEC teste2 @pa1 = 40, @pa2 = 'Valor Modificado'



-- PARAMETROS DE SAIDA
/* 
	Os parametros de saida habilitam um procedimento armazenado a retornar dados ao procedimento chamador
	Usamos a palavra-chave OUTPUT quando o procedimento e criado, e tambem quando e chamado
	No procedimento armazenado, o procedimento de saida aparce coo uma variavel local, No procedimento 
	chamador, uma variavel deve ser criada para receber o parametro de saida.

*/


ALTER PROCEDURE teste(@par AS INT OUTPUT)
AS
SELECT @par * 2
RETURN -- O comando return termina incodicionalmente o procedimento e retorna um valorinteiro ao chamador
	   -- Pode ser usado para retornar status de sucesso ou falha do procedimento



--Executar passando um parametro

DECLARE @valors AS INT = 15

EXECUTE teste @valors OUTPUT

--=======================================================================================================

ALTER PROCEDURE Livroisbn(@quantidade SMALLINT, @cod SMALLINT = -10, @ID SMALLINT)
AS
SET NOCOUNT ON --Evita a Contagem de linhas e não aparece a mensagem de linhas afetadas

IF @ID >= 100
	BEGIN
		SELECT Nome_livro AS Livro, Preco_livro * @quantidade AS Preço FROM tbl_livro
		WHERE ID_livro = @ID
		RETURN 1
	END 
ELSE
	RETURN @cod


DECLARE @codigo INT
EXECUTE @codigo = Livroisbn @ID = 102, @quantidade = 5
PRINT @codigo






-- 44 Funções Definidas pelo Usuario - Função Escalar no SQL SERVER
/* 
	Podemos criar funçoes (UDFS) para realizar diversas tarefas nos bancos de dados, tais como:
	-Inserir logica complexa em uma consulta
	-Criar novas funçoes para expressoes complexas
	-Substituir exibiçoes com a vantagem de aceitar parametros

		Ha varios tipos de UDFS:
	
	Funçoes escaleres, valor de tabela embutida, valor de Tabela Multi-instruçoes



		Funçoes Escalares

		Retorna apenas um unico valor especifico

		Sintaxe:

		CREATE FUNCTION nome_funçao (parametros)
		RETURNS tipo_dados_retorno
		AS
		BEGIN
			bloco de codigo
			RETURN expressao_retorno

		END


*/

-- Exemplo de Função Escalar

-- Funçao que calcula a media das notas dos alunos, com peso 2 na nota4:


CREATE FUNCTION nota_media(@nome VARCHAR(30))
RETURNS REAL
AS
	BEGIN
		
			DECLARE @media REAL
			
			SELECT @media=(nota1 + nota2 + nota3 + nota4 * 2)/5.00 FROM tbl_alunos
			WHERE nome_aluno = @nome
			
			RETURN @media


	END


SELECT dbo.nota_media('Sandra')







-- 45 Funçoes Definidas pelo usuario - Valor de tabela embutida
/*

	Função com valor de Tabela Embutida(inline)

	São similare a uma exibição, porém permitem utilizar parametros.Retornam um conjunto completo de dados

	Sintaxe Basica

	CREATE FUNCTION nome_funçao(parametros)
	RETURNS TABLE
	AS
	RETURN(declaraçao select)

*/


-- Exemplo de funçao de valor de tabela
Use db_Biblioteca

CREATE FUNCTION retorna_itens(@valor REAL)
RETURNS Table
AS
RETURN(
SELECT L.Nome_livro, A.Nome_Autor, E.Nome_Editora 
FROM tbl_livro AS L
INNER JOIN tbl_Autores AS A
ON L.ID_Autor = A.ID_Autor
INNER JOIN tbl_Editoras AS E
ON L.ID_Editora = E.ID_Editora WHERE L.Preco_livro > @valor)		
	


-- Como usar
SELECT Nome_livro, Nome_Autor FROM retorna_itens(62.00)









-- 46 Funçoes definidas pelo usuario com varis instruçoes

/*
	Combina a habilidade de funcao escalar de conter codigos complexos com a habilidade da funçao
	com valor de tabela retornar um resultset.
	Este tipo de funcao cria uma variavel do tipo table e a popula a partir do codigo. essa tabela e entao passada volta a funcao
	de modo que possa ser usada em declaracoes SELECT.

	Vamos ver um exemplo a seguir que cria variavel de tabela chamada @VALORE e a popula com dados 
	provenientes das tabelas livros e editoras.



*/


CREATE FUNCTION multi_tabela()
RETURNS @valores table(Nome_livro VARCHAR(50),Data_Pub DATETIME, Nome_Editora VARCHAR(50), Preco_livro MONEY)
AS
BEGIN
	INSERT @valores(Nome_livro, Data_Pub, Nome_Editora, Preco_livro)
	SELECT L.Nome_livro, L.Data_Pub, E.Nome_Editora, L.Preco_livro FROM tbl_livro AS L
	INNER JOIN tbl_Editoras AS E ON L.ID_Editora = E.ID_Editora
RETURN
END				
				

SELECT * FROM multi_tabela()







-- 47 TRIGGERS - DEFINIÇÃO E TIPOS INSTEAD OF E AFTER
/*
	UM TRIGGER(GATILHO) é um tipo especial de stored procedure que é executada automaticamente quando um 
	usuario realiza uma operaçao de modificaçao de dados em uma tabela especificada.
	
	As operaçoes que podem disparar um trigger são
	-INSERT
	-UPADTE
	-DELETE
		
	Os TRIGGERS nao sao executados diretamente disparam apenas em reposta a eventos como insert,update,
	ou Delete em uma tabela.		
		
	No SQL SERVER, os triggers disparam uma vez para cada operacao de modificacao-e nao uma vez por
	linha afetada(na oracle ha as duas oçoes)


	MODOS DE DISPARO DE UM TRIGGER
	Um trigger no sql server pode ser disparado de dois modos diferentes.


		AFTER - O CODIGO PRESENTE NO TRIGGER E EXECUTADO NO LUGAR DA OPERACAO QUE CAUSOU DISPRAO.

		INSTEAD OF  - O codigo presente no trigger e executado no lugar da operacao que causou seu disparo



		Fluxo de Transações
		1-Verificação de INDENTITY INSERT
		2-Restrição (Constraint) de nulos (null)
		3-Checagem de tipos de dados
		4-Execucação de trigger INSTEAD OF(a execução do DML para aqui, esse trigger nao e recursivo)
		5-Restrição de chave primaria
		6-Restrição "check"
		7-Restrição de chave estrangeira
		8-Execução do DML e atualização do log de trasações
		9-Execução do trigger AFTER
		10-Commit da transação (Confirmação)



*/





-- 48 Triggers - Criação de Testes dos modos INSTEAD OF E AFTER

--Exemplo
/*
	CREATE TRIGGER nome_trigger
	ON tabela|view
	With Encryption
	AFTER|INSTEAD OF
	[INSERT,UPDATE,DELETE]
	AS
	Codigo do Trigger

	nome_trigger = nome do trigger
	tabela = Tbaela(ou View) onde sera executado o trigger
	WITH ENCRYPTION = Criptografa o codigo do trigger(opcional)
	AFTER = O trigger é disparado quando todas as operações especificadas nas declarações SQL e tiverem
	sido executadas com sucesso.
	INSTEAD OF = o trigger é disparado no lugar das declarações SQL.
	DELETE, UPDATE, INSERT = Definem quais tipos de modifiações na tabela especificada ativarão o trigger

*/

-- EXEMPLO SIMPLES COM AFTER(APÓS INSERIR OS DADOS)
CREATE TRIGGER teste_after
ON tbl_Editoras
AFTER INSERT
AS
PRINT'Dados Inseridos Com Sucesso'


INSERT INTO tbl_Editoras VALUES ('Saraiva')

SELECT * FROM  tbl_Editoras


--Exemplo com tabelas
CREATE TRIGGER teste2_after
ON tbl_Editoras
AFTER INSERT
AS
INSERT INTO tbl_Autores VALUES(25,'Jose','Da Silva')
INSERT INTO tbl_livro VALUES('Livro1','123456000','20001010',77,25,2)


INSERT INTO tbl_Editoras VALUES ('Editora10')

SELECT * FROM  tbl_Autores
SELECT * FROM  tbl_livro

DROP TRIGGER teste_after


-- Trigger do Tipo INSTEAD OF - Exemplo
CREATE TRIGGER teste_insteadof
ON tbl_Autores
INSTEAD OF INSERT
AS
PRINT 'Registro Não Inserido'


INSERT INTO tbl_Autores VALUES ('15', 'Alef', 'Moura')


SELECT * FROM tbl_Autores





--49 HABILITAR E DESABILITAR TRIGGER
/*
	O administrador do sistema pode desabilitar temporariamente um trigger se houver necessidade.
	Para isso use, o comando DDL ALTER TABLE
	
*/

ALTER TABLE nome_tabela
ENABLE|DISABLED TRIGGER nome_da_trigger



ALTER TABLE tbl_Editoras
DISABLE TRIGGER teste2_after

ALTER TABLE tbl_Editoras
ENABLE TRIGGER teste2_after



-- Em uma tabela especifica Verificar a existencia de triggers
Exec sp_helptrigger @tabname= nome da tabela

EXEC sp_helptrigger @tabname=tbl_Editoras




--No banco de dados todo:
-- USE nome_banco

SELECT * FROM sys.triggers WHERE is_disabled = 0
SELECT * FROM sys.triggers WHERE is_disabled = 0 OR is_disabled = 0


-- 0 = Triggers desabilitaos; 1 = Triggers Habilitados






-- 50 Determinar Colunas Alteradas e função UPDATE()
-- A Função UPDATE() retorna True se uma coluna especificada for afetadda por uma transação DML
-- Podemos criar um gatilho que executa um codigo caso a coluna especificada seja alterada por um comando
--DML usando essa função


CREATE TRIGGER alfter_autores
ON tbl_Autores
AFTER INSERT, UPDATE
AS
IF UPDATE(Nome_Autor)-- Se houver alguma atualização na coluna nome_autor ele retorna true e mostra a msg
	BEGIN
		Print'O nome do autor foi alterado'
	END

ELSE
	BEGIN
		Print'Nome não foi modificado'

	END	


UPDATE tbl_Autores SET Nome_Autor = 'Alef' WHERE ID_Autor = 25
UPDATE tbl_Autores SET SobreNome_Autor = 'White' WHERE ID_Autor = 25


SELECT * FROM tbl_Autores





-- 51 Trigger-Aninhamento e Triggers Recursivos 
/*
	Aninhamento de triggers DML

	UM trigger, ao ser disprado, pode executar uma declaração DML que leva ao disparo de outro trigger.

	Para isso, a opção de servidor 'Permitir que Gatilhos Disparem outros Gatilhos', em Propriedades so Servidor
	Avançado, deve estar configurada como True(é o padrão)

	Para desabilitar/habilitar a opção de aninhameno de triggers, use o comando

		EXEC SP_CONFIGURE 'NESTED TRIGGERS' 0|1;
		RECONFIGURE

*/

/*
	TRIGGERS RECURSIVOS

	UM GATILHO RECURSIVO É UM TIPO ESPECIAL DE TRIGGER AFTER ANINHADO

	O TRIGGER RECURSIVO OCORRE QUANDO UM TRIGGER EXECUTA UMA DECLARAÇÃO DML QUE O DISPARA NOVAMENTE.
	PODEMOS HABILITAR OU DESABILITAR OS TRIGGERS RECURSIVOS COM COMANDO ALTER DATABASE:
*/

ALTER DATABASE nome_do_bancos SET RECURSIVE_TRIGGERS ON|OFF

/*
	Vamos criar uma tabela chamda 'trigger_recursivo' com um campo pk, tipo INT, chamdo codigo, no banco db_biblioteca

	CREATE TABLE tbl_trigger_recursivo(codigo INT PRIMARY KEY)

	Vamos inserir um registro que ira disparar o trigger a seguir, o qual por sua vez ira inserir outro registro,
	que o disparará novamente:

*/

ALTER DATABASE db_Biblioteca SET RECURSIVE_TRIGGERS ON -- Habilitando triggers recursivos

CREATE TABLE trigger_recursivo
(
	Codigo INT PRIMARY KEY
)


SELECT Codigo FROM trigger_recursivo


CREATE TRIGGER testet ON trigger_recursivo
AFTER INSERT
AS
DECLARE @cod INT
SELECT @cod = MAX(codigo) FROM trigger_recursivo
IF @cod < 10
BEGIN
	INSERT INTO trigger_recursivo SELECT MAX(codigo) + 1 FROM trigger_recursivo
END

ELSE
BEGIN
	PRINT'TRIGGER RECURSIVO FINALIZADO'
END
	

INSERT INTO trigger_recursivo VALUES(1)		


SELECT Codigo FROM trigger_recursivo















































