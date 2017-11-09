create table Disciplina
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
	,CONSTRAINT PKnome PRIMARY KEY (nome) 
);
SELECT * FROM Disciplina
CREATE TABLE Periododisciplina
(

	Sigla_curso  VARCHAR(5)
	,Ano_grade SMALLINT
	,Semestre_grade CHAR(1)
	,numero_periodo TINYINT
	,Nome_disciplina VARCHAR(240)
	,CONSTRAINT pkPeriododisciplina  PRIMARY KEY (Sigla_curso,Ano_grade,Semestre_grade,numero_periodo,Nome_disciplina)
	,CONSTRAINT fkSigla_curso         FOREIGN KEY (Sigla_curso)      REFERENCES Curso(Sigla)
    ,CONSTRAINT fkAno_grade           FOREIGN KEY (Ano_grade)        REFERENCES Grade_curricular(Ano)
    ,CONSTRAINT fkSemestre_grade      FOREIGN KEY(Semestre_grade)    REFERENCES Grade_curricular(Semestre)
	,CONSTRAINT fknumero_periodo      FOREIGN KEY(numero_periodo)    REFERENCES Periodo(numero_periodo)
	,CONSTRAINT fknome_displina       FOREIGN KEY (Nome_disciplina ) REFERENCES Disciplina(Nome_disciplina)
);

CREATE TABLE Periodo
(	
		
    Sigla_curso  VARCHAR(5)
	,Ano_grade SMALLINT
	,Semestre_grade CHAR(1)
	,numero TINYINT NOT  NULL
	,CONSTRAINT pkPeriodo        PRIMARY KEY (Sigla_curso,Ano_grade,Semestre_grade,numero)
	,CONSTRAINT fkSigla_curso    FOREIGN KEY (Sigla_curso)    REFERENCES Curso(Sigla)
    ,CONSTRAINT fkAno_grade      FOREIGN KEY (Ano_grade)      REFERENCES Grade_curricular(Ano)
    ,CONSTRAINT fkSemestre_grade FOREIGN KEY (Semestre_grade) REFERENCES Grade_curricular(Semestre)
);
select * from Periodo

CREATE TABLE Grade_curricular
(	
	Sigla_curso  VARCHAR(5)
	, Ano SMALLINT NOT NULL
	, Semestre CHAR(1)
    ,CONSTRAINT pkGrade_curricular  PRIMARY KEY(Sigla_curso,Ano,Semestre) 
	,CONSTRAINT fkSigla_curso       FOREIGN KEY(Sigla_curso) REFERENCES Curso (Sigla)
);
SELECT * from Grade_curricular

CREATE  TABLE DisciplinaOfertada
(
	nome_disciplina VARCHAR(240)
	,ano SMALLINT NOT NULL
	,semestre CHAR(1) NOT NULL
	,DisciplinaOfertada VARCHAR
	,CONSTRAINT pkDisciplinaOfertada PRIMARY KEY (DisciplinaOfertada)
	, CONSTRAINT fknome_disciplina FOREIGN KEY (nome_disciplina) REFERENCES Disciplina (nome_dsiciplina)
);

CREATE TABLE Curso
(
	
Sigla VARCHAR(5) NOT NULL
,Nome VARCHAR(50)NOT NULL
,CONSTRAINT pkCurso PRIMARY KEY (Sigla)
,CONSTRAINT uqNome UNIQUE (Nome)
);
create table CursoTurma
(
	sigla_curso VARCHAR(5)
	,nome_disciplina VARCHAR(240)
	,ano_ofertado Smallint
	,semestre_ofertado CHAR(1)
	,id_turma CHAR(1)
	,CursoTurma VARCHAR
	,constraint PKCursoTurma PRIMARY KEY(CursoTurma)
);

create table Aluno
(
	ra  INT IDENTITY(1,1) NOT NULL
	,nome	 VARCHAR(120)not null
	,Email  VARCHAR(80)not null
	,celular     CHAR(11)NOT NULL
	,sigla_Curso CHAR(2)not null
	,CONSTRAINT PKra PRIMARY KEY (ra)
);

create table Matricula
(
	ra_aluno int identity (1,1)
	,nome_disciplina varchar(240)
	,ano_ofertado smallint
	,semestre_ofertado CHAR(1)
	,id_Turma CHAR(1)
	,Matricula VARCHAR
	,CONSTRAINT PKMatricula PRIMARY KEY (Matricula)
);

create table Turma 
(
	ra_professor int identity (1,1)
	,nome_disciplina varchar(240)
	,ano_ofertado smallint 
	,semestre_ofertado char(1)not null
	,id char (1)
	,turno VARCHAR (15)not null
	,Turma VARCHAR
	,CONSTRAINT PKTurma PRIMARY KEY (Turma)
);

