-- 1. CRIAÇÃO DO SCHEMA
CREATE SCHEMA IF NOT EXISTS dw_vendas;

-- 2. DIMENSÃO PRODUTO (SCD TIPO 2)
CREATE TABLE dw_vendas.dim_produto (
    sk_produto SERIAL PRIMARY KEY,    -- Surrogate Key (Controle Interno)
    nk_produto INTEGER,               -- Natural Key (ID do Northwind)
    nome_produto TEXT,
    categoria TEXT,
    data_inicio_validade DATE,
    data_fim_validade DATE,           
    versao_atual TEXT                 
);

-- 3. DIMENSÃO CLIENTE
CREATE TABLE dw_vendas.dim_cliente (
    sk_cliente SERIAL PRIMARY KEY,
    nk_cliente TEXT,
    nome_cliente TEXT,
    cidade TEXT,
    pais TEXT
);

-- 4. DIMENSÃO DATA
CREATE TABLE dw_vendas.dim_data (
    sk_data INTEGER PRIMARY KEY,      -- Chave YYYYMMDD
    data_completa DATE,
    ano INTEGER,
    mes INTEGER,
    dia_semana TEXT
);

-- 5. TABELA FATO VENDAS (Grão Atômico)
CREATE TABLE dw_vendas.fato_vendas (
    sk_produto INTEGER REFERENCES dw_vendas.dim_produto(sk_produto),
    sk_cliente INTEGER REFERENCES dw_vendas.dim_cliente(sk_cliente),
    sk_data INTEGER REFERENCES dw_vendas.dim_data(sk_data),
    numero_pedido INTEGER,            -- Dimensão Degenerada
    quantidade INTEGER,
    valor_bruto DECIMAL(10,2),
    desconto DECIMAL(10,2)
);
