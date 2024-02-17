create table Medico(
	numSNS int not null,
	nome varchar(30) not null,
	especialidade varchar(15) not null,

	primary key(numSNS)
);

create table Paciente(
	numUtente int not null,
	nome varchar(30) not null, 
	dataNasc date not null, 
	endereco varchar(50) not null,

	primary key(numUtente)
);

create table Farmacia(
	nome varchar(30) not null,
	telefone int not null,
	endereco varchar(30) not null,

	primary key(nome)
);

create table Farmaceutica(
	numReg int not null,
	nome varchar(10) not null,
	endereco varchar(30) not null,

	primary key(numReg)
);

create table Farmaco(
	FarmReg int not null,
	nome varchar(30) not null,
	formula varchar(30) not null,
	
	primary key(FarmReg,nome)
);

create table Prescricao(
	numPresc int not null,
	numUtente int not null,
	numMedico int not null,
	nomeFarmacia varchar(30),
	dataProc date,

	primary key(numPresc)
);

create table Presc_farmaco(
	numPresc int not null,
	FarmReg int not null,
	nomeFarmaco varchar(30),

	primary key(numPresc, FarmReg, nomeFarmaco)
);

alter table Farmaco add constraint numRegFarm foreign key (FarmReg) references Farmaceutica (numReg);
alter table Prescricao add constraint numUtente foreign key (numUtente) references Paciente(numUtente);
alter table Prescricao add constraint numMedico foreign key (numMedico) references Medico(numSNS);
alter table Prescricao add constraint nomeFarmacia foreign key (nomeFarmacia) references Farmacia(nome);
alter table Presc_farmaco add constraint numPresc foreign key (numPresc) references Prescricao(numPresc);
alter table Presc_farmaco add constraint FarmReg foreign key (FarmReg, nomeFarmaco) references Farmaco(FarmReg, nome);
