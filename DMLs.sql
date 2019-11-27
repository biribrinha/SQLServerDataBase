/* Inserir dados do aluno */
INSERT INTO ALUNO(Nome, Ra, Idade) VALUES('Alef', 'R123', 23);
INSERT INTO ALUNO(Nome, Ra, Idade) VALUES('Bruna', 'R124', 22);

/* Inserir dados na tabela materia */
INSERT INTO MATERIA(Materia) VALUES('Português'),('Matemática'); 


/* Atualizando registro */
UPDATE ALUNO SET Nome = 'Bruna Ribeiro' WHERE IdAluno = 2;


/* Excluir Dados */
DELETE FROM MATERIA WHERE Id_Materia = 2;
