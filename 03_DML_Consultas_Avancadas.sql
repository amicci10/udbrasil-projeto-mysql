-- ***************************************************************
-- 03_DML_CONSULTAS_AVANCADAS.SQL
-- Projeto: UDBrasil Distribuidora Atacadista
-- Demonstração de SELECT com JOIN, GROUP BY, WHERE, ORDER BY
-- ***************************************************************

USE udbrasil_projeto; 

-- -----------------------------------------------------------------
-- 1. CONSULTA PRINCIPAL: DETALHE DO PEDIDO COM CLIENTE E CONDIÇÃO (JOINs Múltiplos)
-- REQUISITO: JOIN, ORDER BY
-- -----------------------------------------------------------------
SELECT 
    P.ID_Pedido,
    C.Nome_Fantasia AS Cliente,
    P.Valor_Total,
    CP.Descricao AS Condicao_Pagamento
FROM 
    pedido P
JOIN 
    cliente_pj C ON P.CNPJ_Cliente = C.CNPJ
JOIN 
    condicao_pagamento CP ON C.ID_Condicao_Pagamento = CP.ID_Condicao_Pagamento
ORDER BY 
    P.Data_Pedido DESC;


-- -----------------------------------------------------------------
-- 2. ANÁLISE DE VOLUME: VALOR TOTAL DE ESTOQUE POR FORNECEDOR (GROUP BY e SUM)
-- REQUISITO: GROUP BY, Função de Agregação
-- -----------------------------------------------------------------
SELECT
    F.Nome AS Fornecedor,
    COUNT(P.SKU) AS Total_Produtos_Distintos,
    SUM(P.Preco_Custo * P.Quantidade_Estoque) AS Valor_Total_Estoque_Custo
FROM
    produto P
JOIN
    fornecedor F ON P.ID_Fornecedor = F.ID_Fornecedor
GROUP BY
    F.Nome
ORDER BY
    Valor_Total_Estoque_Custo DESC;


-- -----------------------------------------------------------------
-- 3. LOGÍSTICA: PRODUTOS COM BAIXO ESTOQUE (WHERE, ORDER BY e LIMIT)
-- REQUISITO: WHERE, ORDER BY, LIMIT
-- -----------------------------------------------------------------
SELECT
    SKU,
    Nome,
    Quantidade_Estoque,
    Preco_Custo
FROM
    produto
WHERE
    Quantidade_Estoque < 10000 
ORDER BY
    Quantidade_Estoque ASC
LIMIT 3; 

