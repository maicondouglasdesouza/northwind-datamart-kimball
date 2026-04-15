-- RELATÓRIO 1: FATURAMENTO TOTAL POR CATEGORIA
-- Objetivo: Identificar as categorias de maior impacto financeiro.

SELECT 
    p.categoria,
    SUM(f.quantidade) AS total_itens_vendidos,
    ROUND(SUM(f.valor_bruto), 2) AS faturamento_total
FROM dw_vendas.fato_vendas f
JOIN dw_vendas.dim_produto p ON f.sk_produto = p.sk_produto
GROUP BY p.categoria
ORDER BY faturamento_total DESC;

-- RELATÓRIO 2: TOP 5 PAÍSES EM VOLUME DE COMPRAS
-- Objetivo: Análise geográfica básica.

SELECT 
    c.pais,
    COUNT(DISTINCT f.numero_pedido) AS total_pedidos
FROM dw_vendas.fato_vendas f
JOIN dw_vendas.dim_cliente c ON f.sk_cliente = c.sk_cliente
GROUP BY c.pais
ORDER BY total_pedidos DESC
LIMIT 5;
