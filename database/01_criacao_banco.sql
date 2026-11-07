-- MySQL 8.0+ | Estrutura física do banco controle_estoque
CREATE DATABASE IF NOT EXISTS controle_estoque
  CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE controle_estoque;

CREATE TABLE perfil (
  id_perfil TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(30) NOT NULL,
  descricao VARCHAR(100) NOT NULL,
  CONSTRAINT uq_perfil_nome UNIQUE (nome)
) ENGINE=InnoDB;

CREATE TABLE usuario (
  id_usuario BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  id_perfil TINYINT UNSIGNED NOT NULL,
  nome VARCHAR(120) NOT NULL,
  email VARCHAR(254) NOT NULL,
  senha_hash VARCHAR(255) NOT NULL,
  ativo BOOLEAN NOT NULL DEFAULT TRUE,
  criado_em DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT uq_usuario_email UNIQUE (email),
  CONSTRAINT fk_usuario_perfil FOREIGN KEY (id_perfil)
    REFERENCES perfil(id_perfil) ON UPDATE RESTRICT ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE categoria (
  id_categoria BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(80) NOT NULL,
  descricao VARCHAR(255) NULL,
  ativo BOOLEAN NOT NULL DEFAULT TRUE,
  CONSTRAINT uq_categoria_nome UNIQUE (nome)
) ENGINE=InnoDB;

CREATE TABLE fornecedor (
  id_fornecedor BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  razao_social VARCHAR(150) NOT NULL,
  nome_fantasia VARCHAR(150) NULL,
  cnpj CHAR(14) NULL,
  email VARCHAR(254) NULL,
  telefone VARCHAR(20) NULL,
  ativo BOOLEAN NOT NULL DEFAULT TRUE,
  CONSTRAINT uq_fornecedor_cnpj UNIQUE (cnpj)
) ENGINE=InnoDB;

CREATE TABLE produto (
  id_produto BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  id_categoria BIGINT UNSIGNED NOT NULL,
  id_fornecedor BIGINT UNSIGNED NULL,
  codigo VARCHAR(40) NOT NULL,
  nome VARCHAR(150) NOT NULL,
  descricao TEXT NULL,
  preco DECIMAL(10,2) NOT NULL,
  estoque_minimo INT UNSIGNED NOT NULL DEFAULT 0,
  ativo BOOLEAN NOT NULL DEFAULT TRUE,
  criado_em DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  atualizado_em DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT uq_produto_codigo UNIQUE (codigo),
  CONSTRAINT ck_produto_preco_nao_negativo CHECK (preco >= 0),
  CONSTRAINT fk_produto_categoria FOREIGN KEY (id_categoria)
    REFERENCES categoria(id_categoria) ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT fk_produto_fornecedor FOREIGN KEY (id_fornecedor)
    REFERENCES fornecedor(id_fornecedor) ON UPDATE RESTRICT ON DELETE SET NULL,
  INDEX idx_produto_categoria (id_categoria),
  INDEX idx_produto_fornecedor (id_fornecedor),
  INDEX idx_produto_nome (nome)
) ENGINE=InnoDB;

CREATE TABLE movimentacao (
  id_movimentacao BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  id_produto BIGINT UNSIGNED NOT NULL,
  id_usuario BIGINT UNSIGNED NOT NULL,
  tipo ENUM('ENTRADA', 'SAIDA') NOT NULL,
  quantidade INT UNSIGNED NOT NULL,
  data_hora DATETIME NOT NULL,
  observacao VARCHAR(500) NULL,
  criado_em DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT ck_movimentacao_quantidade_positiva CHECK (quantidade > 0),
  CONSTRAINT fk_movimentacao_produto FOREIGN KEY (id_produto)
    REFERENCES produto(id_produto) ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT fk_movimentacao_usuario FOREIGN KEY (id_usuario)
    REFERENCES usuario(id_usuario) ON UPDATE RESTRICT ON DELETE RESTRICT,
  INDEX idx_movimentacao_produto_data (id_produto, data_hora),
  INDEX idx_movimentacao_usuario_data (id_usuario, data_hora),
  INDEX idx_movimentacao_tipo_data (tipo, data_hora)
) ENGINE=InnoDB;

CREATE OR REPLACE VIEW v_saldo_produto AS
SELECT p.id_produto, p.codigo, p.nome, p.estoque_minimo, p.ativo,
       COALESCE(SUM(CASE m.tipo WHEN 'ENTRADA' THEN m.quantidade ELSE -m.quantidade END), 0) AS saldo_atual
FROM produto p
LEFT JOIN movimentacao m ON m.id_produto = p.id_produto
GROUP BY p.id_produto, p.codigo, p.nome, p.estoque_minimo, p.ativo;

CREATE OR REPLACE VIEW v_alerta_estoque AS
SELECT * FROM v_saldo_produto WHERE ativo = TRUE AND saldo_atual <= estoque_minimo;

DELIMITER //
CREATE PROCEDURE registrar_movimentacao(
  IN p_id_produto BIGINT UNSIGNED,
  IN p_id_usuario BIGINT UNSIGNED,
  IN p_tipo VARCHAR(10),
  IN p_quantidade INT,
  IN p_data_hora DATETIME,
  IN p_observacao VARCHAR(500)
)
BEGIN
  DECLARE v_ativo BOOLEAN;
  DECLARE v_saldo BIGINT DEFAULT 0;
  DECLARE v_usuario_ativo BOOLEAN;
  IF p_quantidade IS NULL OR p_quantidade <= 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Quantidade deve ser positiva';
  END IF;
  IF p_tipo NOT IN ('ENTRADA', 'SAIDA') THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tipo de movimentacao invalido';
  END IF;
  SELECT ativo INTO v_usuario_ativo FROM usuario WHERE id_usuario = p_id_usuario;
  IF v_usuario_ativo IS NULL OR v_usuario_ativo = FALSE THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Usuario inexistente ou inativo';
  END IF;
  START TRANSACTION;
  SELECT ativo INTO v_ativo FROM produto WHERE id_produto = p_id_produto FOR UPDATE;
  IF v_ativo IS NULL THEN
    ROLLBACK;
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Produto inexistente';
  END IF;
  IF v_ativo = FALSE THEN
    ROLLBACK;
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Produto inativo';
  END IF;
  SELECT COALESCE(SUM(CASE tipo WHEN 'ENTRADA' THEN quantidade ELSE -quantidade END), 0)
    INTO v_saldo FROM movimentacao WHERE id_produto = p_id_produto;
  IF p_tipo = 'SAIDA' AND p_quantidade > v_saldo THEN
    ROLLBACK;
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Saida superior ao saldo disponivel';
  END IF;
  INSERT INTO movimentacao (id_produto, id_usuario, tipo, quantidade, data_hora, observacao)
  VALUES (p_id_produto, p_id_usuario, p_tipo, p_quantidade, COALESCE(p_data_hora, NOW()), p_observacao);
  COMMIT;
END//
DELIMITER ;
