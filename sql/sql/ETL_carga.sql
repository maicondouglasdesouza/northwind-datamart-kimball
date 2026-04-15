-- CARGA DIM_DATA
INSERT INTO dw_vendas.dim_data (sk_data, data_completa, ano, mes, dia_semana)
SELECT DISTINCT 
    CAST(TO_CHAR(order_date, 'YYYYMMDD') AS INTEGER), order_date,
    EXTRACT(YEAR FROM order_date), EXTRACT(MONTH FROM order_date), TO_CHAR(order_date, 'Day')
FROM public.orders;

-- CARGA DIM_CLIENTE
INSERT INTO dw_vendas.dim_cliente (nk_cliente, nome_cliente, cidade, pais)
SELECT customer_id, company_name, city, country FROM public.customers;

-- CARGA DIM_PRODUTO (Com desnormalização de categorias)
INSERT INTO dw_vendas.dim_produto (nk_produto, nome_produto, categoria, data_inicio_validade, versao_atual)
SELECT p.product_id, p.product_name, c.category_name, CURRENT_DATE, 'Sim'
FROM public.products p
JOIN public.categories c ON p.category_id = c.category_id;

-- CARGA FATO_VENDAS (Unindo as chaves substitutas)
INSERT INTO dw_vendas.fato_vendas (sk_produto, sk_cliente, sk_data, numero_pedido, quantidade, valor_bruto, desconto)
SELECT 
    dp.sk_produto, dc.sk_cliente, 
    CAST(TO_CHAR(o.order_date, 'YYYYMMDD') AS INTEGER),
    od.order_id, od.quantity, (od.unit_price * od.quantity), od.discount
FROM public.order_details od
JOIN public.orders o ON od.order_id = o.order_id
JOIN dw_vendas.dim_produto dp ON od.product_id = dp.nk_produto
JOIN dw_vendas.dim_cliente dc ON o.customer_id = dc.nk_cliente;
