CREATE TABLE Estado (
    ID INT NOT NULL AUTO_INCREMENT,
    Nome VARCHAR(50) NOT NULL,
    UF CHAR(2) NOT NULL,
    PRIMARY KEY (ID)
);

-- Tabela Municipio
CREATE TABLE Municipio (
    ID INT NOT NULL AUTO_INCREMENT,
    Estado_ID INT NOT NULL,
    Nome VARCHAR(80) NOT NULL,
    CodIBGE INT NOT NULL,
    PRIMARY KEY (ID),
    CONSTRAINT fk_Municipio_Estado
        FOREIGN KEY (Estado_ID)
        REFERENCES Estado(ID)
);

-- Tabela Cliente
CREATE TABLE Cliente (
    ID INT NOT NULL AUTO_INCREMENT,
    Nome VARCHAR(80) NOT NULL,
    CPF CHAR(11) NOT NULL,
    Celular CHAR(11) NOT NULL,
    EndLogradouro VARCHAR(100) NOT NULL,
    EndNumero VARCHAR(10) NOT NULL,
    EndMunicipio INT NOT NULL,
    EndCEP CHAR(8) NOT NULL,
    Municipio_ID INT NOT NULL,
    PRIMARY KEY (ID),
    CONSTRAINT fk_Cliente_Municipio
        FOREIGN KEY (Municipio_ID)
        REFERENCES Municipio(ID)
);

-- Tabela ContaReceber
CREATE TABLE ContaReceber (
    ID INT NOT NULL AUTO_INCREMENT,
    Cliente_ID INT NOT NULL,
    FaturaVendaID INT NOT NULL,
    DataConta DATE NOT NULL,
    DataVencimento DATE NOT NULL,
    Valor DECIMAL(18,2) NOT NULL,
    Situacao ENUM('1', '2', '3') NOT NULL,
    PRIMARY KEY (ID),
    CONSTRAINT fk_ContaReceber_Cliente
        FOREIGN KEY (Cliente_ID)
        REFERENCES Cliente(ID)
);


-- Inserindo dados na tabela Estado
INSERT INTO Estado (Nome, UF) VALUES
('Sao Paulo', 'SP'),
('Rio de Janeiro', 'RJ'),
('Minas Gerais', 'MG');

-- Inserindo dados na tabela Municipio
INSERT INTO Municipio
(Estado_ID, Nome, CodIBGE) VALUES
(1, 'Campinas', 3509502),
(2, 'Niteroi', 3303302),
(3, 'Belo Horizonte', 3106200);

-- Inserindo dados na tabela Cliente
INSERT INTO Cliente
(Nome, CPF, Celular, EndLogradouro,
 EndNumero, EndMunicipio, EndCEP, Municipio_ID)
VALUES
('Joao Silva', '12345678901', '11987654321',
 'Rua das Flores', '100', 3509502,
 '13010000', 1),

('Maria Oliveira', '23456789012', '21987654321',
 'Avenida Brasil', '250', 3303302,
 '24020000', 2),

('Carlos Santos', '34567890123', '31987654321',
 'Rua Central', '300', 3106200,
 '30110000', 3);

-- Inserindo dados na tabela ContaReceber
INSERT INTO ContaReceber
(Cliente_ID, FaturaVendaID, DataConta,
 DataVencimento, Valor, Situacao)
VALUES
(1, 1001, '2026-10-01', '2026-11-20', 150.00, '1'),

(2, 1002, '2026-10-05', '2026-11-25', 250.00, '3'),

(3, 1003, '2026-10-10', '2026-11-30', 350.00, '1');


-- Criacao da VIEW de contas nao pagas
CREATE VIEW vw_ContasNaoPagas AS

SELECT
    CR.ID AS ID_Conta,
    C.Nome AS Nome_Cliente,
    C.CPF AS CPF_Cliente,
    CR.DataVencimento AS Data_Vencimento,
    CR.Valor AS Valor_Conta

FROM ContaReceber CR

INNER JOIN Cliente C
    ON CR.Cliente_ID = C.ID

WHERE CR.Situacao = '1';

-- Consultando a VIEW
SELECT * FROM vw_ContasNaoPagas;
