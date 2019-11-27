/***** DDL */
CREATE DATABASE loja;

USE loja;

CREATE TABLE marca
(
	IdMarca INT IDENTITY NOT NULL PRIMARY KEY,
	Nome VARCHAR(30) NOT NULL
);

CREATE TABLE cor
(
	IdCor INT IDENTITY NOT NULL PRIMARY KEY,
	Nome VARCHAR(20) NOT NULL
);

CREATE TABLE tamanho
(
	IdTamanho INT IDENTITY NOT NULL PRIMARY KEY,
	Nome VARCHAR(2) NOT NULL
);

CREATE TABLE camiseta
(
	IdCamiseta INT IDENTITY NOT NULL PRIMARY KEY,
	IdMarca INT CONSTRAINT fk_camiseta_marca FOREIGN KEY REFERENCES marca(IdMarca),
	IdTamanho INT CONSTRAINT fk_camiseta_tamanho FOREIGN KEY REFERENCES tamanho(IdTamanho),
	IdCor INT CONSTRAINT fk_camiseta_cor FOREIGN KEY REFERENCES cor(IdCor)

);

/***** DDL */


/***** DML */

INSERT INTO marca(Nome) VALUES('Khelf');
INSERT INTO cor(Nome) VALUES('Azul'),('Branco'),('Verde'),('Vermelho'),('Roxo');
INSERT INTO tamanho(Nome) VALUES('P'),('M'),('G'),('GG');

/* Inserção da Camisetas */
-- Camisetas Roxa todos os tamanhos
INSERT INTO camiseta (IdMarca, IdTamanho, IdCor) VALUES (1, 1, 5),(1, 2, 5),(1, 3, 5),(1, 4, 5);

-- Camisetas Vermelha todos os tamanhos
INSERT INTO camiseta (IdMarca, IdTamanho, IdCor) VALUES (1, 1, 4),(1, 2, 4),(1, 3, 4),(1, 4, 4);

-- Camisetas Verde todos os tamanhos
INSERT INTO camiseta (IdMarca, IdTamanho, IdCor) VALUES (1, 1, 3),(1, 2, 3),(1, 3, 3),(1, 4, 3);

-- Camisetas Branco todos os tamanhos
INSERT INTO camiseta (IdMarca, IdTamanho, IdCor) VALUES (1, 1, 2),(1, 2, 2),(1, 3, 2),(1, 4, 2);

-- Camisetas Azul todos os tamanhos
INSERT INTO camiseta (IdMarca, IdTamanho, IdCor) VALUES (1, 1, 1),(1, 2, 1),(1, 3, 1),(1, 4, 1);

-- Inserir 3 marcas de sua escolha
INSERT INTO marca(Nome) VALUES('Nike'),('Oakley'),('Lacoste');

-- Alterar marca de 2 camisetas
UPDATE camiseta SET IdMarca = 2 WHERE IdCamiseta = 16
UPDATE camiseta SET IdMarca = 3 WHERE IdCamiseta = 17
UPDATE camiseta SET IdMarca = 4 WHERE IdCamiseta = 18

-- Deletar a camiseta com maior id
DELETE FROM camiseta WHERE IdCamiseta = (SELECT MAX(IdCamiseta) FROM camiseta)

/***** DML */

/***** DQL */

-- Selecionar todas as camisetas
SELECT * FROM camiseta

-- Selecionar todas as marcas
SELECT * FROM marca

-- Selecionar todas as cores
SELECT * FROM cor

-- Selecionar todas as camisetas e sua respectivas marcas
SELECT C.IdCamiseta, M.Nome FROM camiseta AS C 
INNER JOIN marca as M ON C.IdMarca = M.IdMarca

-- Selecionar todas as camisetas  e suas respectivas cores
SELECT  C.IdCamiseta, CO.Nome
FROM camiseta AS C 
INNER JOIN cor AS CO ON CO.IdCor = C.IdCor 

-- Selecionar todas as camisetas e seus tamanhos
SELECT  C.IdCamiseta, T.Nome
FROM camiseta AS C 
INNER JOIN tamanho
AS T ON T.IdTamanho = C.IdTamanho


SELECT C.IdCamiseta, M.Nome AS 'Marca', T.Nome AS 'Tamanho', CO.Nome AS 'Cor' FROM camiseta AS C
INNER JOIN marca AS M ON M.IdMarca = C.IdMarca
INNER JOIN tamanho AS T ON T.IdTamanho = C.IdTamanho
INNER JOIN cor AS CO ON C.IdCor = CO.IdCor ORDER BY M.Nome DESC

/***** DQL */

/***** EXTRAS */
--  Alterar a tabela de marcas adicionando as colunas de quantidade de lojas e data de criação da marca.
ALTER TABLE marca ADD Qtd_Lojas INT;
ALTER TABLE marca ADD Data_Criacao DATE DEFAULT GETDATE();

-- Deixando Apenas o id 1 com valor null
ALTER TABLE camiseta ADD Lavagem CHAR(1) DEFAULT 'S';
UPDATE camiseta SET Lavagem = 'S' WHERE IdCamiseta > 1 

-- Alterar a tabela de tamanhos  para adicionar a coluna medidas ex "30.30"	
ALTER TABLE tamanho ADD Medidas VARCHAR(10);
SELECT * FROM tamanho

/***** EXTRAS */






select * from camiseta
