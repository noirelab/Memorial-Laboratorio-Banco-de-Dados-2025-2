USE mydb;

INSERT INTO tb_cargo (id_cargo, nome_cargo, descricao_cargo, salario_base) VALUES
(1,'Vendedor','Responsável pelo atendimento e vendas em loja',2000.00),
(2,'Montador','Realiza montagem de móveis',2200.00),
(3,'Gerente','Gerencia a equipe e as metas da loja',4500.00);

INSERT INTO tb_funcionario (id_funcionario, nome_funcionario, cpf_funcionario, id_cargo) VALUES
(1,'José Seben','00000000000',3),
(2,'Caio Macedo','11111111111',1),
(3,'Kaique Lima','22222222222',2),
(4,'Fernando Buligon','33333333333',1);

INSERT INTO tb_cliente (id_cliente, nome_cliente, cpf_cnpj_cliente, telefone_cliente) VALUES
(1,'João Oliveira','00000000000','(00) 00000-0000'),
(2,'Maria Santos','11111111111','(11) 11111-1111'),
(3,'Eduardo Costa','22222222222','(22) 22222-2222'),
(4,'Gabriela Barros','33333333333','(33) 33333-3333'),
(5,'Pedro Cachoeira','44444444444','(44) 44444-4444');

INSERT INTO tb_cidade (id_cidade, nome_cidade) VALUES
(1,'Santa Helena'),
(2,'Sao Clemente'),
(3,'Medianeira'),
(4,'Subsede'),
(5,'Entre Rios');

INSERT INTO tb_bairro (id_bairro, nome_bairro, id_cidade) VALUES
(1,'Centro',1),
(2,'Centro',2),
(3,'Centro',3),
(4,'Centro',4),
(5,'Centro',5);

INSERT INTO tb_endereco (id_endereco, id_bairro, logradouro, numero, complemento, id_cliente, prioridade) VALUES
(1,1,'Rua Xaxim','123',NULL,1,1),
(2,2,'Av. Brasil','321',NULL,2,1),
(3,3,'Rua Aroeira','231',NULL,3,1),
(4,4,'Rua Argentina','213',NULL,4,1),
(5,4,'Rua Argentina','312',NULL,5,1);

INSERT INTO tb_categoria (id_categoria, nome_categoria, descricao_categoria) VALUES
(1,'Ferramentas','Makita, martelo, pá...'),
(2,'Mobilia','Guarda-roupa, mesa, bancada...'),
(3,'Materiais','Areia, pedra, prego...');

INSERT INTO tb_fornecedor (id_fornecedor, nome_fornecedor, cpf_cnpj_fornecedor) VALUES
(1,'Kaique Madeiras','22222222222222'),
(2,'João das Areias','33333333333333'),
(3,'Pedro Pedradas','44444444444444'),
(4,'Rafael Pregos','55555555555555'),
(5,'Raul Rolamentos','66666666666666');

INSERT INTO tb_compra (id_compra, id_fornecedor, data) VALUES
(1,1,'2025-08-10'),
(2,1,'2025-08-11'),
(3,1,'2025-08-12'),
(4,1,'2025-08-13');

INSERT INTO tb_produto (id_produto, nome_produto, descricao_produto, requer_montagem, id_categoria) VALUES
(1,'Makita 5007N','Serra Circular 7-1/4 1800W',0,1),
(2,'Madeira Pinus','Madeira boa',0,3),
(3,'Mesa Retangular','Mesa de madeira',1,2),
(4,'Pedra Brita','Essa é da boa',0,3),
(5,'Areia Média','Funciona bem',0,3);

INSERT INTO tb_estoque (id_estoque, id_compra, id_produto, quantidade, preco_estoque) VALUES
(1,1,1, 50, 793.78),
(2,2,2,100, 120.00),
(3,2,3, 20, 450.00),
(4,3,4,200,  35.00),
(5,4,5,180,  30.00);

INSERT INTO tb_venda (id_venda, id_cliente, id_funcionario, data, status, observacao_venda) VALUES
(1,1,2,'2025-08-15','concluida','Cara saiu feliz'),
(2,2,2,'2025-08-16','pendente','Aguardando pagamento'),
(3,3,4,'2025-08-17','concluida','Sucesso'),
(4,4,4,'2025-08-18','cancelada','Cartão não passou');

INSERT INTO tb_produto_venda (id_venda_itens, id_venda, id_estoque, quantidade, valor) VALUES
(1,1,1,189,793.78),
(2,2,1,  1,793.78),
(3,3,1,  1,793.78),
(4,4,1,  1,793.78);

INSERT INTO tb_pagamento_cliente (id_pagamento_cliente, id_venda, data_pagamento, forma_pagamento, status_pagamento) VALUES
(1,1,'2025-08-15','pix','pago'),
(2,2,'2025-08-17','boleto','pendente'),
(3,3,'2025-08-17','boleto','pago'),
(4,4,'2025-08-18','cartao_credito','cancelado');

INSERT INTO tb_entrega (id_entrega, id_venda, id_endereco, data_entrega, status_entrega) VALUES
(1,1,1,'2025-08-16','entregue'),
(2,2,2,'2025-08-20','pendente'),
(3,3,3,'2025-08-18','entregue');

INSERT INTO tb_agendamento_montagem (id_agendamento_montagem, id_venda_itens, id_funcionario, id_endereco, data, status_montagem, observacao) VALUES
(1,1,2,1,'2025-08-16','realizado','Cliente chato'),
(2,2,2,2,'2025-08-21','pendente','No aguardo da chegada dos materiais'),
(3,3,2,3,'2025-08-19','realizado','Sucesso');

INSERT INTO tb_receita_extra (id_receita, descricao_receita, valor, data_recebimento, id_funcionario) VALUES
(1,'Rapaz merece',350.00,'2025-08-19',2),
(2,'Bateu o recorde em montagem de balcão',120.00,'2025-08-19',3),
(3,'Comprou makita',150.00,'2025-08-20',1);