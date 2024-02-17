CREATE TABLE MEDICO(
    Numero_de_ID        INT             NOT NULL,
    M_Nome                VARCHAR(64)     NOT NULL,
    Especialidade       VARCHAR(64)     NOT NULL,
    PRIMARY KEY (Numero_de_ID),
);

CREATE TABLE PACIENTE(
    Numero_de_utente    INT             NOT NULL,
    P_Nome                VARCHAR(64)     NOT NULL,
    P_Endereco            VARCHAR(64)     NOT NULL,
    Data_Nascimento     DATE            NOT NULL,
    PRIMARY KEY (Numero_de_utente),
);

CREATE TABLE FARMACIA(
    NIF         INT             NOT NULL,
    F_Nome      VARCHAR(64)     NOT NULL,
    F_Endereco  VARCHAR(64)     NOT NULL,
    F_Telefone  INT             NOT NULL,
    PRIMARY KEY (NIF),
);

CREATE TABLE VENDE(
    F_NIF               INT     NOT NULL,
    PRIMARY KEY (F_NIF),
    FOREIGN KEY (F_NIF) REFERENCES FARMACIA(NIF),
);

CREATE TABLE PRESCRICAO(
    Numero_unico        INT     NOT NULL,
    [Data]              DATE    NOT NULL,
    M_Numero_de_ID      INT     NOT NULL,
    P_Numero_de_utente  INT     NOT NULL,
    F_NIF               INT     NOT NULL,
    PRIMARY KEY (Numero_unico),
    FOREIGN KEY (M_Numero_de_ID) REFERENCES MEDICO(Numero_de_ID),
    FOREIGN KEY (P_Numero_de_utente) REFERENCES PACIENTE(Numero_de_utente),
    FOREIGN KEY (F_NIF) REFERENCES FARMACIA(NIF),
);

CREATE TABLE CONTEM(
    Prescricao_Numero_unico     INT     NOT NULL,
    PRIMARY KEY (Prescricao_Numero_unico),
    FOREIGN KEY (Prescricao_Numero_unico) REFERENCES PRESCRICAO(Numero_unico),
);

CREATE TABLE COMPANHIA_FARMACEUTICA(
    Num_Registo_Nacional    INT             NOT NULL,
    CF_Nome                 VARCHAR(64)     NOT NULL,
    CF_Endereco             VARCHAR(64)     NOT NULL,
    CF_Telefone             INT             NOT NULL,
    PRIMARY KEY (Num_Registo_Nacional),
);

CREATE TABLE FARMACOS(
    Nome_Comercial              VARCHAR(64)         NOT NULL,
    Formula                     VARCHAR(1024)       NOT NULL,
    CF_Num_Registo_Nacional     INT                 NOT NULL,
    F_NIF                       INT                 NOT NULL,
    Prescricao_Numero_unico     INT                 NOT NULL,
    PRIMARY KEY (CF_Num_Registo_Nacional),
    FOREIGN KEY (CF_Num_Registo_Nacional) REFERENCES COMPANHIA_FARMACEUTICA(Num_Registo_Nacional),
    FOREIGN KEY (Prescricao_Numero_unico) REFERENCES PRESCRICAO(Numero_unico),
    FOREIGN KEY (F_NIF) REFERENCES FARMACIA(NIF),
);