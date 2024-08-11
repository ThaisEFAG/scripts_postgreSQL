-- DDL (s estrutura banco)

CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    cidade VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    data_nascimento DATE,
    ativo BOOLEAN DEFAULT true
);

    CREATE TABLE pedidos (
    id SERIAL PRIMARY KEY,
    usuario_id INT,
    data_pedido DATE,
    valor DECIMAL(10, 2),
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
    );

    ALTER TABLE usuarios ADD column telefone VARCHAR(20);

    ALTER TABLE usuarios rename TO users;

    ALTER TABLE pedidos DROP CONSTRAINT pedidos_usuarios_id_fkey;

    DROP TABLE usuarios;

    --soft delete - deleção lógica de dados(mantém a linha deletada com a data de exclusão do dado)
    ALTER TABLE usuarios ADD COLLUMN data_delecao date default
    UPDATE usuarios SET data_delecao = now() where id = ?
