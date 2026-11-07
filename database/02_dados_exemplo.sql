-- Dados inteiramente fictícios para demonstração acadêmica.
USE controle_estoque;

INSERT INTO perfil (id_perfil, nome, descricao) VALUES
  (1, 'GERENTE', 'Gerencia produtos, relatórios e movimentações'),
  (2, 'FUNCIONARIO', 'Consulta estoque e registra movimentações');

-- senha_hash contém apenas valores demonstrativos, não senhas reais.
INSERT INTO usuario (id_usuario, id_perfil, nome, email, senha_hash) VALUES
  (1, 1, 'Mariana Costa', 'mariana.costa@exemplo.local', '$2y$10$dadosFicticiosNaoUtilizarEmProducao000000000000000000000'),
  (2, 2, 'João Silva', 'joao.silva@exemplo.local', '$2y$10$dadosFicticiosNaoUtilizarEmProducao000000000000000000001'),
  (3, 2, 'Ana Lima', 'ana.lima@exemplo.local', '$2y$10$dadosFicticiosNaoUtilizarEmProducao000000000000000000002');

INSERT INTO categoria (id_categoria, nome, descricao) VALUES
  (1, 'Alimentos', 'Itens alimentícios'), (2, 'Bebidas', 'Bebidas diversas'),
  (3, 'Limpeza', 'Produtos de limpeza'), (4, 'Papelaria', 'Materiais de papelaria'),
  (5, 'Eletrônicos', 'Acessórios elétricos e eletrônicos'), (6, 'Utilidades', 'Utilidades gerais');

INSERT INTO fornecedor (id_fornecedor, razao_social, nome_fantasia, cnpj, email, telefone) VALUES
  (1, 'Distribuidora Alfa LTDA', 'Distribuidora Alfa', '11111111000111', 'contato@alfa.exemplo.local', '85900000001'),
  (2, 'Comercial Beta LTDA', 'Comercial Beta', '22222222000122', 'vendas@beta.exemplo.local', '85900000002'),
  (3, 'Suprimentos Gama LTDA', 'Suprimentos Gama', '33333333000133', 'atendimento@gama.exemplo.local', '85900000003');

INSERT INTO produto (id_produto, id_categoria, id_fornecedor, codigo, nome, descricao, preco, estoque_minimo) VALUES
  (1,1,1,'P001','Café torrado 500g','Produto demonstrativo',18.90,12),
  (2,1,1,'P002','Arroz tipo 1 5kg','Produto demonstrativo',29.50,8),
  (3,1,1,'P003','Açúcar refinado 1kg','Produto demonstrativo',5.70,10),
  (4,2,2,'P004','Água mineral 500ml','Produto demonstrativo',2.50,24),
  (5,2,2,'P005','Refrigerante cola 2L','Produto demonstrativo',9.90,10),
  (6,3,2,'P006','Detergente neutro','Produto demonstrativo',3.80,15),
  (7,3,2,'P007','Papel toalha','Produto demonstrativo',7.40,8),
  (8,4,3,'P008','Caderno universitário','Produto demonstrativo',16.90,10),
  (9,4,3,'P009','Caneta azul','Produto demonstrativo',2.90,20),
  (10,5,3,'P010','Pilhas AA (4 un.)','Produto demonstrativo',14.50,6),
  (11,5,3,'P011','Lâmpada LED 9W','Produto demonstrativo',12.90,5),
  (12,6,3,'P012','Sacola reutilizável','Produto demonstrativo',8.50,10);

-- Entradas iniciais e histórico coerente; o saldo é derivado destas linhas.
INSERT INTO movimentacao (id_movimentacao, id_produto, id_usuario, tipo, quantidade, data_hora, observacao) VALUES
  (1,1,1,'ENTRADA',30,'2026-10-01 08:00:00','Estoque inicial'),
  (2,2,1,'ENTRADA',21,'2026-10-01 08:05:00','Estoque inicial'),
  (3,3,1,'ENTRADA',10,'2026-10-01 08:10:00','Estoque inicial'),
  (4,4,1,'ENTRADA',24,'2026-10-01 08:15:00','Estoque inicial'),
  (5,5,1,'ENTRADA',11,'2026-10-01 08:20:00','Estoque inicial'),
  (6,6,1,'ENTRADA',22,'2026-10-01 08:25:00','Estoque inicial'),
  (7,7,1,'ENTRADA',8,'2026-10-01 08:30:00','Estoque inicial'),
  (8,8,1,'ENTRADA',14,'2026-10-01 08:35:00','Estoque inicial'),
  (9,9,1,'ENTRADA',55,'2026-10-01 08:40:00','Estoque inicial'),
  (10,10,1,'ENTRADA',6,'2026-10-01 08:45:00','Estoque inicial'),
  (11,11,1,'ENTRADA',17,'2026-10-01 08:50:00','Estoque inicial'),
  (12,12,1,'ENTRADA',9,'2026-10-01 08:55:00','Estoque inicial'),
  (13,1,2,'ENTRADA',10,'2026-10-05 09:00:00','Reposição demonstrativa'),
  (14,2,2,'SAIDA',3,'2026-10-12 14:15:00','Venda demonstrativa'),
  (15,5,2,'SAIDA',4,'2026-10-18 10:30:00','Venda demonstrativa'),
  (16,10,3,'SAIDA',2,'2026-10-22 16:40:00','Uso interno demonstrativo'),
  (17,7,2,'SAIDA',8,'2026-10-25 11:00:00','Venda demonstrativa'),
  (18,4,1,'ENTRADA',24,'2026-11-01 08:20:00','Reposição demonstrativa');
