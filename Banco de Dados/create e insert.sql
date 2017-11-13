CREATE DATABASE CadastroAluno
GO

USE CadastroAluno
GO

CREATE TABLE Disciplina
(
	carga_horaria TINYINT  
	,teoria		  DECIMAL(3)
	,pratica	  DECIMAL(3)
	,ementa				 Text
	,competencias		 TEXT
	,habilidades		 TEXT
	,conteudo			 TEXT 
	,bibliografia_basica TEXT
	,bibliografia_complementar TEXT
	,nome varchar (240)
	,CONSTRAINT PKDisciplina PRIMARY KEY (nome) 
);
SELECT * FROM Disciplina

CREATE TABLE Curso
(
	Sigla VARCHAR(5) NOT NULL
	,Nome VARCHAR(50)NOT NULL
	,CONSTRAINT pkCurso PRIMARY KEY (Sigla)
	,CONSTRAINT uqNome UNIQUE (Nome)
);
select * from curso

CREATE TABLE GradeCurricular
(	
	Sigla_curso VARCHAR(5)
	,Ano SMALLINT NOT NULL
	,Semestre CHAR(1)
    ,CONSTRAINT pkGradeCurricular  PRIMARY KEY(Ano,Semestre,sigla_curso) 
	,CONSTRAINT fkGradeCurricularCurso   FOREIGN KEY(Sigla_curso) REFERENCES Curso(Sigla)
);
SELECT * from GradeCurricular

CREATE TABLE Periodo
(	
    Sigla_curso  VARCHAR(5)
	,Ano_grade SMALLINT
	,Semestre_grade CHAR(1)
	,numero TINYINT NOT  NULL
	,CONSTRAINT pkPeriodo        PRIMARY KEY (numero,sigla_curso,ano_grade,semestre_grade)
	,CONSTRAINT fkPeriodoGrade   FOREIGN KEY (Ano_grade, Semestre_grade,sigla_curso) REFERENCES GradeCurricular(Ano, Semestre,sigla_curso)
);
select * from Periodo

CREATE TABLE PeriodoDisciplina
(
	Sigla_curso  VARCHAR(5)
	,Ano_grade SMALLINT
	,Semestre_grade CHAR(1)
	,numero_periodo TINYINT
	,Nome_disciplina VARCHAR(240)
	,CONSTRAINT pkPeriodoDisciplina  PRIMARY KEY (numero_periodo,Nome_disciplina,sigla_curso,ano_grade,semestre_grade)
	,CONSTRAINT fkPeriodoDisciplinaPeriodo      FOREIGN KEY (numero_periodo,sigla_curso,ano_grade,semestre_grade)  REFERENCES Periodo(numero,sigla_curso,ano_grade,semestre_grade)
	,CONSTRAINT fkPeriodoDisciplinaDisciplina   FOREIGN KEY (Nome_disciplina ) REFERENCES Disciplina(Nome)
);
select * from PeriodoDisciplina

CREATE  TABLE DisciplinaOfertada
(
	nome_disciplina VARCHAR(240)
	,ano SMALLINT NOT NULL
	,semestre CHAR(1) NOT NULL
	,CONSTRAINT pkDisciplinaOfertada PRIMARY KEY (ano,semestre,nome_disciplina)
	, CONSTRAINT fkDisciplinaOfertadaDisciplina FOREIGN KEY (nome_disciplina) REFERENCES Disciplina (nome)
);
select * from DisciplinaOfertada 

CREATE TABLE  Professor
(
	ra  INT IDENTITY(1,1) NOT NULL
	,nome VARCHAR (120)
	,Email VARCHAR (80)
	,celular CHAR(11)
	,apelido VARCHAR
	,CONSTRAINT PKProfessor PRIMARY KEY (ra)
	,CONSTRAINT UQapelido UNIQUE (apelido)
);
select * from Professor

