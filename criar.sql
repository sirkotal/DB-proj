PRAGMA foreign_keys = on;
BEGIN TRANSACTION;

-- Table: Equipa
DROP TABLE IF EXISTS Equipa;

CREATE TABLE Equipa (
    idEquipa       INTEGER,
    nome           VARCHAR(65535)    CONSTRAINT unique_nome UNIQUE CONSTRAINT nome_nnull NOT NULL,
    treinador      TEXT    CONSTRAINT unique_treinador UNIQUE CONSTRAINT treinador_nnull NOT NULL,
    pais           TEXT    CONSTRAINT pais_nnull NOT NULL,
    ranking        INTEGER CONSTRAINT unique_ranking UNIQUE CONSTRAINT ranking_nnull NOT NULL,
    apuramento     BOOLEAN,
    PRIMARY KEY(idEquipa, nome)
);


-- Table: Estádio
DROP TABLE IF EXISTS Estadio;

CREATE TABLE Estadio (
    idEstadio  INTEGER PRIMARY KEY,
    nomeEquipa   VARCHAR(65535) CONSTRAINT fk_nomeEquipa REFERENCES Equipa (nome) ON DELETE CASCADE 
                                                                      ON UPDATE CASCADE,
    nome       TEXT CONSTRAINT nome_nnull NOT NULL,
    cidade     TEXT CONSTRAINT cidade_nnull NOT NULL,
    capacidade INTEGER CONSTRAINT capacidade_nnull NOT NULL
);


-- Table: Jogador
DROP TABLE IF EXISTS Jogador;

CREATE TABLE Jogador (
    idJogador       INTEGER PRIMARY KEY,
    nome            TEXT CONSTRAINT nome_nnull NOT NULL,
    idade           INTEGER CONSTRAINT idade_nnull NOT NULL,
    país            TEXT CONSTRAINT país_nnull NOT NULL,
    posicao         TEXT CONSTRAINT posicao_nnull NOT NULL,
    clube           VARCHAR(65535) CONSTRAINT fk_clube REFERENCES Equipa (nome) ON DELETE CASCADE 
                                                                                ON UPDATE CASCADE
);

-- Table: Arbitro
DROP TABLE IF EXISTS Arbitro;

CREATE TABLE Arbitro (
    idArbitro       INTEGER PRIMARY KEY,
    nome            TEXT CONSTRAINT nome_nnull NOT NULL,
    país            TEXT CONSTRAINT país_nnull NOT NULL
);

-- Table: Fase
DROP TABLE IF EXISTS Fase;

CREATE TABLE Fase (
    idFase        INTEGER,
    nomeFase      VARCHAR(2) CONSTRAINT nomeFase_unico UNIQUE CONSTRAINT check_fase CHECK ( (nomeFase = "PE" OR 
                                                                                                      nomeFase = "FG" OR 
                                                                                                      nomeFase = "OF" OR 
                                                                                                      nomeFase = "QF" OR 
                                                                                                      nomeFase = "MF" OR 
                                                                                                      nomeFase = "FI") ),
    dataInicio   DATE    CONSTRAINT dataInicio_nnull NOT NULL,
    dataFim      DATE    CONSTRAINT dataFim_nnull NOT NULL,
    PRIMARY KEY(idFase, nomeFase),
    CONSTRAINT check_fase_datas CHECK ( ( dataInicio <= dataFim  ) )
);

-- Table: Grupo
DROP TABLE IF EXISTS Grupo;

CREATE TABLE Grupo (
    codGrupo VARCHAR(1),
    equipa1 VARCHAR(65535) CONSTRAINT fk_equipa1 REFERENCES Equipa (nome) ON DELETE CASCADE 
    ON UPDATE CASCADE,
    equipa2 VARCHAR(65535) CONSTRAINT fk_equipa2 REFERENCES Equipa (nome) ON DELETE CASCADE 
    ON UPDATE CASCADE,
    equipa3 VARCHAR(65535) CONSTRAINT fk_equipa3 REFERENCES Equipa (nome) ON DELETE CASCADE 
    ON UPDATE CASCADE,
    equipa4 VARCHAR(65535) CONSTRAINT fk_equipa4 REFERENCES Equipa (nome) ON DELETE CASCADE 
    ON UPDATE CASCADE,
    PRIMARY KEY(codGrupo, equipa1, equipa2, equipa3, equipa4),
    CONSTRAINT check_codGrupo CHECK ( (codGrupo = "A" OR 
                                      codGrupo = "B" OR 
                                      codGrupo = "C" OR 
                                      codGrupo = "D" OR 
                                      codGrupo = "E" OR 
                                      codGrupo = "F" OR
                                      codGrupo = "G" OR
                                      codGrupo = "H") )
);


-- Table: Jogo
DROP TABLE IF EXISTS Jogo;

CREATE TABLE Jogo (
    idJogo    INTEGER PRIMARY KEY,
    faseJogo  VARCHAR(2) CONSTRAINT fk_fase REFERENCES Fase (nomeFase) ON DELETE CASCADE 
                                                                       ON UPDATE CASCADE,
    dataJogo     DATE CONSTRAINT data_nnull NOT NULL,
    grupoJogo    VARCHAR(1) CONSTRAINT check_grupo CHECK ( (grupoJogo = "A" OR 
                                                            grupoJogo = "B" OR 
                                                            grupoJogo = "C" OR 
                                                            grupoJogo = "D" OR 
                                                            grupoJogo = "E" OR 
                                                            grupoJogo = "F" OR
                                                            grupoJogo = "G" OR
                                                            grupoJogo = "H") ),
    equipaCasa VARCHAR(65535) CONSTRAINT fk_equipaCasa REFERENCES Equipa (nome) ON DELETE CASCADE 
    ON UPDATE CASCADE,
    equipaFora VARCHAR(65535) CONSTRAINT fk_equipaFora REFERENCES Equipa (nome) ON DELETE CASCADE 
    ON UPDATE CASCADE,
    resultado TEXT CONSTRAINT resultado_nnull NOT NULL
);


