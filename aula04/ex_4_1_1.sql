CREATE TABLE Cliente(
    NIF INTEGER NOT NULL,
    nome VARCHAR(50) NOT NULL,
    endereco VARCHAR(50) NOT NULL,
    num_carta DATE NOT NULL,
    PRIMARY KEY (NIF)
);


CREATE TABLE Aluguer(
    numero INTEGER NOT NULL,
    duracao INTEGER NOT NULL,
    data DATE NOT NULL,
    Cliente_NIF INTEGER NOT NULL,
    Balcao_numero INTEGER NOT NULL,
    Veiculo_matricula VARCHAR(10) NOT NULL,
    PRIMARY KEY (numero),
    FOREIGN KEY (Cliente_NIF) REFERENCES Cliente(NIF),
    FOREIGN KEY (Balcao_numero) REFERENCES Balcao(numero),
    FOREIGN KEY (Veiculo_matricula) REFERENCES Veiculo(matricula)
);

CREATE TABLE Veículo(
    matricula VARCHAR(10) NOT NULL,
    endereco VARCHAR(50) NOT NULL,
    marca VARCHAR(255) NOT NULL,
    codigo VARCHAR(50) NOT NULL,
    Tipo_Veiculo_codigo VARCHAR(32) NOT NULL,
    PRIMARY KEY (matricula),
    FOREIGN KEY (Tipo_Veiculo_codigo) REFERENCES Tipo_Veiculo(codigo)
);


CREATE TABLE Tipo_Veiculo(
    codigo VARCHAR(32) NOT NULL,
    arcondicionado BIT NOT NULL,
    designacao VARCHAR(255) NOT NULL,
    PRIMARY KEY (codigo)
);

CREATE TABLE Balcao(
    numero INTEGER NOT NULL,
    nome VARCHAR(50) NOT NULL,
    endereco VARCHAR(50) NOT NULL,
    PRIMARY KEY (numero)
);

CREATE TABLE Pesado(
    codigo VARCHAR(32) NOT NULL REFERENCES Tipo_Veiculo(codigo),
    peso FLOAT NOT NULL,
    passageiros INTEGER NOT NULL,
    PRIMARY KEY (codigo),
);

CREATE TABLE Ligeiro(
    numluagres INTEGER NOT NULL,
    portas INTEGER NOT NULL,
    combustivel VARCHAR(32) NOT NULL,
    codigo VARCHAR(32) NOT NULL REFERENCES Tipo_Veiculo(codigo),
    PRIMARY KEY (codigo)

);

CREATE TABLE Similaridade(
    codigo1 VARCHAR(32) NOT NULL,
    codigo2 VARCHAR(32) NOT NULL,
    PRIMARY KEY (codigo1, codigo2),
    FOREIGN KEY (codigo1) REFERENCES Tipo_Veiculo(codigo),
    FOREIGN KEY (codigo2) REFERENCES Tipo_Veiculo(codigo),
);