CREATE TABLE Turma 
(
	ra_professor INT 
	,nome_disciplina VARCHAR(240)
	,ano_ofertado SMALLINT 
	,semestre_ofertado CHAR(1) NOT NULL
	,id CHAR(1)
	,turno VARCHAR (15) NOT NULL
	,CONSTRAINT PKTurma PRIMARY KEY (id,nome_disciplina,ano_ofertado,semestre_ofertado)
	,CONSTRAINT fkTurmaProfessor FOREIGN KEY(ra_professor) REFERENCES professor(ra)
	,CONSTRAINT fkTurmaDisciplinaOfertada FOREIGN KEY(ano_ofertado,semestre_ofertado,nome_disciplina) REFERENCES DisciplinaOfertada (ano, semestre,nome_disciplina)
);
select * from turma

CREATE TABLE CursoTurma
(
	sigla_curso VARCHAR(5)
	,nome_disciplina VARCHAR(240)
	,ano_ofertado SMALLINT
	,semestre_ofertado CHAR(1)
	,id_turma CHAR(1)
	,CONSTRAINt pkCursoTurma PRIMARY KEY (id_turma, sigla_curso,nome_disciplina,ano_ofertado,semestre_ofertado)
	,CONSTRAINT fkCursoTurmaCurso FOREIGN KEY(sigla_curso) REFERENCES Curso(sigla)
	,CONSTRAINT fkCursoTurmaTurma FOREIGN KEY(id_turma,nome_disciplina,ano_ofertado,semestre_ofertado) REFERENCES Turma(id,nome_disciplina,ano_ofertado,semestre_ofertado)
);
select * from CursoTurma

CREATE TABLE Aluno
(
	ra  INT IDENTITY(1,1) NOT NULL
	,nome	 VARCHAR(120)not null
	,Email  VARCHAR(80)not null
	,celular     CHAR(11)NOT NULL
	,sigla_Curso VARCHAR(5)
	,CONSTRAINT pkAluno PRIMARY KEY (ra)
	,CONSTRAINT fkAlunoCurso FOREIGN KEY(sigla_curso) REFERENCES curso(sigla)
);
select * from Aluno


CREATE TABLE Matricula
(
	ra_aluno INT 
	,nome_disciplina VARCHAR(240)
	,ano_ofertado SMALLINT
	,semestre_ofertado CHAR(1)
	,id_Turma CHAR(1)
	,CONSTRAINT pkMatricula PRIMARY KEY (ra_aluno, id_turma,nome_disciplina,ano_ofertado,semestre_ofertado)
	,CONSTRAINT fkMatriculaTurma FOREIGN KEY(id_turma,nome_disciplina,ano_ofertado,semestre_ofertado) REFERENCES Turma(id,nome_disciplina,ano_ofertado,semestre_ofertado)
	,CONSTRAINT fkMatriculaAluno FOREIGN KEY(ra_aluno) REFERENCES Aluno(ra)
);
select * from Matricula

CREATE TABLE Questao
(
	nome_Disciplina VARCHAR(240)
	,ano_ofertado Smallint 
	,semestre_ofertado CHAR(1)
	,id_turma          CHAR(1)
	,numero int
	,data_limite_entrega DATE
	,descricao VARCHAR(500)
	,data1 DATE  
	,CONSTRAINT pkQuestao PRIMARY KEY (numero,id_turma,nome_disciplina,ano_ofertado,semestre_ofertado)
	,CONSTRAINT fkQuestaoTurma FOREIGN KEY(id_turma,nome_disciplina,ano_ofertado,semestre_ofertado)  REFERENCES Turma(id,nome_disciplina,ano_ofertado,semestre_ofertado)
);
select * from Questao

