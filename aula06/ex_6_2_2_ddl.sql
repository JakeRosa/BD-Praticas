CREATE TABLE produto(
    codigo INTEGER NOT NULL,
    iva FLOAT NOT NULL,
    nome VARCHAR(50) NOT NULL,
    preco FLOAT NOT NULL,
    unidades INTEGER NOT NULL,
    PRIMARY KEY (codigo)
);

CREATE TABLE tipo_fornecedor(
    codigo INTEGER NOT NULL,
    designacao VARCHAR(50) NOT NULL,
    PRIMARY KEY (codigo)
);

CREATE TABLE fornecedor(
    nif INTEGER NOT NULL,
    nome VARCHAR(50) NOT NULL,
    endereco VARCHAR(50),
    fax VARCHAR(30) NOT NULL,
    tipo INTEGER NOT NULL,
    condpag INTEGER NOT NULL,
    PRIMARY KEY (nif),
    FOREIGN KEY (tipo) REFERENCES tipo_fornecedor(codigo)
);

CREATE TABLE encomenda(
    numero INTEGER NOT NULL,
    [data] DATE NOT NULL,
    fornecedor INTEGER NOT NULL,
    PRIMARY KEY (numero),
    FOREIGN KEY (fornecedor) REFERENCES fornecedor(nif),
);

CREATE TABLE item(
    numEnc INTEGER NOT NULL,
    codProd INTEGER NOT NULL,
    unidades INTEGER NOT NULL,
    PRIMARY KEY (numEnc, codProd),
    FOREIGN KEY (numEnc) REFERENCES encomenda(numero),
    FOREIGN KEY (codProd) REFERENCES produto(codigo),
);