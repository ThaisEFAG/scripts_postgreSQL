INSERT INTO clientes (nome, cidade, idade)
VALUES
('Lucas Lime', 'Salvador', 29);

UPDATE clientes 
SET cidade = 'Fortaleza' 
WHERE cliente_id = 3;

-- deleção física ou definitiva (o valor deixa de existir no db)
DELETE pedidos 
WHERE valor < 10;