CREATE TABLE ArquivosQuestao
	(
	nome_disciplina VARCHAR (240)
	,ano_ofertado SMALLINT
	,semestre_ofertado CHAR
	,id_turma CHAR
	,numero_questao INT
	,arquivo VARCHAR(500) NOT NULL
	,CONSTRAINT pkArquivosQuestao PRIMARY KEY (arquivo,numero_questao,id_turma,nome_disciplina,ano_ofertado,semestre_ofertado)
	,CONSTRAINT fkArquivoQuestaoQuestao FOREIGN KEY (numero_questao,id_turma,nome_disciplina,ano_ofertado,semestre_ofertado)  REFERENCES Questao (numero,id_turma,nome_disciplina,ano_ofertado,semestre_ofertado)
);
select * from ArquivosQuestao

CREATE TABLE Resposta
(	
	nome_disciplina VARCHAR(240)
	,ano_ofertado SMALLINT
	,semestre_ofertado CHAR(1)
	,id_turma CHAR(1)
	,numero_questao INT
	,ra_aluno INT
	,data_avaliacao DATE NOT NULL
	,nota DECIMAL (4,2) NOT NULL
	,avaliacao TEXT
	,descricao TEXT
	,data_de_envio DATE
	,CONSTRAINT pkResposta PRIMARY KEY (ra_aluno,numero_questao,id_turma,nome_disciplina,ano_ofertado,semestre_ofertado)
	,CONSTRAINT fkRespostaQuestao      FOREIGN KEY (numero_questao,id_turma,nome_disciplina,ano_ofertado,semestre_ofertado)    REFERENCES Questao (numero,id_turma,nome_disciplina,ano_ofertado,semestre_ofertado)
	,CONSTRAINT fkRespostaAluno FOREIGN KEY(ra_aluno) REFERENCES Aluno(ra)
);
select * from Resposta

CREATE TABLE ArquivosResposta
(
	nome_disciplina VARCHAR(240)
	,ano_ofertado SMALLINT
	,semestre_ofertado CHAR
	,id_turma CHAR
	,numero_questao INT
	,ra_aluno INT
	,arquivo VARCHAR(500)
	,CONSTRAINT pkArquivosResposta PRIMARY KEY (arquivo,ra_aluno,numero_questao,id_turma,nome_disciplina,ano_ofertado,semestre_ofertado)
	,CONSTRAINT fkArquivoRespostaResposta  FOREIGN KEY (ra_aluno,numero_questao,id_turma,nome_disciplina,ano_ofertado,semestre_ofertado)   REFERENCES Resposta (ra_aluno,numero_questao,id_turma,nome_disciplina,ano_ofertado,semestre_ofertado)
);
select * from ArquivosResposta



-- INSERTS NAS TABDELAS

