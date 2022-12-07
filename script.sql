drop database if exists escolaDanca;
create database escolaDanca charset=UTF8 collate utf8_general_ci;
use escolaDanca;

create table Turmas(
    codTurma integer primary key auto_increment,
    horario varchar(20) not null,
    tipo varchar(30) not null
);

create table Professores(
    idProf integer primary key auto_increment,
    nomeProf varchar(70) not null,
    formacao varchar(70) not null,
    codDaTurma integer not null,
    foreign key (codDaTurma) references Turmas(codTurma) on delete cascade
);

create table Telefones(
	idProfessor integer not null,
	telefone varchar(15) not null,
	foreign key (idProfessor) references Professores(idProf) on delete cascade
);

create table Alunos(
    ra varchar(20) primary key not null,
	nome varchar(70) not null,
	sexo varchar(20) not null,
    dnascimento varchar(20) not null,
    codT integer not null,
    foreign key (codT) references Turmas(codTurma) on delete cascade
);

create table Disciplinas( 
	idDisc integer primary key auto_increment,
	nomeDisc varchar(40) not null,
    codTurminha integer not null,
    foreign key (codTurminha) references Turmas(codTurma) on delete cascade
);

create table Horarios(
    idHor integer primary key auto_increment,
    inicio varchar(20) not null,
    fim varchar(20) not null,
    discip integer not null,
    foreign key (discip) references Disciplinas(idDisc) on delete cascade
);

INSERT INTO Turmas VALUES (default, 'manhã', 'adulto');
INSERT INTO Turmas VALUES (default, 'tarde', 'idoso');
INSERT INTO Turmas VALUES (default, 'noite', 'adulto');

INSERT INTO Professores VALUES (default, 'Roberto Carlos', 'Dança', 1);
INSERT INTO Professores VALUES (default, 'Junior Prado', 'Dança', 2);
INSERT INTO Professores VALUES (default, 'Carlao', 'Dança', 3);

INSERT INTO Telefones VALUES (1, '199989890');
INSERT INTO Telefones VALUES (1, '199089980');
INSERT INTO Telefones VALUES (2, '199984253');
INSERT INTO Telefones VALUES (2, '199087892');

INSERT INTO Disciplinas VALUES (default, 'Valsa', 1);
INSERT INTO Disciplinas VALUES (default, 'Salsa', 1);
INSERT INTO Disciplinas VALUES (default, 'Samba', 2);
INSERT INTO Disciplinas VALUES (default, 'Funk', 2);
INSERT INTO Disciplinas VALUES (default, 'Balé', 3);
INSERT INTO Disciplinas VALUES (default, 'Zumba', 3);
INSERT INTO Disciplinas VALUES (default, 'dança do ventre', 2);

INSERT INTO Horarios VALUES (default, '07:30', '11:20', 1);
INSERT INTO Horarios VALUES (default, '06:40', '09:30', 2);
INSERT INTO Horarios VALUES (default, '09:30', '11:30', 3);
INSERT INTO Horarios VALUES (default, '13:00', '16:00', 4);
INSERT INTO Horarios VALUES (default, '07:30', '11:20', 5);
INSERT INTO Horarios VALUES (default, '06:40', '09:30', 6);
INSERT INTO Horarios VALUES (default, '09:30', '11:30', 7);

INSERT INTO Alunos VALUES ('0004594999', 'Juliano', 'homem', '27/09/2000', 1);
INSERT INTO Alunos VALUES ('0004594980', 'Liminha', 'homem', '27/12/2006', 1);
INSERT INTO Alunos VALUES ('0004782152', 'Robertao', 'homem', '10/08/1990', 1);
INSERT INTO Alunos VALUES ('0004501312', 'Guilherme', 'homem', '24/06/2000', 2);
INSERT INTO Alunos VALUES ('0004721405', 'Gleidson', 'homem', '01/09/2005', 2);
INSERT INTO Alunos VALUES ('0004782489', 'Felipe', 'homem', '22/06/2000', 2);
INSERT INTO Alunos VALUES ('0004325061', 'Ana', 'mulher', '18/08/1981', 3);
INSERT INTO Alunos VALUES ('0004513654', 'Denis', 'homem', '22/01/1980', 3);
INSERT INTO Alunos VALUES ('0004512345', 'Carlao', 'homem', '18/11/1999', 3);

create view vw_Professores as
select p.idProf as idProf,p.nomeProf as nomeProf, p.formacao as formacao, t.idProfessor as idProfessor, t.telefone as telefone from Professores p 
inner join Telefones t on p.idProf = t.idProfessor;

create view vw_turmas_alunos as
select t.codTurma as codTurma, t.tipo, a.ra as ra, a.nome, a.sexo, a.dNascimento from Alunos a left join Turmas t on t.codTurma = a.codT;

create view vw_turmas_disc as
select t.codTurma as codTurma, t.tipo, d.idDisc as idDisc, d.nomeDisc from Turmas t inner join Disciplinas d on t.codTurma = d.codTurminha;

create view vw_prof_turma as
select p.nomeProf as nomeProf, t.tipo as tipo from Professores p inner join Turmas t on t.codTurma = p.codDaTurma;

create view vw_disc_horarios as
select d.nomeDisc as nomeDisc, h.inicio, h.fim from Disciplinas d inner join Horarios h on d.idDisc = h.discip;

SHOW TABLES;