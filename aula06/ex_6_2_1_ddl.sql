-- 6.2 a)

create table Employee(
	Fname	varchar(30)		not null,
	Minit	char(1)		not null,
	LName	varchar(15)	not null,
	Ssn		varchar(10) not null,
	Bdate	date,
    [Address]	varchar(30) not null,
	Sex		char(1)		not null,
	Salary	decimal(6,2) not null,
	Super_ssn	varchar(10),
	Dno		int	not null

	primary key(Ssn)

);

create table Department(
	Dname	varchar(30)		not null,
	Dnumber		int		not null,
	Mgr_snn		varchar(10),
	Mgr_start_date	date,

	primary key(Dnumber)

);

create table Project(
	Pname	varchar(30)		not null,
	Pnumber		int	not null,
	Plocation	varchar(15)	not null,
	Dnum	int		not null,

	primary key(Pnumber)
);

create table Dept_locations(
	Dnumber int	not null,
	Dlocation varchar(15)	not null,

	primary key (Dnumber, Dlocation)
);

create table Works_on(
	Essn	varchar(10)	not null,
	Pno int not null,
	[Hours]	decimal(3,1)

	primary key(Essn, Pno)
);

create table [dependent](
	Essn	varchar(10)	not null,
	Dependent_name varchar(15)	not null,
	Sex	char(1)	not null,
	Bdate	date,
	Relationship	varchar(15)	not null

	primary key (Essn, Dependent_name)
);

alter table Employee add constraint SuperVisor foreign key (Super_ssn) references Employee (Ssn);
alter table Employee add constraint EmpDepNumber foreign key (Dno) references Department(Dnumber);
alter table Dept_locations add constraint depLocDep foreign key (Dnumber) references Department(Dnumber); 
alter table Project add constraint ProjectDep foreign key (Dnum) references Department(Dnumber); 
alter table Works_on add constraint WorkProj foreign key (Pno) references Project(Pnumber); 
alter table Works_on add constraint WorkEmployee foreign key (Essn) references Employee (Ssn);
alter table [dependent] add constraint depEmployee foreign key (Essn) references Employee (Ssn);

