create database industria;
use industria;
CREATE TABLE Departamento (
    departamento_numero INT PRIMARY KEY,
    setor VARCHAR(100)
);

CREATE TABLE Funcionario (
    funcionario_numero INT PRIMARY KEY,
    salario DECIMAL(10, 2),
    telefone VARCHAR(15),
    departamento_numero INT,
    FOREIGN KEY (departamento_numero) REFERENCES Departamento(departamento_numero)
);

CREATE TABLE Projeto (
    projeto_numero INT PRIMARY KEY,
    orcamento DECIMAL(15, 2)
);

CREATE TABLE Fornecedor (
    fornecedor_numero INT PRIMARY KEY,
    endereco VARCHAR(200)
);

CREATE TABLE Peca (
    peca_numero INT PRIMARY KEY,
    peso DECIMAL(10, 2),
    cor VARCHAR(50)
);

CREATE TABLE Deposito (
    deposito_numero INT PRIMARY KEY,
    endereco VARCHAR(200)
);

CREATE TABLE Funcionario_Projeto (
    funcionario_numero INT,
    projeto_numero INT,
    data_inicio DATE,
    horas_trabalhadas DECIMAL(5, 2),
    PRIMARY KEY (funcionario_numero, projeto_numero),
    FOREIGN KEY (funcionario_numero) REFERENCES Funcionario(funcionario_numero),
    FOREIGN KEY (projeto_numero) REFERENCES Projeto(projeto_numero)
);

CREATE TABLE Projeto_Fornecedor (
    projeto_numero INT,
    fornecedor_numero INT,
    PRIMARY KEY (projeto_numero, fornecedor_numero),
    FOREIGN KEY (projeto_numero) REFERENCES Projeto(projeto_numero),
    FOREIGN KEY (fornecedor_numero) REFERENCES Fornecedor(fornecedor_numero)
);

CREATE TABLE Peca_Fornecedor (
    peca_numero INT,
    fornecedor_numero INT,
    PRIMARY KEY (peca_numero, fornecedor_numero),
    FOREIGN KEY (peca_numero) REFERENCES Peca(peca_numero),
    FOREIGN KEY (fornecedor_numero) REFERENCES Fornecedor(fornecedor_numero)
);

CREATE TABLE Peca_Projeto (
    peca_numero INT,
    projeto_numero INT,
    PRIMARY KEY (peca_numero, projeto_numero),
    FOREIGN KEY (peca_numero) REFERENCES Peca(peca_numero),
    FOREIGN KEY (projeto_numero) REFERENCES Projeto(projeto_numero)
);

CREATE TABLE Deposito_Peca (
    deposito_numero INT,
    peca_numero INT,
    PRIMARY KEY (deposito_numero, peca_numero),
    FOREIGN KEY (deposito_numero) REFERENCES Deposito(deposito_numero),
    FOREIGN KEY (peca_numero) REFERENCES Peca(peca_numero)
);
