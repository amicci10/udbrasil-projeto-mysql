-- ***************************************************************
-- DML - MANIPULAÇÃO DE DADOS (UPDATE E DELETE)
-- Projeto: UDBrasil Distribuidora Atacadista
-- ***************************************************************

USE udbrasil_projeto; 
SET SQL_SAFE_UPDATES = 0; -- Desativa o modo de segurança para permitir UPDATEs e DELETEs sem WHERE na PK (Apenas para testes!)

-- -------------------------------------------------------------
-- 1. COMANDOS UPDATE (3 COMANDOS)
-- Objetivo: Alterar dados existentes com base em condições.
-- -------------------------------------------------------------

-- 1.1. Alterar o status de crédito: Bloquear clientes com limite inferior a R$ 20.000,00.
UPDATE cliente_pj 
SET Status_Credito = 'Bloqueado' 
WHERE Limite_Credito < 20000.00; 

-- 1.2. Atualizar o preço de custo: Aumentar o preço de custo em 10% para todos os produtos do Fornecedor ID 11.
UPDATE produto 
SET Preco_Custo = Preco_Custo * 1.10 
WHERE ID_Fornecedor = 11; 

-- 1.3. Atualizar o status de um pedido: Mudar o Pedido #1001 de 'Reservado' para 'Em Separacao'.
UPDATE pedido 
SET Status_Pedido = 'Em Separacao', Data_Entrega_Prevista = '2025-12-07'
WHERE ID_Pedido = 1001;

-- -------------------------------------------------------------
-- 2. COMANDOS DELETE (3 COMANDOS)
-- Objetivo: Remover dados, respeitando as FKs.
-- -------------------------------------------------------------

-- 2.1. Remover Movimentações de Estoque Antigas: Deletar registros de entrada/saída anteriores a uma data específica.
DELETE FROM movimentacao_estoque 
WHERE Data_Hora < '2025-11-05 00:00:00'; 

-- 2.2. Remover um Item Específico de um Pedido: Remover o produto QS500 do Pedido 1001.
-- NOTA: Como ITEM_PEDIDO é uma tabela associativa, esta exclusão é segura.
DELETE FROM item_pedido
WHERE ID_Pedido = 1001 AND SKU_Produto = 'QS500';

-- 2.3. Remover um Cliente (CUIDADO com FKs!): 
-- Para remover um CLIENTE_PJ, primeiro é necessário remover todos os registros que o referenciam.
-- Tentativa de remover um cliente com Limite de Crédito muito baixo e sem pedidos:
DELETE FROM cliente_pj 
WHERE CNPJ = '00.111.222/0001-33' AND Limite_Credito < 5000;
-- NOTA: Se o cliente 00.111.222/0001-33 tiver pedidos, este comando falhará (Foreign Key Constraint Fail).

-- Reativa o modo de segurança (Importante!)
SET SQL_SAFE_UPDATES = 1;