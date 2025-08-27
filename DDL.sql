drop database mydb;

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';


CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8mb3 ;
USE `mydb` ;


CREATE TABLE IF NOT EXISTS `mydb`.`tb_cliente` (
  `id_cliente` INT NOT NULL AUTO_INCREMENT,
  `nome_cliente` VARCHAR(100) NOT NULL,
  `cpf_cnpj_cliente` VARCHAR(20) NOT NULL,
  `telefone_cliente` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id_cliente`),
  UNIQUE INDEX `cpf_cnpj_cliente` (`cpf_cnpj_cliente` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;



CREATE TABLE IF NOT EXISTS `mydb`.`tb_cargo` (
  `id_cargo` INT NOT NULL AUTO_INCREMENT,
  `nome_cargo` VARCHAR(45) NOT NULL,
  `descricao_cargo` VARCHAR(150) NOT NULL,
  `salario_base` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`id_cargo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;



CREATE TABLE IF NOT EXISTS `mydb`.`tb_funcionario` (
  `id_funcionario` INT NOT NULL AUTO_INCREMENT,
  `nome_funcionario` VARCHAR(45) NOT NULL,
  `cpf_funcionario` VARCHAR(20) NOT NULL,
  `id_cargo` INT NOT NULL,
  PRIMARY KEY (`id_funcionario`),
  UNIQUE INDEX `cpf_funcionario` (`cpf_funcionario` ASC) VISIBLE,
  INDEX `id_cargo` (`id_cargo` ASC) VISIBLE,
  CONSTRAINT `tb_funcionario_ibfk_1`
    FOREIGN KEY (`id_cargo`)
    REFERENCES `mydb`.`tb_cargo` (`id_cargo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;



CREATE TABLE IF NOT EXISTS `mydb`.`tb_venda` (
  `id_venda` INT NOT NULL AUTO_INCREMENT,
  `id_cliente` INT NOT NULL,
  `id_funcionario` INT NOT NULL,
  `data` DATE NOT NULL,
  `status` ENUM('pendente', 'concluida', 'cancelada') NOT NULL,
  `observacao_venda` VARCHAR(200) NULL DEFAULT NULL,
  PRIMARY KEY (`id_venda`),
  INDEX `id_cliente` (`id_cliente` ASC) VISIBLE,
  INDEX `id_funcionario` (`id_funcionario` ASC) VISIBLE,
  CONSTRAINT `tb_venda_ibfk_1`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `mydb`.`tb_cliente` (`id_cliente`),
  CONSTRAINT `tb_venda_ibfk_2`
    FOREIGN KEY (`id_funcionario`)
    REFERENCES `mydb`.`tb_funcionario` (`id_funcionario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;



CREATE TABLE IF NOT EXISTS `mydb`.`tb_cidade` (
  `id_cidade` INT NOT NULL AUTO_INCREMENT,
  `nome_cidade` VARCHAR(150) NOT NULL,
  PRIMARY KEY (`id_cidade`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;



CREATE TABLE IF NOT EXISTS `mydb`.`tb_bairro` (
  `id_bairro` INT NOT NULL AUTO_INCREMENT,
  `nome_bairro` VARCHAR(100) NOT NULL,
  `id_cidade` INT NOT NULL,
  PRIMARY KEY (`id_bairro`),
  INDEX `id_cidade` (`id_cidade` ASC) VISIBLE,
  CONSTRAINT `tb_bairro_ibfk_1`
    FOREIGN KEY (`id_cidade`)
    REFERENCES `mydb`.`tb_cidade` (`id_cidade`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


CREATE TABLE IF NOT EXISTS `mydb`.`tb_endereco` (
  `id_endereco` INT NOT NULL AUTO_INCREMENT,
  `id_bairro` INT NOT NULL,
  `rua` VARCHAR(150) NOT NULL,
  `numero` VARCHAR(30) NOT NULL,
  `complemento` VARCHAR(150) NULL DEFAULT NULL,
  `id_cliente` INT NOT NULL,
  `prioridade` TINYINT NULL DEFAULT NULL,
  PRIMARY KEY (`id_endereco`),
  INDEX `id_cliente` (`id_cliente` ASC) VISIBLE,
  INDEX `id_bairro` (`id_bairro` ASC) VISIBLE,
  CONSTRAINT `tb_endereco_ibfk_1`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `mydb`.`tb_cliente` (`id_cliente`),
  CONSTRAINT `tb_endereco_ibfk_2`
    FOREIGN KEY (`id_bairro`)
    REFERENCES `mydb`.`tb_bairro` (`id_bairro`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


CREATE TABLE IF NOT EXISTS `mydb`.`tb_agendamento_montagem` (
  `id_agendamento_montagem` INT NOT NULL AUTO_INCREMENT,
  `id_venda` INT NOT NULL,
  `id_funcionario` INT NOT NULL,
  `id_endereco` INT NOT NULL,
  `data` DATE NOT NULL,
  `status_montagem` ENUM('realizado', 'pendente', 'cancelado') NOT NULL,
  `observacao` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id_agendamento_montagem`),
  INDEX `id_venda` (`id_venda` ASC) VISIBLE,
  INDEX `id_funcionario` (`id_funcionario` ASC) VISIBLE,
  INDEX `id_endereco` (`id_endereco` ASC) VISIBLE,
  CONSTRAINT `tb_agendamento_montagem_ibfk_1`
    FOREIGN KEY (`id_venda`)
    REFERENCES `mydb`.`tb_venda` (`id_venda`),
  CONSTRAINT `tb_agendamento_montagem_ibfk_2`
    FOREIGN KEY (`id_funcionario`)
    REFERENCES `mydb`.`tb_funcionario` (`id_funcionario`),
  CONSTRAINT `tb_agendamento_montagem_ibfk_3`
    FOREIGN KEY (`id_endereco`)
    REFERENCES `mydb`.`tb_endereco` (`id_endereco`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;



CREATE TABLE IF NOT EXISTS `mydb`.`tb_categoria` (
  `id_categoria` INT NOT NULL AUTO_INCREMENT,
  `nome_categoria` VARCHAR(50) NOT NULL,
  `descricao_categoria` VARCHAR(150) NULL DEFAULT NULL,
  PRIMARY KEY (`id_categoria`),
  UNIQUE INDEX `nome_categoria` (`nome_categoria` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;



CREATE TABLE IF NOT EXISTS `mydb`.`tb_fornecedor` (
  `id_fornecedor` INT NOT NULL AUTO_INCREMENT,
  `nome_fornecedor` VARCHAR(50) NOT NULL,
  `cpf_cnpj_fornecedor` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id_fornecedor`),
  UNIQUE INDEX `cpf_cnpj_fornecedor` (`cpf_cnpj_fornecedor` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;



CREATE TABLE IF NOT EXISTS `mydb`.`tb_compra` (
  `id_compra` INT NOT NULL AUTO_INCREMENT,
  `id_fornecedor` INT NOT NULL,
  `data` DATE NOT NULL,
  PRIMARY KEY (`id_compra`),
  INDEX `id_fornecedor` (`id_fornecedor` ASC) VISIBLE,
  CONSTRAINT `tb_compra_ibfk_1`
    FOREIGN KEY (`id_fornecedor`)
    REFERENCES `mydb`.`tb_fornecedor` (`id_fornecedor`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;



CREATE TABLE IF NOT EXISTS `mydb`.`tb_entrega` (
  `id_entrega` INT NOT NULL AUTO_INCREMENT,
  `id_venda` INT NOT NULL,
  `id_endereco` INT NOT NULL,
  `data_entrega` DATE NOT NULL,
  `status_entrega` ENUM('pendente', 'entregue', 'cancelado') NULL DEFAULT 'pendente',
  PRIMARY KEY (`id_entrega`),
  INDEX `id_venda` (`id_venda` ASC) VISIBLE,
  INDEX `id_endereco` (`id_endereco` ASC) VISIBLE,
  CONSTRAINT `tb_entrega_ibfk_1`
    FOREIGN KEY (`id_venda`)
    REFERENCES `mydb`.`tb_venda` (`id_venda`),
  CONSTRAINT `tb_entrega_ibfk_2`
    FOREIGN KEY (`id_endereco`)
    REFERENCES `mydb`.`tb_endereco` (`id_endereco`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;



CREATE TABLE IF NOT EXISTS `mydb`.`tb_produto` (
  `id_produto` INT NOT NULL AUTO_INCREMENT,
  `nome_produto` VARCHAR(60) NOT NULL,
  `descricao_produto` VARCHAR(150) NULL DEFAULT NULL,
  `id_categoria` INT NOT NULL,
  `id_fornecedor` INT NOT NULL,
  PRIMARY KEY (`id_produto`),
  UNIQUE INDEX `nome_produto` (`nome_produto` ASC) VISIBLE,
  INDEX `id_categoria` (`id_categoria` ASC) VISIBLE,
  INDEX `id_fornecedor` (`id_fornecedor` ASC) VISIBLE,
  CONSTRAINT `tb_produto_ibfk_1`
    FOREIGN KEY (`id_categoria`)
    REFERENCES `mydb`.`tb_categoria` (`id_categoria`),
  CONSTRAINT `tb_produto_ibfk_2`
    FOREIGN KEY (`id_fornecedor`)
    REFERENCES `mydb`.`tb_fornecedor` (`id_fornecedor`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;



CREATE TABLE IF NOT EXISTS `mydb`.`tb_estoque` (
  `id_estoque` INT NOT NULL AUTO_INCREMENT,
  `id_compra` INT NOT NULL,
  `id_produto` INT NOT NULL,
  `quantidade` INT NOT NULL,
  `preco_estoque` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`id_estoque`),
  INDEX `id_compra` (`id_compra` ASC) VISIBLE,
  INDEX `id_produto` (`id_produto` ASC) VISIBLE,
  CONSTRAINT `tb_estoque_ibfk_1`
    FOREIGN KEY (`id_compra`)
    REFERENCES `mydb`.`tb_compra` (`id_compra`),
  CONSTRAINT `tb_estoque_ibfk_2`
    FOREIGN KEY (`id_produto`)
    REFERENCES `mydb`.`tb_produto` (`id_produto`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;



CREATE TABLE IF NOT EXISTS `mydb`.`tb_pagamento_cliente` (
  `id_pagamento_cliente` INT NOT NULL AUTO_INCREMENT,
  `id_venda` INT NOT NULL,
  `data_pagamento` DATE NOT NULL,
  `forma_pagamento` ENUM('cartao_credito', 'cartao_debito', 'pix', 'boleto', 'dinheiro') NOT NULL,
  `status_pagamento` ENUM('pendente', 'pago', 'cancelado', 'atrasado') NOT NULL,
  PRIMARY KEY (`id_pagamento_cliente`),
  INDEX `id_venda` (`id_venda` ASC) VISIBLE,
  CONSTRAINT `tb_pagamento_cliente_ibfk_1`
    FOREIGN KEY (`id_venda`)
    REFERENCES `mydb`.`tb_venda` (`id_venda`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;



CREATE TABLE IF NOT EXISTS `mydb`.`tb_produto_venda` (
  `id_venda_itens` INT NOT NULL AUTO_INCREMENT,
  `id_venda` INT NOT NULL,
  `id_produto` INT NOT NULL,
  `quantidade` INT NOT NULL,
  `valor` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`id_venda_itens`),
  INDEX `id_venda` (`id_venda` ASC) VISIBLE,
  INDEX `id_produto` (`id_produto` ASC) VISIBLE,
  CONSTRAINT `tb_produto_venda_ibfk_1`
    FOREIGN KEY (`id_venda`)
    REFERENCES `mydb`.`tb_venda` (`id_venda`),
  CONSTRAINT `tb_produto_venda_ibfk_2`
    FOREIGN KEY (`id_produto`)
    REFERENCES `mydb`.`tb_produto` (`id_produto`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;



CREATE TABLE IF NOT EXISTS `mydb`.`tb_receita_extra` (
  `id_receita` INT NOT NULL AUTO_INCREMENT,
  `descricao_receita` VARCHAR(150) NOT NULL,
  `valor` DECIMAL(10,2) NOT NULL,
  `data_recebimento` DATE NOT NULL,
  `id_funcionario` INT NOT NULL,
  PRIMARY KEY (`id_receita`),
  INDEX `id_funcionario` (`id_funcionario` ASC) VISIBLE,
  CONSTRAINT `tb_receita_extra_ibfk_1`
    FOREIGN KEY (`id_funcionario`)
    REFERENCES `mydb`.`tb_funcionario` (`id_funcionario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


USE mydb;


INSERT INTO tb_cargo (nome_cargo, descricao_cargo, salario_base) VALUES
('Vendedor','Responsável pelo atendimento e vendas em loja',2000.00),
('Montador','Realiza montagem de móveis',2200.00),
('Gerente','Gerencia a equipe e as metas da loja',4500.00);

INSERT INTO tb_funcionario (nome_funcionario, cpf_funcionario, id_cargo) VALUES
('José Seben','00000000000',3),
('Caio Macedo','11111111111',1),
('Kaique Lima','22222222222',2),
('Fernando Buligon','33333333333',1);


INSERT INTO tb_cliente (nome_cliente, cpf_cnpj_cliente, telefone_cliente) VALUES
('João Oliveira','00000000000','(00) 00000-0000'),
('Maria Santos','11111111111','(11) 11111-1111'),
('Eduardo Costa','22222222222','(22) 22222-2222'),
('Gabriela Barros','33333333333','(33) 33333-3333'),
('Pedro Cachoeira','44444444444','(44) 44444-4444');


INSERT INTO tb_cidade (nome_cidade) VALUES
('Santa Helena'),
('Sao Clemente'),
('Medianeira'),
('Subsede'),
('Entre Rios');

INSERT INTO tb_bairro (nome_bairro, id_cidade) VALUES
('Centro',1),
('Centro',2),
('Centro',3),
('Centro',4),
('Centro',5);

INSERT INTO tb_endereco (id_bairro, rua, numero, complemento, id_cliente, prioridade) VALUES
(1,'Rua Xaxim','123',NULL,1,1),
(2,'Av. Brasil','321',NULL,2,1),
(3,'Rua Aroeira','231',NULL,3,1),
(4,'Rua Argentina','213',NULL,4,1),
(4,'Rua Argentina','312',NULL,5,1);

INSERT INTO tb_categoria (nome_categoria, descricao_categoria) VALUES
('Ferramentas','Makita, martelo, pá...'),
('Mobilia','Guarda-roupa, mesa, bancada...'),
('Materiais','Areia, pedra, prego...');

INSERT INTO tb_fornecedor (nome_fornecedor, cpf_cnpj_fornecedor) VALUES
('Kaique Madeiras','22222222222222'),
('João das Areias','33333333333333'),
('Pedro Pedradas','44444444444444'),
('Rafael Pregos','55555555555555'),
('Raul Rolamentos','66666666666666');


INSERT INTO tb_produto (nome_produto, descricao_produto, id_categoria, id_fornecedor) VALUES
('Makita 5007N','Serra Circular 7-1/4 1800W',1,1),
('Madeira Pinus','Madeira boa',3,1),
('Mesa Retangular','Mesa de madeira',2,1),
('Pedra Brita','Essa é da boa',3,3),
('Areia Média','Funciona bem',3,2);

INSERT INTO tb_compra (id_fornecedor, data) VALUES
(1,'2025-08-10'),
(1,'2025-08-11'),
(1,'2025-08-12'),
(1,'2025-08-13');


INSERT INTO tb_estoque (id_compra, id_produto, quantidade, preco_estoque) VALUES
(1,1, 50, 793.78),  
(2,2,100, 120.00), 
(2,3, 20, 450.00), 
(3,4,200,  35.00),
(4,5,180,  30.00);

INSERT INTO tb_venda (id_cliente, id_funcionario, data, status, observacao_venda) VALUES
(1,2,'2025-08-15','concluida','Cara saiu feliz'),
(2,2,'2025-08-16','pendente','Aguardando pagamento'),
(3,4,'2025-08-17','concluida','Sucesso'),
(4,4,'2025-08-18','cancelada','Cartão não passou');

INSERT INTO tb_produto_venda (id_venda, id_produto, quantidade, valor) VALUES
(1,1,189,793.78),
(2,1,  1,793.78),
(3,1,  1,793.78),
(4,1,  1,793.78);


INSERT INTO tb_pagamento_cliente (id_venda, data_pagamento, forma_pagamento, status_pagamento) VALUES
(1,'2025-08-15','pix','pago'),
(2,'2025-08-17','boleto','pendente'),
(3,'2025-08-17','boleto','pago'),
(4,'2025-08-18','cartao_credito','cancelado');


INSERT INTO tb_entrega (id_venda, id_endereco, data_entrega, status_entrega) VALUES
(1,1,'2025-08-16','entregue'),
(2,2,'2025-08-20','pendente'), 
(3,3,'2025-08-18','entregue'); 


INSERT INTO tb_agendamento_montagem (id_venda, id_funcionario, id_endereco, data, status_montagem, observacao) VALUES
(1,2,1,'2025-08-16','realizado','Cliente chato'),
(2,2,2,'2025-08-21','pendente','No aguardo da chegada dos materiais'),
(3,2,3,'2025-08-19','realizado','Sucesso');

INSERT INTO tb_receita_extra (descricao_receita, valor, data_recebimento, id_funcionario) VALUES
('Rapaz merece',350.00,'2025-08-19',2),
('Bateu o recorde em montagem de balcão',120.00,'2025-08-19',3),
('Comprou makita',150.00,'2025-08-20',1);
