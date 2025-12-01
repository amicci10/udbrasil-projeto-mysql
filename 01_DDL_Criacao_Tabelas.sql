-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema udbrasil_projeto
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `udbrasil_projeto` ;

-- -----------------------------------------------------
-- Schema udbrasil_projeto
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `udbrasil_projeto` DEFAULT CHARACTER SET utf8 ;
USE `udbrasil_projeto` ;

-- -----------------------------------------------------
-- Table `udbrasil_projeto`.`condicao_pagamento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `udbrasil_projeto`.`condicao_pagamento` ;

CREATE TABLE IF NOT EXISTS `udbrasil_projeto`.`condicao_pagamento` (
  `ID_Condicao_Pagamento` INT NOT NULL AUTO_INCREMENT,
  `Descricao` VARCHAR(50) NOT NULL,
  `Prazo_Maximo_dias` INT NOT NULL,
  PRIMARY KEY (`ID_Condicao_Pagamento`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `udbrasil_projeto`.`MOVIMENTACAO_ESTOQUE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `udbrasil_projeto`.`MOVIMENTACAO_ESTOQUE` ;

CREATE TABLE IF NOT EXISTS `udbrasil_projeto`.`MOVIMENTACAO_ESTOQUE` (
  `ID_Movimentacao` INT NOT NULL AUTO_INCREMENT,
  `Tipo_Movimentacao` CHAR(1) NOT NULL,
  `Quantidade` INT NOT NULL,
  `Data_Hora` VARCHAR(45) NOT NULL,
  `MOVIMENTAÇÃO_ESTOQUEcol` DATETIME NOT NULL,
  `SKU_Produto` VARCHAR(45) NOT NULL,
  `ID_PEDIDO` INT NULL,
  PRIMARY KEY (`ID_Movimentacao`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `udbrasil_projeto`.`PEDIDO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `udbrasil_projeto`.`PEDIDO` ;

CREATE TABLE IF NOT EXISTS `udbrasil_projeto`.`PEDIDO` (
  `ID_Pedido` INT NOT NULL AUTO_INCREMENT,
  `Data_Pedido` DATE NOT NULL,
  `Data_Entrega_Prevista` DATE NOT NULL,
  `Status_Pedido` VARCHAR(50) NOT NULL,
  `Valor_Total` DECIMAL(10,2) NOT NULL,
  `Status_Credito` VARCHAR(30) NOT NULL,
  `CNPJ_Cliente` VARCHAR(18) NOT NULL,
  `MOVIMENTAÇÃO_ESTOQUE_ID_Movimentacao` INT NOT NULL,
  PRIMARY KEY (`ID_Pedido`),
  CONSTRAINT `fk_PEDIDO_MOVIMENTAÇÃO_ESTOQUE1`
    FOREIGN KEY (`MOVIMENTAÇÃO_ESTOQUE_ID_Movimentacao`)
    REFERENCES `udbrasil_projeto`.`MOVIMENTACAO_ESTOQUE` (`ID_Movimentacao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_PEDIDO_MOVIMENTAÇÃO_ESTOQUE1_idx` ON `udbrasil_projeto`.`PEDIDO` (`MOVIMENTAÇÃO_ESTOQUE_ID_Movimentacao` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `udbrasil_projeto`.`CLIENTE_PJ`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `udbrasil_projeto`.`CLIENTE_PJ` ;

CREATE TABLE IF NOT EXISTS `udbrasil_projeto`.`CLIENTE_PJ` (
  `CNPJ` VARCHAR(18) NOT NULL,
  `Razao_Social` VARCHAR(150) NOT NULL,
  `Nome_Fantasia` VARCHAR(150) NOT NULL,
  `Endereço` VARCHAR(255) NOT NULL,
  `Telefone` VARCHAR(20) NOT NULL,
  `EMAIL` VARCHAR(100) NULL,
  `Limite_Credito` DECIMAL(10,2) NOT NULL,
  `Status_Credito` VARCHAR(20) NOT NULL,
  `ID_Condicao_Pagamento` INT NOT NULL,
  `PEDIDO_ID_Pedido` INT NOT NULL,
  PRIMARY KEY (`CNPJ`),
  CONSTRAINT `fk_cliente_condicao`
    FOREIGN KEY (`ID_Condicao_Pagamento`)
    REFERENCES `udbrasil_projeto`.`condicao_pagamento` (`ID_Condicao_Pagamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CLIENTE_PJ_PEDIDO1`
    FOREIGN KEY (`PEDIDO_ID_Pedido`)
    REFERENCES `udbrasil_projeto`.`PEDIDO` (`ID_Pedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `EMAIL_UNIQUE` ON `udbrasil_projeto`.`CLIENTE_PJ` (`EMAIL` ASC) VISIBLE;

CREATE INDEX `fk_cliente_condicao_idx` ON `udbrasil_projeto`.`CLIENTE_PJ` (`ID_Condicao_Pagamento` ASC) VISIBLE;

CREATE INDEX `fk_CLIENTE_PJ_PEDIDO1_idx` ON `udbrasil_projeto`.`CLIENTE_PJ` (`PEDIDO_ID_Pedido` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `udbrasil_projeto`.`TABELA_PRECO_ATACADO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `udbrasil_projeto`.`TABELA_PRECO_ATACADO` ;

CREATE TABLE IF NOT EXISTS `udbrasil_projeto`.`TABELA_PRECO_ATACADO` (
  `ID_Tabela_Preco` INT NOT NULL AUTO_INCREMENT,
  `Nome_Tabela` VARCHAR(100) NOT NULL,
  `Valor_Minimo_Volume` INT NOT NULL,
  `Percentual_Desconto` DECIMAL(5,2) NOT NULL,
  `Data_Vigencia_Inicio` DATE NOT NULL,
  PRIMARY KEY (`ID_Tabela_Preco`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `udbrasil_projeto`.`FORNECEDOR`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `udbrasil_projeto`.`FORNECEDOR` ;

CREATE TABLE IF NOT EXISTS `udbrasil_projeto`.`FORNECEDOR` (
  `ID_Fornecedor` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(150) NOT NULL,
  `CNPJ` VARCHAR(18) NOT NULL,
  `TELEFONE` VARCHAR(20) NULL,
  `Contato` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`ID_Fornecedor`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `CNPJ_UNIQUE` ON `udbrasil_projeto`.`FORNECEDOR` (`CNPJ` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `udbrasil_projeto`.`ITEM_PEDIDO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `udbrasil_projeto`.`ITEM_PEDIDO` ;

CREATE TABLE IF NOT EXISTS `udbrasil_projeto`.`ITEM_PEDIDO` (
  `ID_Pedido` INT NOT NULL,
  `SKU_Produto` VARCHAR(45) NOT NULL,
  `Quantidade` INT NOT NULL,
  `Preco_Unitario_Negociado` DECIMAL(10,2) NOT NULL,
  `SUBTOTAL` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`ID_Pedido`, `SKU_Produto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `udbrasil_projeto`.`PRODUTO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `udbrasil_projeto`.`PRODUTO` ;

CREATE TABLE IF NOT EXISTS `udbrasil_projeto`.`PRODUTO` (
  `SKU` VARCHAR(20) NOT NULL,
  `NOME` VARCHAR(100) NOT NULL,
  `CAPACIDADE_ML` INT NOT NULL,
  `PRECO_CUSTO` DECIMAL(10,2) NOT NULL,
  `Quantidade_Estoque` INT NOT NULL,
  `ID_Fornecedor` INT NOT NULL,
  `ID_Tabela_Preco` INT NOT NULL,
  `ITEM_PEDIDO_ID_Pedido` INT NOT NULL,
  `ITEM_PEDIDO_SKU_Produto` VARCHAR(45) NOT NULL,
  `MOVIMENTAÇÃO_ESTOQUE_ID_Movimentacao` INT NOT NULL,
  PRIMARY KEY (`SKU`, `Quantidade_Estoque`, `ITEM_PEDIDO_ID_Pedido`, `ITEM_PEDIDO_SKU_Produto`),
  CONSTRAINT `PREÇO DESCONTO`
    FOREIGN KEY (`ID_Tabela_Preco`)
    REFERENCES `udbrasil_projeto`.`TABELA_PRECO_ATACADO` (`ID_Tabela_Preco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FORNECEDOR`
    FOREIGN KEY (`ID_Fornecedor`)
    REFERENCES `udbrasil_projeto`.`FORNECEDOR` (`ID_Fornecedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PRODUTO_ITEM_PEDIDO1`
    FOREIGN KEY (`ITEM_PEDIDO_ID_Pedido` , `ITEM_PEDIDO_SKU_Produto`)
    REFERENCES `udbrasil_projeto`.`ITEM_PEDIDO` (`ID_Pedido` , `SKU_Produto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PRODUTO_MOVIMENTAÇÃO_ESTOQUE1`
    FOREIGN KEY (`MOVIMENTAÇÃO_ESTOQUE_ID_Movimentacao`)
    REFERENCES `udbrasil_projeto`.`MOVIMENTACAO_ESTOQUE` (`ID_Movimentacao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `PREÇO DESCONTO_idx` ON `udbrasil_projeto`.`PRODUTO` (`ID_Tabela_Preco` ASC) VISIBLE;

CREATE INDEX `FORNECEDOR_idx` ON `udbrasil_projeto`.`PRODUTO` (`ID_Fornecedor` ASC) VISIBLE;

CREATE INDEX `fk_PRODUTO_ITEM_PEDIDO1_idx` ON `udbrasil_projeto`.`PRODUTO` (`ITEM_PEDIDO_ID_Pedido` ASC, `ITEM_PEDIDO_SKU_Produto` ASC) VISIBLE;

CREATE INDEX `fk_PRODUTO_MOVIMENTAÇÃO_ESTOQUE1_idx` ON `udbrasil_projeto`.`PRODUTO` (`MOVIMENTAÇÃO_ESTOQUE_ID_Movimentacao` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
