CREATE DATABASE longa_vida
USE longa_vida

CREATE TABLE plano (
    Numero CHAR(2) PRIMARY KEY,
    Descricao CHAR(30),
    Valor DECIMAL(10, 2)
);

INSERT INTO plano (Numero, Descricao, Valor) VALUES
('B1', 'Plano Basico 1', 100.00),
('B2', 'Plano Basico 2', 120.00),
('B3', 'Plano Basico 3', 130.00),
('E1', 'Plano Executivo 1', 200.00),
('E2', 'Plano Executivo 2', 220.00),
('E3', 'Plano Executivo 3', 240.00),
('M1', 'Plano Master 1', 300.00),
('M2', 'Plano Master 2', 320.00),
('M3', 'Plano Master 3', 340.00);

CREATE TABLE associado (
    Plano CHAR(2),
    Nome CHAR(40) PRIMARY KEY,
    Endereco CHAR(35),
    Cidade CHAR(20),
    Estado CHAR(2),
    CEP CHAR(9),
    FOREIGN KEY (Plano) REFERENCES plano(Numero)
);

INSERT INTO associado (Plano, Nome, Endereco, Cidade, Estado, CEP) VALUES
('B1', 'JOAO DA SILVA', 'Rua A', 'SÃO PAULO', 'SP', '12345000'),
('B2', 'MARIA DE OLIVEIRA', 'Rua B', 'DIADEMA', 'SP', '12346000'),
('M1', 'CARLOS ALMEIDA', 'Rua C', 'BARUERI', 'SP', '12347000');

SELECT associado.Nome, associado.Plano, plano.Descricao, plano.Valor
FROM associado
JOIN plano ON associado.Plano = plano.Numero;

SELECT COUNT(*) AS Quantidade
FROM associado
WHERE Plano = 'B1';

SELECT associado.Nome, associado.Plano, plano.Valor
FROM associado
JOIN plano ON associado.Plano = plano.Numero;

SELECT Nome
FROM associado
WHERE Cidade IN ('COTIA', 'DIADEMA');

SELECT associado.Nome, associado.Plano, plano.Valor
FROM associado
JOIN plano ON associado.Plano = plano.Numero
WHERE associado.Cidade = 'BARUERI' AND associado.Plano = 'M1';

SELECT associado.Nome, associado.Plano, plano.Valor
FROM associado
JOIN plano ON associado.Plano = plano.Numero
WHERE associado.Cidade = 'SÃO PAULO';

SELECT *
FROM associado
JOIN plano ON associado.Plano = plano.Numero
WHERE associado.Nome LIKE '%SILVA%';

UPDATE plano
SET Valor = CASE
    WHEN Descricao LIKE 'Plano Basico%' THEN Valor * 1.10
    WHEN Descricao LIKE 'Plano Executivo%' THEN Valor * 1.05
    WHEN Descricao LIKE 'Plano Master%' THEN Valor * 1.03
END;

UPDATE associado
SET Plano = 'E3'
WHERE Nome = 'PEDRO JOSE DE OLIVEIRA';

SELECT COUNT(*) AS Quantidade
FROM associado
WHERE Plano = 'E3';

SELECT associado.Nome, plano.Valor
FROM associado
JOIN plano ON associado.Plano = plano.Numero
WHERE associado.Plano IN ('B1', 'E1', 'M1');

SELECT Nome
FROM associado
JOIN plano ON associado.Plano = plano.Numero
WHERE plano.Descricao LIKE 'Plano Executivo%';

SELECT Nome
FROM associado
JOIN plano ON associado.Plano = plano.Numero
WHERE plano.Descricao LIKE 'Plano Basico%' OR plano.Descricao LIKE 'Plano Master%';

DELETE FROM associado
WHERE Cidade = 'SANTO ANDRE';

SELECT associado.Nome, associado.Plano, plano.Valor
FROM associado
JOIN plano ON associado.Plano = plano.Numero
WHERE associado.Cidade = 'SÃO PAULO' AND associado.Plano IN ('M2', 'M3')
ORDER BY associado.Nome;

SELECT *
FROM associado
JOIN plano ON associado.Plano = plano.Numero
ORDER BY plano.Descricao;

SELECT associado.Nome, associado.Plano, plano.Descricao
FROM associado
JOIN plano ON associado.Plano = plano.Numero
ORDER BY plano.Descricao ASC, associado.Nome DESC;

SELECT Nome
FROM associado
JOIN plano ON associado.Plano = plano.Numero
WHERE plano.Descricao NOT LIKE 'Plano Master%';

SELECT associado.Nome, plano.Descricao
FROM associado
JOIN plano ON associado.Plano = plano.Numero
ORDER BY associado.Nome;

SELECT *
FROM plano
WHERE Valor BETWEEN 300 AND 500;

SELECT associado.Nome, associado.Plano, plano.Descricao, plano.Valor
FROM associado
JOIN plano ON associado.Plano = plano.Numero
WHERE associado.Nome LIKE '%AMARAL%';

SELECT Nome
FROM associado
WHERE Cidade = 'DIADEMA';

UPDATE plano
SET Valor = Valor * 1.06
WHERE Descricao LIKE 'Plano Master%';

SELECT Nome
FROM associado
WHERE CEP LIKE '09%';




