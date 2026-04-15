# Data Mart Northwind: Modelagem Dimensional & ETL

Este projeto apresenta a implementação de um ambiente analítico (Data Mart) baseado na base de dados **Northwind**. O objetivo principal foi aplicar os conceitos da **Metodologia Kimball** para transformar dados transacionais em uma estrutura otimizada para Business Intelligence.

##  Arquitetura do Modelo (Star Schema)

A modelagem foi desenhada seguindo o padrão **Esquema Estrela**, focando na performance de leitura e facilidade de análise para o usuário final.

### Componentes do DW:
- **Tabela Fato (`fato_vendas`):** Armazena as métricas de negócio (quantidade, valor bruto, desconto) no grão mais detalhado (item de pedido).
- **Dimensões:**
  - `dim_produto`: Implementada com suporte a **SCD Tipo 2** (Slowly Changing Dimensions) para preservação de histórico.
  - `dim_cliente`: Contém atributos geográficos para análise regional.
  - `dim_data`: Tabela física de tempo para permitir inteligência temporal (ano, mês, dia da semana).

## 🛠️ Decisões Técnicas & Ferramentas
- **Banco de Dados:** PostgreSQL 18
- **Surrogate Keys (SK):** Uso de chaves artificiais (`SERIAL`) para garantir a independência do DW frente a mudanças nos sistemas de origem.
- **Dimensão Degenerada:** O ID do pedido original foi mantido na fato para permitir auditorias e drill-through.
- **ETL:** Scripts desenvolvidos em SQL puro, realizando a desnormalização de categorias e normalização de nomes de atributos.

##  Conformidade com a LGPD
Este projeto utiliza exclusivamente dados **sintéticos/fictícios** da base Northwind. A escolha por este dataset garante que todo o desenvolvimento e demonstração técnica ocorram em total conformidade com a **LGPD (Lei Geral de Proteção de Dados)**, seguindo o princípio de *Privacy by Design* e evitando a exposição de qualquer dado sensível (PII).

##  Resultados Analíticos
O modelo permite consultas complexas com alta performance. Abaixo, um exemplo de relatório de faturamento consolidado por categoria de produto:

![Resultado do Relatório](./SQL/resultado_faturamento.png)


---
**Projeto desenvolvido durante a Residência em Dados na Xerlock Smart Gov.**# northwind-datamart-kimball
Implementação de um Data Mart utilizando Star Schema e Metodologia Kimball sobre a base Northwind.
