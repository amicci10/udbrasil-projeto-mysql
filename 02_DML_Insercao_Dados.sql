-- ***************************************************************** --
-- II. SCRIPT SQL COM COMANDOS INSERT (POVOAMENTO DE DADOS - DML)
-- Projeto: UDBrasil Distribuidora Atacadista
-- Autor: [Henrique Arantes Amicci]
-- ***************************************************************** --

-- Desabilita a verificação de FKs temporariamente para garantir a ordem de inserção (opcional)
-- SET FOREIGN_KEY_CHECKS = 0; 
-- -----------------------------------------------------------
-- 1. TABELAS PAIS (SEM FKs - Condição, Fornecedor, Tabela Preço)
-- -----------------------------------------------------------

-- 1.1. CONDICAO_PAGAMENTO
INSERT INTO CONDICAO_PAGAMENTO (ID_Condicao_Pagamento, Descricao, Prazo_Maximo_dias) VALUES
(1, 'A Vista', 0),
(2, '30 dias', 30),
(3, '30/60/90 dias', 90);

-- 1.2. FORNECEDOR
INSERT INTO FORNECEDOR (ID_Fornecedor, Nome, CNPJ, Telefone, Contato) VALUES
(10, 'Vidros Express S/A', '11.222.333/0001-44', '(11) 5555-1234', 'Ana Paula'),
(11, 'Embalagens do Sul', '99.888.777/0001-66', '(41) 3333-5678', 'Roberto Carlos');

-- 1.3. TABELA_PRECO_ATACADO
INSERT INTO TABELA_PRECO_ATACADO (ID_Tabela_Preco, Nome_Tabela, Valor_Minimo_Volume, Percentual_Desconto, Data_Vigencia_Inicio) VALUES
(100, 'Tabela Padrao', 500, 5.00, '2025-01-01'),
(101, 'Grandes Volumes', 5000, 15.00, '2025-06-01');

-- -----------------------------------------------------------
-- 2. TABELAS QUE DEPENDEM DE DADOS ANTERIORES (Com FKs)
-- -----------------------------------------------------------

-- 2.1. CLIENTE_PJ (FK: ID_Condicao_Pagamento)
INSERT INTO CLIENTE_PJ (CNPJ, Razao_Social, Nome_Fantasia, Endereco, Telefone, Email, Limite_Credito, Status_Credito, ID_Condicao_Pagamento) VALUES
('01.111.222/0001-33', 'Atacado Vidros S.A.', 'Vidro Atacado SP', 'Rua A, 123', '(11) 9876-5432', 'contato@vidrosp.com.br', 80000.00, 'Aprovado', 3),
('02.333.444/0001-55', 'Marmitaria Gourmet LTDA', 'Gourmet Packs', 'Av B, 456', '(21) 9988-7766', 'packs@gourmet.com', 15000.00, 'Aprovado', 2);

-- 2.2. PRODUTO (FKs: ID_Fornecedor, ID_Tabela_Preco)
INSERT INTO PRODUTO (SKU, Nome, Descricao, Capacidade_ml, Preco_Custo, Quantidade_Estoque, ID_Fornecedor, ID_Tabela_Preco) VALUES
('PC200', 'Pote Cilindrico 200ml', 'Vidro transparente, tampa metalica', 200, 1.25, 15000, 10, 101),
('QS500', 'Pote Quadrado 500ml', 'Vidro fosco, ideal para conservas', 500, 2.50, 8000, 11, 100);

-- 2.3. PEDIDO (FK: CNPJ_Cliente)
INSERT INTO PEDIDO (ID_Pedido, Data_Pedido, Data_Entrega_Prevista, Status_Pedido, Valor_Total, Status_Credito, CNPJ_Cliente) VALUES
(1000, '2025-11-28', '2025-12-05', 'Faturado', 3000.00, 'Aprovado', '01.111.222/0001-33'),
(1001, '2025-11-29', '2025-12-06', 'Reservado', 525.00, 'Aprovado', '02.333.444/0001-55');

-- -----------------------------------------------------------
-- 3. TABELAS ASSOCIATIVAS E DE RASTREABILIDADE
-- -----------------------------------------------------------

-- 3.1. ITEM_PEDIDO (PK Composta e FKs: ID_Pedido, SKU_Produto)
-- O preço negociado de PC200 (Preço Custo R$ 1.25). Se aplica 15% de desconto (Tabela 101).
INSERT INTO ITEM_PEDIDO (ID_Pedido, SKU_Produto, Quantidade, Preco_Unitario_Negociado, Subtotal) VALUES
(1000, 'PC200', 2500, 1.45, 3625.00); -- Valor total fictício para o exemplo.

-- 3.2. MOVIMENTACAO_ESTOQUE (FKs: SKU_Produto, ID_Pedido)
-- Saída do estoque referente ao Pedido 1000
INSERT INTO MOVIMENTACAO_ESTOQUE (ID_Movimentacao, Tipo_Movimentacao, Quantidade, Data_Hora, SKU_Produto, ID_Pedido) VALUES
(1, 'S', 2500, '2025-11-29 10:30:00', 'PC200', 1000); 

-- Entrada de estoque (Não ligada a pedido)
INSERT INTO MOVIMENTACAO_ESTOQUE (ID_Movimentacao, Tipo_Movimentacao, Quantidade, Data_Hora, SKU_Produto, ID_Pedido) VALUES
(2, 'E', 5000, '2025-11-01 08:00:00', 'QS500', NULL); 

-- SET FOREIGN_KEY_CHECKS = 1; -- Reativa a verificação de FKs (se desativada)