create table  Teacher
(
	ra  INT IDENTITY(1,1) NOT NULL
	,nome VARCHAR (120)
	,Email VARCHAR (80)
	,celular CHAR(11)
	,apelido VARCHAR
	,Teacher VARCHAR
	,CONSTRAINT PKTeacher PRIMARY KEY (Teacher)
	,CONSTRAINT UQapelido UNIQUE (apelido)
);

create table Question
(
	nome_Disciplina VARCHAR(240)
	,ano_ofertado Smallint 
	,semestre_ofertado CHAR(15)
	,id_turma          CHAR(1)
	,numero int
	,data_limite_entrega SMALLDATETIME
	,descricao VARCHAR(500)
	,data1 DATE  
	,CONSTRAINT PKnumero PRIMARY KEY (numero)
	,CONSTRAINT FKnome_disciplina  FOREIGN KEY(nome_disciplina)   REFERENCES disciplina(nome)
	,CONSTRAINT FKano_ofertado     FOREIGN KEY(ano_ofertado)      REFERENCES grade_curricular(ano)
	,CONSTRAINT FKsemestre_ofertado FOREIGN KEY(semestre_ofertado) REFERENCES grade_curricular(semestre)
	,CONSTRAINT FKid_turma         FOREIGN KEY(id_turma)            REFERENCES curso_turma(idturma)
);

CREATE TABLE ArquivosQuestao
	(
		nome_disciplina VARCHAR (240)
	,ano_ofertado SMALLINT
	,semestre_ofertado CHAR
	,id_turma CHAR
	,numero_questao INT
	,arquivo VARCHAR(500) NOT NULL
	,CONSTRAINT pkArquivosQuestao PRIMARY KEY (arquivo,nome_disciplina,ano_ofertado,id_turma,numero_questao)
	,CONSTRAINT fknome_disciplina    FOREIGN KEY (nome_disciplina)   REFERENCES Disciplina(nome)
	,CONSTRAINT fkid_turma           FOREIGN KEY (id_turma)          REFERENCES Turma(turma)
	,CONSTRAINT fknumero_questao     FOREIGN KEY (numero_questao)    REFERENCES Question (numero_questao)
);


CREATE TABLE Resposta

	(	
			nome_disciplina VARCHAR
	,ano_ofertado SMALLINT
	,semestre_ofertado CHAR
	,id_turma CHAR
	,numero_questao INT
	,ra_aluno INT
	,data_avaliacao DATE NOT NULL
	,nota DECIMAL (3,2) NOT NULL
	,avaliacao VARCHAR (500)
	,descricao VARCHAR(500)
	,data_de_envio SMALLDATETIME
	,CONSTRAINT pkResposta PRIMARY KEY (ra_aluno,nome_disciplina,ano_ofertado,id_turma,numero_questao)
	,CONSTRAINT fknome_disciplina     FOREIGN KEY (nome_disciplina)   REFERENCES Disciplina(nome_disciplina)
	,CONSTRAINT fkano_ofertado        FOREIGN KEY (ano_ofertado)      REFERENCES DisciplinaOfertada (ano_ofertado)
	,CONSTRAINT fksemestre_ofertado   FOREIGN KEY(semestre_ofertado)  REFERENCES DisciplinaOfertada(semestre_ofertado)
	,CONSTRAINT fkid_turma            FOREIGN KEY (id_turma)          REFERENCES Turma(id_turma)
	,CONSTRAINT fknumero_questao      FOREIGN KEY (numero_questao)    REFERENCES Questao (numero_questao)

);

CREATE TABLE ArquivosResposta
	(
				nome_disciplina VARCHAR
	,ano_ofertado SMALLINT
	,semestre_ofertado CHAR
	,id_turma CHAR
	,numero_questao INT
	,ra_aluno INT
	,arquivo VARCHAR(500)
	,CONSTRAINT pkArquivosResposta PRIMARY KEY (arquivo,ra_aluno,nome_disciplina,ano_ofertado,id_turma,numero_questao)
	,CONSTRAINT fknome_disciplina     FOREIGN KEY (nome_disciplina)   REFERENCES Disciplina(nome_disciplina)
	,CONSTRAINT fkano_ofertado        FOREIGN KEY (ano_ofertado)      REFERENCES DisciplinaOfertada (ano_ofertado)
	,CONSTRAINT fksemestre_ofertado   FOREIGN KEY(semestre_ofertado)  REFERENCES DisciplinaOfertada(semestre_ofertado)
	,CONSTRAINT fkid_turma            FOREIGN KEY (id_turma)          REFERENCES Turma(id_turma)
	,CONSTRAINT fknumero_questao      FOREIGN KEY (numero_questao)    REFERENCES Questao (numero_questao)
	,CONSTRAINT fkra_aluno            FOREIGN KEY(ra_aluno)           REFERENCES Aluno(ra_aluno)
);
