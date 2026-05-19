 =====================================================
 PROJETO: ANÁLISE DE VENDAS E CLIENTES - OLIST
 FERRAMENTA: SQL (MySQL)
 Gabriel Henrique
 =====================================================


 VISÃO GERAL
=====================================================

-- 1. Ver primeiras linhas
SELECT * FROM `Brazilian ecommerce` LIMIT 10;

-- 2. Total de linhas (itens vendidos)
SELECT COUNT(*) FROM `Brazilian ecommerce`;

-- 3. Total de pedidos únicos
SELECT COUNT(DISTINCT order_id) AS total_pedidos
FROM `Brazilian ecommerce`;

-- 4. Faturamento total
SELECT SUM(price) AS faturamento_total
FROM `Brazilian ecommerce`;

-- 5. Ticket médio geral (correto)
SELECT 
    SUM(price) / COUNT(DISTINCT order_id) AS ticket_medio
FROM `Brazilian ecommerce`;



 FATURAMENTO
=====================================================

-- 6. Faturamento por mês
SELECT month_of_purchase, SUM(price) AS faturamento
FROM `Brazilian ecommerce`
GROUP BY month_of_purchase
ORDER BY month_of_purchase;

-- 7. Faturamento por estado
SELECT customer_state, SUM(price) AS faturamento
FROM `Brazilian ecommerce`
GROUP BY customer_state
ORDER BY faturamento DESC;

-- 8. Mês com maior faturamento
SELECT month_of_purchase, SUM(price) AS faturamento
FROM `Brazilian ecommerce`
GROUP BY month_of_purchase
ORDER BY faturamento DESC
LIMIT 1;

-- 9. Faturamento por ano
SELECT year_of_purchase, SUM(price) AS total_ano
FROM `Brazilian ecommerce`
GROUP BY year_of_purchase
ORDER BY year_of_purchase;



 PRODUTOS
=====================================================

-- 10. Categoria com maior faturamento
SELECT product_category_name, SUM(price) AS faturamento
FROM `Brazilian ecommerce`
GROUP BY product_category_name
ORDER BY faturamento DESC
LIMIT 1;

-- 11. Categoria mais vendida (em quantidade)
SELECT product_category_name, COUNT(*) AS contagem_itens
FROM `Brazilian ecommerce`
GROUP BY product_category_name
ORDER BY contagem_itens DESC
LIMIT 1;

-- 12. Top 10 categorias por faturamento
SELECT product_category_name, SUM(price) AS faturamento
FROM `Brazilian ecommerce`
GROUP BY product_category_name
ORDER BY faturamento DESC
LIMIT 10;

-- 13. Top 10 produtos mais vendidos
SELECT product_id, COUNT(*) AS vezes_vendido
FROM `Brazilian ecommerce`
GROUP BY product_id
ORDER BY vezes_vendido DESC
LIMIT 10;

-- 14. Categorias com menos vendas
SELECT product_category_name, COUNT(*) AS contagemProdutos
FROM `Brazilian ecommerce`
GROUP BY product_category_name
ORDER BY contagemProdutos ASC
LIMIT 10;

-- 15. Ticket médio por produto (correto - subconsulta)
SELECT 
    product_id, 
    AVG(total_por_pedido) AS ticket_medio
FROM (
    SELECT 
        order_id, 
        product_id, 
        SUM(price) AS total_por_pedido
    FROM `Brazilian ecommerce`
    GROUP BY order_id, product_id
) AS subconsulta
GROUP BY product_id
ORDER BY ticket_medio DESC
LIMIT 10;



 CLIENTES
-- =====================================================

-- 16. Cliente que mais gastou
SELECT customer_id, SUM(price) AS total_gasto
FROM `Brazilian ecommerce`
GROUP BY customer_id
ORDER BY total_gasto DESC
LIMIT 1;

-- 17. Top 10 clientes que mais gastaram
SELECT customer_id, SUM(price) AS total_gasto
FROM `Brazilian ecommerce`
GROUP BY customer_id
ORDER BY total_gasto DESC
LIMIT 10;

-- 18. Estado com mais clientes únicos
SELECT customer_state, COUNT(DISTINCT customer_unique_id) AS total_clientes
FROM `Brazilian ecommerce`
GROUP BY customer_state
ORDER BY total_clientes DESC
LIMIT 5;

-- 19. Clientes recorrentes (mais de 1 pedido)
SELECT 
    customer_id, 
    COUNT(DISTINCT order_id) AS qtd_pedidos
FROM `Brazilian ecommerce`
GROUP BY customer_id
HAVING COUNT(DISTINCT order_id) > 1;

-- 20. Média de gasto por cliente
SELECT AVG(total_gasto) AS media_gasto_por_cliente
FROM (
    SELECT customer_id, SUM(price) AS total_gasto
    FROM `Brazilian ecommerce`
    GROUP BY customer_id
) AS subconsulta;



 TEMPO
-- =====================================================

-- 21. Evolução do faturamento (ano e mês)
SELECT year_of_purchase, month_of_purchase, SUM(price) AS faturamento
FROM `Brazilian ecommerce`
GROUP BY year_of_purchase, month_of_purchase
ORDER BY year_of_purchase DESC, month_of_purchase DESC;

-- 22. Horário com maior número de pedidos
SELECT HOUR(order_purchase_timestamp) AS hora, COUNT(DISTINCT order_id) AS total_pedidos
FROM `Brazilian ecommerce`
GROUP BY HOUR(order_purchase_timestamp)
ORDER BY total_pedidos DESC;

-- 23. Pedidos por dia da semana
SELECT day_of_purchase, COUNT(DISTINCT order_id) AS total_pedidos
FROM `Brazilian ecommerce`
GROUP BY day_of_purchase
ORDER BY total_pedidos DESC;

