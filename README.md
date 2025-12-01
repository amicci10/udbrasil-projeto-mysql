# 📦 Projeto de Modelagem e Implementação SQL: UDBrasil Distribuidora Atacadista

## 📋 1. Visão Geral do Projeto

[cite_start]Este projeto consiste na modelagem e implementação de um Banco de Dados Relacional para a empresa **UDBrasil**, uma distribuidora **B2B** (Business-to-Business) de potes e embalagens de vidro em grandes volumes[cite: 118]. [cite_start]O foco principal do sistema é gerenciar o **estoque atacadista**, as regras de **preços por volume** e o **rastreamento de pedidos** de clientes Pessoa Jurídica (PJ)[cite: 119, 120, 121, 122, 123].

---

## 🏗️ 2. Modelo Lógico (Diagrama Entidade-Relacionamento - DER)

O modelo foi desenvolvido utilizando a ferramenta MySQL Workbench, seguindo rigorosamente as diretrizes de normalização até a **Terceira Forma Normal (3FN)**.

### Entidades Principais Relevantes

O modelo é composto por 8 tabelas principais, com foco nas seguintes entidades transacionais e de produto:

* [cite_start]**CLIENTE\_PJ:** Cadastro e gestão de crédito B2B[cite: 125].
* **PRODUTO:** Detalhes do pote, estoque total e regras de preço[cite: 148, 126].
* [cite_start]**PEDIDO:** Informações da transação de venda e status de crédito[cite: 150].
* **ITEM\_PEDIDO:** Tabela associativa que resolve a relação N:M entre Pedido e Produto.
* **FORNECEDOR:** Dados cadastrais da origem dos produtos[cite: 151].

### Aplicação da Normalização

O uso de Chaves Estrangeiras (FKs) foi crucial para atingir a 3FN, garantindo que:
1.  **Eliminação de Redundância:** Atributos como preço e condição de pagamento foram movidos para tabelas separadas (`TABELA_PRECO_ATACADO` e `CONDICAO_PAGAMENTO`)[cite: 149, 152].
2.  **Integridade Referencial:** Não é possível inserir um pedido sem um cliente PJ existente, ou um item sem um produto válido.

---

## 🛠️ 3. Instruções de Execução dos Scripts SQL

O banco de dados foi implementado usando comandos SQL DDL (Criação) e DML (Manipulação) no ambiente MySQL.

### Ambiente de Execução

* **Ferramenta:** MySQL Workbench.
* **Linguagem:** SQL (MySQL Dialect).

### Ordem de Execução

Os scripts devem ser executados na ordem numérica para respeitar as dependências das Chaves Estrangeiras (FKs).

| Ordem | Arquivo | Conteúdo | Objetivo |
| :--- | :--- | :--- | :--- |
| **1º** | `01_DDL_Criacao_Tabelas.sql` | `CREATE TABLE` | Cria a estrutura do banco e todas as 8 tabelas. |
| **2º** | `02_DML_Insercao_Dados.sql` | `INSERT INTO` | Popula todas as tabelas, respeitando a ordem das FKs. |
| **3º** | `03_DML_Consultas_Avancadas.sql` | `SELECT` | Demonstra a recuperação de dados usando JOINs, WHERE e GROUP BY. |
| **4º** | `04_DML_Manipulacao_Dados.sql` | `UPDATE` / `DELETE` | Altera status de crédito e remove registros antigos. |

---

## 👨‍💻 4. Autor

**Autor do Projeto:** [Henrique Arantes Amicci]
**Instituição:** [Universidade Cruzeiro do Sul]
