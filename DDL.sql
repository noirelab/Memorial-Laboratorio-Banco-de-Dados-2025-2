-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`tb_cidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tb_cidade` (
  `id_cidade` INT NOT NULL AUTO_INCREMENT,
  `nome_cidade` VARCHAR(150) NOT NULL,
  PRIMARY KEY (`id_cidade`),
  UNIQUE INDEX `nome_cidade_UNIQUE` (`nome_cidade` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mydb`.`tb_bairro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tb_bairro` (
  `id_bairro` INT NOT NULL AUTO_INCREMENT,
  `nome_bairro` VARCHAR(100) NOT NULL,
  `id_cidade` INT NOT NULL,
  PRIMARY KEY (`id_bairro`),
  INDEX `id_cidade_idx` (`id_cidade` ASC) VISIBLE,
  CONSTRAINT `fk_bairro_cidade`
    FOREIGN KEY (`id_cidade`)
    REFERENCES `mydb`.`tb_cidade` (`id_cidade`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mydb`.`tb_cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tb_cliente` (
  `id_cliente` INT NOT NULL AUTO_INCREMENT,
  `nome_cliente` VARCHAR(100) NOT NULL,
  `cpf_cnpj_cliente` VARCHAR(20) NOT NULL,
  `telefone_cliente` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id_cliente`),
  UNIQUE INDEX `cpf_cnpj_cliente_UNIQUE` (`cpf_cnpj_cliente` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mydb`.`tb_endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tb_endereco` (
  `id_endereco` INT NOT NULL AUTO_INCREMENT,
  `id_bairro` INT NOT NULL,
  `logradouro` VARCHAR(150) NOT NULL,
  `numero` VARCHAR(30) NOT NULL,
  `complemento` VARCHAR(150) NULL DEFAULT NULL,
  `id_cliente` INT NOT NULL,
  `prioridade` TINYINT NULL DEFAULT NULL,
  PRIMARY KEY (`id_endereco`),
  INDEX `id_cliente_idx` (`id_cliente` ASC) VISIBLE,
  INDEX `id_bairro_idx` (`id_bairro` ASC) VISIBLE,
  CONSTRAINT `fk_endereco_bairro`
    FOREIGN KEY (`id_bairro`)
    REFERENCES `mydb`.`tb_bairro` (`id_bairro`),
  CONSTRAINT `fk_endereco_cliente`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `mydb`.`tb_cliente` (`id_cliente`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mydb`.`tb_cargo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tb_cargo` (
  `id_cargo` INT NOT NULL AUTO_INCREMENT,
  `nome_cargo` VARCHAR(45) NOT NULL,
  `descricao_cargo` VARCHAR(150) NOT NULL,
  `salario_base` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`id_cargo`),
  UNIQUE INDEX `descricao_cargo_UNIQUE` (`descricao_cargo` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mydb`.`tb_funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tb_funcionario` (
  `id_funcionario` INT NOT NULL AUTO_INCREMENT,
  `nome_funcionario` VARCHAR(45) NOT NULL,
  `cpf_funcionario` VARCHAR(20) NOT NULL,
  `id_cargo` INT NOT NULL,
  PRIMARY KEY (`id_funcionario`),
  UNIQUE INDEX `cpf_funcionario_UNIQUE` (`cpf_funcionario` ASC) VISIBLE,
  INDEX `id_cargo_idx` (`id_cargo` ASC) VISIBLE,
  CONSTRAINT `fk_funcionario_cargo`
    FOREIGN KEY (`id_cargo`)
    REFERENCES `mydb`.`tb_cargo` (`id_cargo`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mydb`.`tb_fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tb_fornecedor` (
  `id_fornecedor` INT NOT NULL AUTO_INCREMENT,
  `nome_fornecedor` VARCHAR(50) NOT NULL,
  `cpf_cnpj_fornecedor` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id_fornecedor`),
  UNIQUE INDEX `cpf_cnpj_fornecedor_UNIQUE` (`cpf_cnpj_fornecedor` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mydb`.`tb_compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tb_compra` (
  `id_compra` INT NOT NULL AUTO_INCREMENT,
  `id_fornecedor` INT NOT NULL,
  `data` DATE NOT NULL,
  PRIMARY KEY (`id_compra`),
  INDEX `id_fornecedor_idx` (`id_fornecedor` ASC) VISIBLE,
  CONSTRAINT `fk_compra_fornecedor`
    FOREIGN KEY (`id_fornecedor`)
    REFERENCES `mydb`.`tb_fornecedor` (`id_fornecedor`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mydb`.`tb_categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tb_categoria` (
  `id_categoria` INT NOT NULL AUTO_INCREMENT,
  `nome_categoria` VARCHAR(50) NOT NULL,
  `descricao_categoria` VARCHAR(150) NULL DEFAULT NULL,
  PRIMARY KEY (`id_categoria`),
  UNIQUE INDEX `nome_categoria_UNIQUE` (`nome_categoria` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mydb`.`tb_produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tb_produto` (
  `id_produto` INT NOT NULL AUTO_INCREMENT,
  `nome_produto` VARCHAR(60) NOT NULL,
  `descricao_produto` VARCHAR(150) NULL DEFAULT NULL,
  `requer_montagem` TINYINT NOT NULL DEFAULT '0',
  `id_categoria` INT NOT NULL,
  PRIMARY KEY (`id_produto`),
  UNIQUE INDEX `nome_produto_UNIQUE` (`nome_produto` ASC) VISIBLE,
  INDEX `id_categoria_idx` (`id_categoria` ASC) VISIBLE,
  CONSTRAINT `fk_produto_categoria`
    FOREIGN KEY (`id_categoria`)
    REFERENCES `mydb`.`tb_categoria` (`id_categoria`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mydb`.`tb_estoque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tb_estoque` (
  `id_estoque` INT NOT NULL AUTO_INCREMENT,
  `id_compra` INT NOT NULL,
  `id_produto` INT NOT NULL,
  `quantidade` INT NOT NULL,
  `preco_estoque` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`id_estoque`),
  INDEX `id_compra_idx` (`id_compra` ASC) VISIBLE,
  INDEX `id_produto_idx` (`id_produto` ASC) VISIBLE,
  CONSTRAINT `fk_estoque_compra`
    FOREIGN KEY (`id_compra`)
    REFERENCES `mydb`.`tb_compra` (`id_compra`),
  CONSTRAINT `fk_estoque_produto`
    FOREIGN KEY (`id_produto`)
    REFERENCES `mydb`.`tb_produto` (`id_produto`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mydb`.`tb_venda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tb_venda` (
  `id_venda` INT NOT NULL AUTO_INCREMENT,
  `id_cliente` INT NOT NULL,
  `id_funcionario` INT NOT NULL,
  `data` DATE NOT NULL,
  `status` ENUM('pendente', 'concluida', 'cancelada') NOT NULL,
  `observacao_venda` VARCHAR(200) NULL DEFAULT NULL,
  PRIMARY KEY (`id_venda`),
  INDEX `id_cliente_idx` (`id_cliente` ASC) VISIBLE,
  INDEX `id_funcionario_idx` (`id_funcionario` ASC) VISIBLE,
  CONSTRAINT `fk_venda_cliente`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `mydb`.`tb_cliente` (`id_cliente`),
  CONSTRAINT `fk_venda_funcionario`
    FOREIGN KEY (`id_funcionario`)
    REFERENCES `mydb`.`tb_funcionario` (`id_funcionario`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mydb`.`tb_produto_venda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tb_produto_venda` (
  `id_venda_itens` INT NOT NULL AUTO_INCREMENT,
  `id_venda` INT NOT NULL,
  `id_estoque` INT NOT NULL,
  `quantidade` INT NOT NULL,
  `valor` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`id_venda_itens`),
  INDEX `fk_venda_idx` (`id_venda` ASC) VISIBLE,
  INDEX `fk_estoque_idx` (`id_estoque` ASC) VISIBLE,
  CONSTRAINT `fk_produto_venda_to_estoque`
    FOREIGN KEY (`id_estoque`)
    REFERENCES `mydb`.`tb_estoque` (`id_estoque`),
  CONSTRAINT `fk_produto_venda_to_venda`
    FOREIGN KEY (`id_venda`)
    REFERENCES `mydb`.`tb_venda` (`id_venda`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mydb`.`tb_agendamento_montagem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tb_agendamento_montagem` (
  `id_agendamento_montagem` INT NOT NULL AUTO_INCREMENT,
  `id_venda_itens` INT NOT NULL,
  `id_funcionario` INT NOT NULL,
  `id_endereco` INT NOT NULL,
  `data` DATE NOT NULL,
  `status_montagem` ENUM('realizado', 'pendente', 'cancelado') NOT NULL,
  `observacao` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id_agendamento_montagem`),
  INDEX `id_venda_itens_idx` (`id_venda_itens` ASC) VISIBLE,
  INDEX `id_funcionario_idx` (`id_funcionario` ASC) VISIBLE,
  INDEX `id_endereco_idx` (`id_endereco` ASC) VISIBLE,
  CONSTRAINT `fk_agendamento_endereco`
    FOREIGN KEY (`id_endereco`)
    REFERENCES `mydb`.`tb_endereco` (`id_endereco`),
  CONSTRAINT `fk_agendamento_funcionario`
    FOREIGN KEY (`id_funcionario`)
    REFERENCES `mydb`.`tb_funcionario` (`id_funcionario`),
  CONSTRAINT `fk_agendamento_produto_venda`
    FOREIGN KEY (`id_venda_itens`)
    REFERENCES `mydb`.`tb_produto_venda` (`id_venda_itens`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mydb`.`tb_entrega`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tb_entrega` (
  `id_entrega` INT NOT NULL AUTO_INCREMENT,
  `id_venda` INT NOT NULL,
  `id_endereco` INT NOT NULL,
  `data_entrega` DATE NOT NULL,
  `status_entrega` ENUM('pendente', 'entregue', 'cancelado') NULL DEFAULT 'pendente',
  PRIMARY KEY (`id_entrega`),
  INDEX `id_venda_idx` (`id_venda` ASC) VISIBLE,
  INDEX `id_endereco_idx` (`id_endereco` ASC) VISIBLE,
  CONSTRAINT `fk_entrega_endereco`
    FOREIGN KEY (`id_endereco`)
    REFERENCES `mydb`.`tb_endereco` (`id_endereco`),
  CONSTRAINT `fk_entrega_venda`
    FOREIGN KEY (`id_venda`)
    REFERENCES `mydb`.`tb_venda` (`id_venda`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mydb`.`tb_pagamento_cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tb_pagamento_cliente` (
  `id_pagamento_cliente` INT NOT NULL AUTO_INCREMENT,
  `id_venda` INT NOT NULL,
  `data_pagamento` DATE NOT NULL,
  `forma_pagamento` ENUM('cartao_credito', 'cartao_debito', 'pix', 'boleto', 'dinheiro') NOT NULL,
  `status_pagamento` ENUM('pendente', 'pago', 'cancelado', 'atrasado') NOT NULL,
  PRIMARY KEY (`id_pagamento_cliente`),
  INDEX `id_venda_idx` (`id_venda` ASC) VISIBLE,
  CONSTRAINT `fk_pagamento_venda`
    FOREIGN KEY (`id_venda`)
    REFERENCES `mydb`.`tb_venda` (`id_venda`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mydb`.`tb_receita_extra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tb_receita_extra` (
  `id_receita` INT NOT NULL AUTO_INCREMENT,
  `descricao_receita` VARCHAR(150) NOT NULL,
  `valor` DECIMAL(10,2) NOT NULL,
  `data_recebimento` DATE NOT NULL,
  `id_funcionario` INT NOT NULL,
  PRIMARY KEY (`id_receita`),
  INDEX `id_funcionario_idx` (`id_funcionario` ASC) VISIBLE,
  CONSTRAINT `fk_receita_funcionario`
    FOREIGN KEY (`id_funcionario`)
    REFERENCES `mydb`.`tb_funcionario` (`id_funcionario`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
