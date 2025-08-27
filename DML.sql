
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