-- Table: Evento
DROP TABLE IF EXISTS Evento;

CREATE TABLE Evento (
    idEvento INTEGER PRIMARY KEY,
    idJogo INTEGER CONSTRAINT fk_evento_idJogo REFERENCES Jogo (idJogo) ON DELETE CASCADE
                                                                        ON UPDATE CASCADE,
    minuto INTEGER CONSTRAINT minuto_nnull NOT NULL CONSTRAINT minuto_limite CHECK (((minuto > 0) AND (minuto <= 120)))
);

-- Table: Golo
DROP TABLE IF EXISTS Golo;

CREATE TABLE Golo (
    idGolo INTEGER PRIMARY KEY,
    idEvento INTEGER CONSTRAINT fk_golo_idEvento REFERENCES Evento (idEvento) ON DELETE CASCADE
                                                                              ON UPDATE CASCADE,
    idJogador INTEGER CONSTRAINT idJogador_nnull NOT NULL 
    CONSTRAINT fk_evento_idJogador REFERENCES Jogador (idJogador) ON DELETE CASCADE
                                                                  ON UPDATE CASCADE
);

-- Table: Falta
DROP TABLE IF EXISTS Falta;

CREATE TABLE Falta (
    idFalta INTEGER PRIMARY KEY,
    idEvento INTEGER CONSTRAINT fk_falta_idEvento REFERENCES Evento (idEvento) ON DELETE CASCADE
                                                                               ON UPDATE CASCADE,
    idJogador INTEGER CONSTRAINT idJogador_nnull NOT NULL 
    CONSTRAINT fk_evento_idJogador REFERENCES Jogador (idJogador) ON DELETE CASCADE
                                                                  ON UPDATE CASCADE,
    cartao CHAR(1) CONSTRAINT check_cor CHECK ( (cartao = "Y" OR 
                                                 cartao = "R") )
);

-- Table: Substituicao
DROP TABLE IF EXISTS Substituicao;

CREATE TABLE Substituicao (
    idSubs INTEGER PRIMARY KEY,
    idEvento INTEGER CONSTRAINT fk_subs_idEvento REFERENCES Evento (idEvento) ON DELETE CASCADE
                                                                              ON UPDATE CASCADE,
    idJogadorEntra INTEGER CONSTRAINT idJogadorEntra_nnull NOT NULL 
    CONSTRAINT fk_subs_idJogadorEntra REFERENCES Jogador (idJogador) ON DELETE CASCADE
                                                                     ON UPDATE CASCADE,
    idJogadorSai INTEGER CONSTRAINT idJogadorSai_nnull NOT NULL 
    CONSTRAINT fk_subs_idJogadorSai REFERENCES Jogador (idJogador) ON DELETE CASCADE
                                                                   ON UPDATE CASCADE
);

-- Table: Prolongamento
DROP TABLE IF EXISTS Prolongamento;

CREATE TABLE Prolongamento (
    idProlongamento INTEGER PRIMARY KEY,
    idEvento INTEGER CONSTRAINT fk_prol_idEvento REFERENCES Evento (idEvento) ON DELETE CASCADE
                                                                              ON UPDATE CASCADE,
    resultadoInicial TEXT CONSTRAINT resultadoInicial_nnull NOT NULL,
    resultadoFinal   TEXT CONSTRAINT resultadoFinal_nnull NOT NULL 
);

-- Table: Penaltis
DROP TABLE IF EXISTS Penaltis;

CREATE TABLE Penaltis (
    idPenaltis INTEGER PRIMARY KEY,
    idEvento INTEGER CONSTRAINT fk_prol_idEvento REFERENCES Evento (idEvento) ON DELETE CASCADE
                                                                              ON UPDATE CASCADE,
    resultadoJogo       TEXT CONSTRAINT resultadoJogo_nnull NOT NULL,
    resultadoPenaltis   TEXT CONSTRAINT resultadoPenaltis_nnull NOT NULL 
);

-- Table: Resultados
DROP TABLE IF EXISTS Resultados;

CREATE TABLE Resultados (
    idResultado    INTEGER PRIMARY KEY,        
    nomeEquipa VARCHAR(65535) CONSTRAINT fk_resultados_nomeEquipa REFERENCES Equipa (nome) ON DELETE CASCADE
                                                                                 ON UPDATE CASCADE,
    faseAtual      VARCHAR(2)    CONSTRAINT fk_resultados_fase REFERENCES Fase (nomeFase) ON DELETE CASCADE
                                                                                      ON UPDATE CASCADE,
    pontos          INTEGER,
    jogosGanhos     INTEGER    CONSTRAINT jogosGanhos_nnull NOT NULL,
    jogosEmpatados  INTEGER    CONSTRAINT jogosEmpatados_nnull NOT NULL,
    jogosPerdidos   INTEGER    CONSTRAINT jogosPerdidos_nnull NOT NULL,
    golosMarcados   INTEGER    CONSTRAINT golosMarcados_nnull NOT NULL,
    golosSofridos   INTEGER    CONSTRAINT golosSofridos_nnull NOT NULL,
    campeao         VARCHAR(1)    CONSTRAINT check_campeao CHECK ( (campeao = "N" OR campeao = "Y") )
);

COMMIT TRANSACTION;
PRAGMA foreign_keys = on;