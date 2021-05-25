-- Conhecendo a tabela
SELECT * FROM case_zax

sp_help case_zax

-- Conferindo os tipos de informações na coluna Nomes_De_medida
SELECT Nomes_De_medida,
COUNT (*) AS qtde
FROM case_zax
GROUP BY Nomes_de_medida

-- Verificar os anos compreendidos no Dataset
SELECT DISTINCT YEAR(Data_pedido) as ano
FROM case_zax

-- criar view com numero do pedido e qtde de lojas por cliente
CREATE VIEW vw_qtde_lojas
AS
SELECT Código_do_cliente, numero_pedido, Valores_de_medida as qtde_lojas_pedido 
FROM case_zax
WHERE Nomes_de_medida = '# de lojas no pedido'

SELECT * FROM vw_qtde_lojas

-- criar view para Preço Médio
CREATE VIEW vw_preco_medio
AS
SELECT Código_do_cliente, numero_pedido, Valores_de_medida AS Preco_medio 
FROM case_zax
WHERE Nomes_de_medida = 'Preço médio'

SELECT * FROM vw_preco_medio

-- criar view para Qtde_itens
CREATE VIEW vw_qtde_itens
AS
SELECT Código_do_cliente, numero_pedido, Valores_de_medida as Qtde_itens
FROM case_zax
WHERE Nomes_de_medida = 'Quantidade'

SELECT * FROM vw_qtde_itens

-- Criar view com JOIN entre as tabelas para condensar as informações.

CREATE VIEW new_dados
AS
SELECT DISTINCT g.Código_do_cliente, 
	Cidade, 
	Estado, 
	CONVERT(VARCHAR, Data_pedido, 103) as Data_pedido,
	l.Numero_Pedido,
	Metodo_De_Pagamento,
	Tipo_Envio,
	l.qtde_lojas_pedido,
	p.Preco_medio,
	i.Qtde_itens
FROM case_zax g
JOIN vw_qtde_lojas l ON
g.Numero_Pedido = l.numero_pedido
JOIN vw_preco_medio p ON
p.numero_pedido = l.numero_pedido
JOIN vw_qtde_itens i ON
i.numero_pedido = p.numero_pedido

select * from new_dados


-- Verificar quantidade de pedidos por cliente para saber quem comprou mais vezes
select Código_do_cliente, Cidade, Estado,
count (*) as total_pedidos
from new_dados
group by Código_do_cliente, Cidade, Estado
order by total_pedidos desc

-- Conferir os pedidos do cliente de Cód 6 e porque está dando erro no PBI
SELECT * FROM new_dados
WHERE 
Código_do_cliente = '6'

-- Excluir no PBI a linha que está dando erro. Não irá afetar a análise. Continuar a análise pelo PBI.