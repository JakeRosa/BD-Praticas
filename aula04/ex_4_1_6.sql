CREATE TABLE PESSOA(
    NumCartaoCidadao    INT             NOT NULL,
    Nome                VARCHAR(64)     NOT NULL,
    Morada              VARCHAR(64)     NOT NULL,
    DataNascimento      DATE            NOT NULL,
    PRIMARY KEY (NumCartaoCidadao),
    UNIQUE (Morada),
);

CREATE TABLE PROFESSOR(
    NumCartaoCidadao        INT             NOT NULL,
    NumFuncionario          INT             NOT NULL,
    ProfEmail               VARCHAR(64)     NOT NULL,
    ProfContatoTelefonico   INT             NOT NULL,
    PRIMARY KEY (NumCartaoCidadao),
	FOREIGN KEY (NumCartaoCidadao) REFERENCES PESSOA(NumCartaoCidadao),
    UNIQUE (NumFuncionario, ProfEmail, ProfContatoTelefonico),
);

CREATE TABLE TURMA(
    TurmaID             INT                 NOT NULL,
    CLasse              VARCHAR(10)         NOT NULL,
    TurmaDesignacao     VARCHAR(100)        NOT NULL,
    AnoLetivo           VARCHAR(9)          NOT NULL,
    NumMaxAlunos        INT                 NOT NULL,
	Prof_NumCartaoCidadao	INT				NOT NULL,
    PRIMARY KEY (TurmaID),
    UNIQUE (TurmaDesignacao),
	FOREIGN KEY(Prof_NumCartaoCidadao) REFERENCES PROFESSOR(NumCartaoCidadao),
);

CREATE TABLE ALUNO(
    NumCartaoCidadao    INT     NOT NULL,
    FK_TurmaID             INT     NOT NULL,
    PRIMARY KEY (NumCartaoCidadao),
	FOREIGN KEY (NumCartaoCidadao) REFERENCES PESSOA(NumCartaoCidadao),
    FOREIGN KEY (FK_TurmaID) REFERENCES Turma(TurmaID),
);

CREATE TABLE ATIVIDADE(
    AtividadeID             INT             NOT NULL,
    AtividadeDesignacao     VARCHAR(100)    NOT NULL,
    Custo                   INT             NOT NULL,
    PRIMARY KEY (AtividadeID),
    UNIQUE (AtividadeDesignacao),
);

CREATE TABLE ALUNO_FREQUENTA(
    FK_NumCartaoCidadao      INT     NOT NULL,
    FK_AtividadeID       INT     NOT NULL,
    PRIMARY KEY (FK_NumCartaoCidadao, FK_AtividadeID),
    FOREIGN KEY (FK_NumCartaoCidadao) REFERENCES ALUNO(NumCartaoCidadao),
    FOREIGN KEY (FK_AtividadeID) REFERENCES ATIVIDADE(AtividadeID),
);

CREATE TABLE TURMA_FREQUENTA(
    FK_TurmaID           INT     NOT NULL,
    FK_AtividadeID   INT     NOT NULL,
    PRIMARY KEY (FK_TurmaID, FK_AtividadeID),
    FOREIGN KEY (FK_TurmaID) REFERENCES TURMA(TurmaID),
    FOREIGN KEY (FK_AtividadeID) REFERENCES ATIVIDADE(AtividadeID),
);

CREATE TABLE RESPONSAVEL_LEVANTAMENTO(
    NumCartaoCidadao        INT             NOT NULL,
    RespContatoTelefonico   INT             NOT NULL,
    RespEmail               VARCHAR(64)     NOT NULL,
    PRIMARY KEY (NumCartaoCidadao),
	FOREIGN KEY (NumCartaoCidadao) REFERENCES PESSOA(NumCartaoCidadao),
    UNIQUE (RespContatoTelefonico, RespEmail),
);

CREATE TABLE ENCARREGADO_EDUCACAO(
    NumCartaoCidadao        INT     NOT NULL,
    PRIMARY KEY (NumCartaoCidadao),
	FOREIGN KEY (NumCartaoCidadao) REFERENCES RESPONSAVEL_LEVANTAMENTO(NumCartaoCidadao),
);