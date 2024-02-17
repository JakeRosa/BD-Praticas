CREATE TABLE Artigo(
    NúmeroRegisto INTEGER NOT NULL,
    Instituicao_Nome VARCHAR(50) NOT NULL,
    Título VARCHAR(50) NOT NULL,
    PRIMARY KEY (NúmeroRegisto),
    FOREIGN KEY (Instituicao_Nome) REFERENCES Instituição(Nome)

);

CREATE TABLE Instituição(
    Nome VARCHAR(50) NOT NULL,
    Endereço VARCHAR(50) NOT NULL,
    PRIMARY KEY (ID),
    UNIQUE (Nome)
);

CREATE TABLE Autor(
    email_Pessoa VARCHAR(30) NOT NULL REFERENCES Pessoa(email),
    PRIMARY KEY (email)

);

CREATE TABLE Pessoa(
    Nome VARCHAR(50) NOT NULL,
    email VARCHAR(60) NOT NULL,
    Instituicao_Nome VARCHAR(30) NOT NULL,

    FOREIGN KEY (Instituicao_Nome) REFERENCES Instituição(Nome),
    PRIMARY KEY (email)
);

CREATE TABLE Participante(
    DataInscrição DATE NOT NULL,
    Morada VARCHAR(50) NOT NULL,
    email_Pessoa VARCHAR(30) NOT NULL REFERENCES Pessoa(email),
   
    PRIMARY KEY (email_Pessoa)
);

CREATE TABLE Estudante(
    email_Pessoa VARCHAR(30) NOT NULL REFERENCES Pessoa(email),
    Instituicao_Nome VARCHAR(30) NOT NULL,
    Comprovativo VARCHAR(50) NOT NULL,

    FOREIGN KEY (Instituicao_Nome) REFERENCES Instituição(Nome),
    PRIMARY KEY (email_Pessoa)
);

CREATE TABLE NaoEstudante(
    email_Pessoa VARCHAR(30) NOT NULL REFERENCES Pessoa(email),
    Referencia VARCHAR(100) NOT NULL,
    PRIMARY KEY (email_Pessoa)
);

CREATE TABLE possui(
    email_Pessoa VARCHAR(30) NOT NULL FOREIGN KEY REFERENCES Pessoa(email),
    NúmeroRegisto INTEGER NOT NULL FOREIGN KEY REFERENCES Artigo(NúmeroRegisto),
    PRIMARY KEY (email_Pessoa, NúmeroRegisto)

);

CREATE TABLE CertificaEstudante(
    Comprovativo VARCHAR(50) NOT NULL,
    email_Pessoa VARCHAR(30) NOT NULL FOREIGN KEY REFERENCES Pessoa(email),
    PRIMARY KEY (Comprovativo, email_Pessoa)
);