INSERT INTO Disciplina(nome,carga_horaria,teoria,pratica,ementa,competencias,habilidades,conteudo, bibliografia_basica, bibliografia_complementar)
VALUES ('Banco de Dados',80,20,60,'Banco de Dados (BD). Sistema de Gerência de BD: funcionalidades, módulos principais, categorias de usuários,
dicionário de dados. Modelo relacional: conceitos, restrições de integridade, álgebra relacional, cálculo
relacional. Linguagens SQL: DDL, DML, restrições de integridade, visões, autorização de acesso. Modelagem
de dados: etapas do projeto de um BD relacional, modelo Entidade-Relacionamento (ER), mapeamento
ER-relacional. Teoria da Normalização: objetivo, dependências funcionais, formas normais.','Manipular Sql Server','Permitir ao aluno assimilar conhecimentos fundamentais em BDs, incluindo modelos de dados,
arquitetura de SGBDs, acesso a BDs, segurança, integridade, controle de concorrência, processamento de
transações e recuperação após falhas de BDs.
- Capacitar o aluno a projetar BDs relacionais para aplicações e compreender os princípios de organização
dos dados.
- Habilitar o aluno a criar fisicamente esses BDs sobre SGBDs relacionais e acessa-los de maneira
adequada via linguagem SQL.','- Banco de dados (BD), Abstração de Dados, Modelos de Dados, Sistema de gerenciamento de bancos de dados (SGBD)','- Date, C.J. An introduction to database systems, Addison-Wesley, 8th edition, 2003. (Tradução: Introdução a Sistemas de Bancos de Dados, Editora Campus, 2004). Korth, H.F. e Silberschatz, A. Sistemas de Bancos de Dados, Makron Books, 5a. edição, Editora Campus, 2006.','Elmasri, R. and Navathe, S.B. Fundamentals of database systems, 4th. edition, Addison-Wesley, 2003. (Tradução: Sistemas de Banco de Dados, Addison-Wesley, 2005).');


INSERT INTO Curso(Sigla,Nome)
VALUES ('SI','Sistema de Informação')
	,('ADS','Análise e Desenvolvimento de Sistemas');

INSERT INTO GradeCurricular(Sigla_curso,Semestre,Ano)
VALUES ('SI',2,2015);

INSERT INTO Periodo(Sigla_curso,Ano_grade,Semestre_grade,numero)
VALUES('SI',2015,'2',8);

INSERT INTO PeriodoDisciplina(Sigla_curso,Ano_grade,Semestre_grade,numero_periodo,Nome_disciplina)
VALUES ('SI',2015,2,8,'Banco de Dados');

INSERT INTO DisciplinaOfertada(nome_disciplina,ano,semestre)
VALUES ('Banco de Dados',2018,1);

INSERT INTO Professor(ra,nome,Email,celular,apelido)
VALUES('Sand Onofre','sand.onofre@gmail.com',11965545567,'S');

INSERT INTO Turma(nome_disciplina,ano_ofertado,semestre_ofertado,id,turno)
VALUES ('Banco de Dados',2018,1,10,'MANHÃ');

INSERT INTO CursoTurma(sigla_curso,nome_disciplina,ano_ofertado,semestre_ofertado,id_turma)
VALUES ('SI','Banco de Dados',2018,1,10);

INSERT INTO Aluno(nome,email,celular,sigla_Curso)
VALUES ('Paola Barcellos Charra','paah.oosaki@gmail.com',11981526847,'ADS');

INSERT INTO Matricula(ra_aluno,nome_disciplina,ano_ofertado,semestre_ofertado,id_turma)
VALUES (1,'Banco de Dados',2018,1,10);

INSERT INTO Questao(nome_disciplina,ano_ofertado,semestre_ofertado,id_turma,numero,data_limite_entrega,descricao,data1)
VALUES ('Banco de Dados',2018,1,10,15,'2017-12-28','Projeto de Banco de Dados - Prof: Sand','2017-11-11');

INSERT INTO ArquivosQuestao(arquivo,numero_questao,id_turma,nome_disciplina,ano_ofertado,semestre_ofertado)
VALUES ('Arquivo encontra-se no Maverick ou na SmartClass',15,10,'Banco de Dados',2018,1);

INSERT INTO Resposta(ra_aluno,numero_questao,id_turma,nome_disciplina,ano_ofertado,semestre_ofertado,data_avaliacao,nota,avaliacao,descricao,data_de_envio)
VALUES (1,15,10,'Banco de Dados',2018,1,'2017-11-29',9.5,'Bom Aluno','Prova prática de BD utilizando o MSM','2017-12-02');

INSERT INTO ArquivosResposta(arquivo,ra_aluno,numero_questao,id_turma,nome_disciplina,ano_ofertado,semestre_ofertado)
VALUES ('Arquivo Avaliado',1,15,10,'Banco de Dados',2018,1);


SELECT A.nome AS 'Aluno'
	,A.sigla_Curso AS 'Curso'
	,M.nome_disciplina AS 'Disciplina'
	,M.ra_aluno AS 'RA'
FROM Aluno AS A JOIN Matricula AS M ON A.ra = M.ra_aluno

SELECT 	D.nome AS 'Disciplina'
	,D.carga_horaria AS 'Carga Horaria'
	,PD.Sigla_curso AS 'Sigla'
	,PD.Ano_grade AS 'Ano'
	,pd.Semestre_grade AS 'Semestre'			
FROM Disciplina AS D JOIN PeriodoDisciplina AS PD ON D.nome = PD.Nome_disciplina


