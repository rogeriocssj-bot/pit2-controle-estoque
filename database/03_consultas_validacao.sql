-- Execute após 01_criacao_banco.sql e 02_dados_exemplo.sql.
USE controle_estoque;

-- Estrutura e chaves estrangeiras.
SHOW TABLES;
SHOW CREATE TABLE produto;
SHOW CREATE TABLE movimentacao;

-- Saldos calculados: inclui produtos normais, baixos e zerados.
SELECT codigo, nome, saldo_atual, estoque_minimo
FROM v_saldo_produto ORDER BY codigo;

-- Produtos que demandam reposição.
SELECT codigo, nome, saldo_atual, estoque_minimo
FROM v_alerta_estoque ORDER BY saldo_atual, codigo;

-- Histórico de movimentações com produto e usuário responsáveis.
SELECT m.id_movimentacao, m.data_hora, m.tipo, m.quantidade,
       p.codigo AS codigo_produto, p.nome AS produto, u.nome AS usuario
FROM movimentacao m
JOIN produto p ON p.id_produto = m.id_produto
JOIN usuario u ON u.id_usuario = m.id_usuario
ORDER BY m.data_hora, m.id_movimentacao;

-- Teste de regra: saída válida pela procedure (reexecute 02_dados_exemplo para reiniciar o cenário).
-- CALL registrar_movimentacao(1, 2, 'SAIDA', 1, NOW(), 'Teste de saída válida');

-- Testes negativos esperados: execute um por vez; cada um deve retornar erro e não inserir linha.
-- INSERT INTO movimentacao (id_produto,id_usuario,tipo,quantidade,data_hora) VALUES (1,1,'SAIDA',0,NOW());
-- CALL registrar_movimentacao(7, 2, 'SAIDA', 1, NOW(), 'Saldo insuficiente');
-- INSERT INTO movimentacao (id_produto,id_usuario,tipo,quantidade,data_hora) VALUES (999,1,'ENTRADA',1,NOW());
