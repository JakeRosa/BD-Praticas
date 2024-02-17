CREATE TABLE Produto(
    ProdCodigo INTEGER NOT NULL,
    IVA FLOAT NOT NULL,
    Nome VARCHAR(50) NOT NULL,
    Preco FLOAT NOT NULL,
    Produto_NumUnidades INTEGER NOT NULL,
    PRIMARY KEY (ProdCodigo)
);

CREATE TABLE Contem(
    Produto_ProdCodigo INTEGER NOT NULL,
    Encomenda_NumEncomenda INTEGER NOT NULL,
    N INTEGER NOT NULL,
    PRIMARY KEY (Produto_ProdCodigo, Encomenda_EncomendaCodigo),
    FOREIGN KEY (Produto_ProdCodigo) REFERENCES Produto(ProdCodigo),
    FOREIGN KEY (Encomenda_NumEncomenda) REFERENCES Encomenda(NumEncomenda)
);

CREATE TABLE Encomenda(
    NumEncomenda INTEGER NOT NULL,
    Data DATE NOT NULL,
    Fornecedor_NIF INTEGER NOT NULL,
    Fornecedor_Nome VARCHAR(50) NOT NULL,
    PRIMARY KEY (NumEncomenda),
    FOREIGN KEY (Cliente_NIF) REFERENCES Fornecedor(NIF),
    FOREIGN KEY (Fornecedor_Nome) REFERENCES Fornecedor(Nome)
);

CREATE TABLE Fornecedor(
    NIF INTEGER NOT NULL,
    FornecedorNome VARCHAR(50) NOT NULL,
    Endereco VARCHAR(50) NOT NULL,
    FAX VARCHAR(30),
    TipoFCodigo INTEGER NOT NULL,
    PRIMARY KEY (NIF),
    FOREIGN KEY (TipoFCodigo) REFERENCES TipoFornecedor(Codigo)
);

CREATE TABLE TipoFornecedor(
    Codigo INTEGER NOT NULL,
    Designacao VARCHAR(50) NOT NULL,
    PRIMARY KEY (Codigo)
);