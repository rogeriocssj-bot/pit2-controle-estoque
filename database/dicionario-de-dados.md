# Dicionário de Dados

Todos os tipos, nulidade, chaves e valores padrão abaixo correspondem a `01_criacao_banco.sql`.

## perfil

| Coluna | Tipo/tamanho | Obrigatória | Chave/padrão | Descrição e restrições |
|---|---|---|---|---|
| id_perfil | TINYINT UNSIGNED | Sim | PK, AUTO_INCREMENT | Identificador do perfil. |
| nome | VARCHAR(30) | Sim | UNIQUE | Nome único do perfil. |
| descricao | VARCHAR(100) | Sim | — | Descrição funcional. |

## usuario

| Coluna | Tipo/tamanho | Obrigatória | Chave/padrão | Descrição e restrições |
|---|---|---|---|---|
| id_usuario | BIGINT UNSIGNED | Sim | PK, AUTO_INCREMENT | Identificador do usuário. |
| id_perfil | TINYINT UNSIGNED | Sim | FK perfil | Perfil associado; exclusão restrita. |
| nome | VARCHAR(120) | Sim | — | Nome de exibição. |
| email | VARCHAR(254) | Sim | UNIQUE | Endereço único do usuário. |
| senha_hash | VARCHAR(255) | Sim | — | Hash de senha; nunca senha em texto puro. |
| ativo | BOOLEAN | Sim | TRUE | Indica disponibilidade do usuário. |
| criado_em | DATETIME | Sim | CURRENT_TIMESTAMP | Data de criação. |

## categoria

| Coluna | Tipo/tamanho | Obrigatória | Chave/padrão | Descrição e restrições |
|---|---|---|---|---|
| id_categoria | BIGINT UNSIGNED | Sim | PK, AUTO_INCREMENT | Identificador. |
| nome | VARCHAR(80) | Sim | UNIQUE | Nome único da categoria. |
| descricao | VARCHAR(255) | Não | NULL | Descrição opcional. |
| ativo | BOOLEAN | Sim | TRUE | Indica categoria ativa. |

## fornecedor

| Coluna | Tipo/tamanho | Obrigatória | Chave/padrão | Descrição e restrições |
|---|---|---|---|---|
| id_fornecedor | BIGINT UNSIGNED | Sim | PK, AUTO_INCREMENT | Identificador. |
| razao_social | VARCHAR(150) | Sim | — | Razão social fictícia. |
| nome_fantasia | VARCHAR(150) | Não | NULL | Nome comercial opcional. |
| cnpj | CHAR(14) | Não | UNIQUE, NULL | CNPJ sem formatação; validação documental/futura. |
| email | VARCHAR(254) | Não | NULL | Contato comercial. |
| telefone | VARCHAR(20) | Não | NULL | Contato comercial. |
| ativo | BOOLEAN | Sim | TRUE | Indica fornecedor ativo. |

## produto

| Coluna | Tipo/tamanho | Obrigatória | Chave/padrão | Descrição e restrições |
|---|---|---|---|---|
| id_produto | BIGINT UNSIGNED | Sim | PK, AUTO_INCREMENT | Identificador. |
| id_categoria | BIGINT UNSIGNED | Sim | FK categoria | Categoria obrigatória; exclusão restrita. |
| id_fornecedor | BIGINT UNSIGNED | Não | FK fornecedor, NULL | Fornecedor preferencial; ao excluir, torna-se NULL. |
| codigo | VARCHAR(40) | Sim | UNIQUE | Código único de produto. |
| nome | VARCHAR(150) | Sim | — | Nome do item. |
| descricao | TEXT | Não | NULL | Descrição opcional. |
| preco | DECIMAL(10,2) | Sim | CHECK >= 0 | Preço unitário não negativo. |
| estoque_minimo | INT UNSIGNED | Sim | 0 | Limite para alerta de reposição. |
| ativo | BOOLEAN | Sim | TRUE | Arquivamento lógico. |
| criado_em | DATETIME | Sim | CURRENT_TIMESTAMP | Criação do cadastro. |
| atualizado_em | DATETIME | Sim | CURRENT_TIMESTAMP / ON UPDATE | Última alteração. |

## movimentacao

| Coluna | Tipo/tamanho | Obrigatória | Chave/padrão | Descrição e restrições |
|---|---|---|---|---|
| id_movimentacao | BIGINT UNSIGNED | Sim | PK, AUTO_INCREMENT | Identificador do histórico. |
| id_produto | BIGINT UNSIGNED | Sim | FK produto | Produto; exclusão restrita. |
| id_usuario | BIGINT UNSIGNED | Sim | FK usuario | Responsável; exclusão restrita. |
| tipo | ENUM | Sim | ENTRADA ou SAIDA | Natureza da movimentação. |
| quantidade | INT UNSIGNED | Sim | CHECK > 0 | Quantidade inteira positiva. |
| data_hora | DATETIME | Sim | — | Momento do evento. |
| observacao | VARCHAR(500) | Não | NULL | Texto livre opcional. |
| criado_em | DATETIME | Sim | CURRENT_TIMESTAMP | Momento da persistência. |

## Views e procedure

`v_saldo_produto` calcula o saldo por produto; `v_alerta_estoque` filtra produtos ativos cujo saldo é menor ou igual ao mínimo. `registrar_movimentacao` valida usuário ativo, quantidade, tipo, produto ativo e saldo antes de inserir a movimentação.
