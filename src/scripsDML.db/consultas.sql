-- DML (manipulação dados)

SELECT * FROM clientes 
WHERE cidade = 'São Paulo';

SELECT pedido_id, data_pedido, valor
FROM pedidos 
ORDER BY data_pedido DESC;

SELECT cliente_id, nome, idade 
FROM clientes
WHERE idade BETWEEN 25 AND 35;

SELECT cliente_id, nome
FROM clientes
-- postgres ILIKE (case insensiive) LIKE (case sensitive)
WHERE nome LIKE 'A%';

SELECT SUM(valor) FROM pedidos WHERE cliente_id.pedido = cliente_id.clientes;

--consultas agragadas

--Calculo do valor total de pedidos para cada cliente
SELECT 
	c.nome AS nome_tabela_clientes,
	COALESCE(SUM(p.valor), 0) AS total_pedidos_clientes

FROM clientes c
LEFT JOIN
	pedidos p ON c.cliente_id = p.cliente_id

GROUP BY 
	c.nome,
	p.cliente_id;

--calculo media de idade de clientes por cidade
SELECT c.cidade AS cidade,    
	    AVG(idade) AS med_idade_clientes
	FROM
	clientes c
GROUP BY
	c.cidade;

--todos os pedidos junto com as informações dos clientes
SELECT *
FROM clientes c
INNER JOIN pedidos p
ON c.cliente_id = p.cliente_id;

--consulta que retorna todos os clientes e seus pedidos, incluindo clientes que não fizeram pedidos

SELECT *
FROM clientes c
LEFT JOIN pedidos p
ON c.cliente_id = p.cliente_id;


--consulta que retorna todos os produtos e seus itens pedidos, incluindo produtos que não foram pedidos (use RIGHT JOIN).

SELECT
	
* FROM  itens_pedidos t
RIGHT JOIN produtos c
ON t.produto_id = c.produto_id;

--
SELECT
	(c.preco * t.quantidade) AS valor_quant_prod_ped,
* FROM produtos c
RIGHT JOIN itens_pedidos t
ON c.produto_id = t.produto_id;

--UNION para combinar duas consultas: uma que retorna clientes de 'São Paulo' e outra que retorna clientes de 'Rio de Janeiro'
SELECT c.nome AS clientes_SP_e_RJ, c.cidade
	FROM clientes c 
	WHERE cidade = 'São Paulo'
UNION
SELECT c.nome AS clientes_SP_e_RJ, c.cidade
	FROM clientes c
	WHERE cidade = 'Rio de Janeiro'
GROUP BY 
c.nome,
c.cidade


--listas paginadas e ordenadas
--limit = quantidade de linhas a exibir por resultado
--offset = quantidade de linhas a serem puladas da tabela/reultado da query antes de iniciar a contagem do limit na página atual
----------ex: offset == 2*0 onde 2 é a quantidade de linhas puladas, 0 é a primeira pg, 1 é a segunda pg ...
----------explicação == página atual: (offset 2 * 0 exibe linhas 1, 2) (calculo: 2*0 = 0 "não há linhas puladas"), linhas da primeira pg: 1, 2.
-------------------- == página atual: (offset 2 * 1 exibe linhas 3, 4) (calculo: 2*1 = 2 "pula 2 linhas da tabela/resultado"), linhas da segunda pg: 3, 4.
-------------------- == página atual: (offset 2 * 2 exibe linhas 5, 6) (calculo: 2*2 = 4 "pula 4 linhas da tabela/resultado"), linhas da terceira pg: 5, 6.
 SELECT * 
	FROM clientes 
	ORDER BY nome 
	DESC LIMIT 2 
	OFFSET 2*0 ;

--caso não especifique ordenação, o limit traz a listagem por ordem id(ordem de cadastro)
SELECT * FROM produtos
LIMIT 5
--
SELECT * FROM produtos 
ORDER BY preco DESC
LIMIT 3
OFFSET 3*1 --SEGUNDA PG
--
SELECT * FROM produtos
ORDER BY preco ASC
LIMIT 2
OFFSET 2*0 --PRIMEIRA PG
--
SELECT * FROM produtos
ORDER BY preco ASC
OFFSET 2 --lista todos os produtos do preco menor para o maior a partir do terceiro menor preco da tabela



--between 
SELECT * FROM usuarios WHERE data_nascimento BETWEEN '2010-01-01' AND now()

-- soma os valores da coluna valor da tabela pedidos
SELECT SUM(valor) FROM pedidos;

-- resulta na média dos valores 
SELECT AVG(valor) FROM pedidos WHERE id IN (1,2,3); 

-- total de registros (ex-uso: paginacao) 
SELECT COUNT(*) FROM pedidos;

--retorna o registro com maior valor
SELECT MAX(valor) FROM pedidos;

--menor valor
SELECT MIN(valor) FROM pedidos;

--concatenar
SELECT CONCAT('O email de', nome, 'é', email) FROM usuarios;
SELECT UPPER(CONCAT(''O email de', nome, 'é', email')) FROM usuarios;
       LOWER

-- variavel(tamanho de um texto definido) FROM(a partir do caracter 1) FOR(quantidade de caractere de retorno))
SELECT SUBSTRING(nome FROM 1 FOR 3) FROM usuarios; --nom

--extrai uma subparte de uma data
SELECT date_part('year', data_nascimento) FROM usuarios;
        month                       
        day

--diferença entre duas datas
SELECT AGE(NOW(), data_nascimento) FROM usuarios;

--filtra o/os dados
SELECT * FROM usuarios WHERE id IN (4,6);
-- SELECT SUM(valor) * FROM pedidos where cliente_id in ()