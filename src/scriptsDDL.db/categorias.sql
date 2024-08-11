CREATE TABLE categorias (
     categoria_id SERIAL PRIMARY KEY,
     nome_categoria VARCHAR(50);
)

ALTER TABLE produtos add column categoria_id REFERENCES
