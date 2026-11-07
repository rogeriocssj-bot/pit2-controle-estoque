# Modelo Lógico Relacional

O banco `controle_estoque` possui as tabelas `perfil`, `usuario`, `categoria`, `fornecedor`, `produto` e `movimentacao`.

| Tabela | Chave primária | Chaves estrangeiras | Finalidade |
|---|---|---|---|
| perfil | id_perfil | — | Catálogo de perfis de acesso. |
| usuario | id_usuario | id_perfil | Usuários que registram movimentações. |
| categoria | id_categoria | — | Classificação normalizada de produtos. |
| fornecedor | id_fornecedor | — | Entidade comercial futura, opcional para cada produto. |
| produto | id_produto | id_categoria, id_fornecedor opcional | Catálogo de itens controlados. |
| movimentacao | id_movimentacao | id_produto, id_usuario | Histórico imutável de entradas e saídas. |

## Normalização

O modelo atende à terceira forma normal no escopo proposto. Atributos atômicos são mantidos em colunas próprias (1FN); dados que dependem da identidade do registro dependem da chave primária integral (2FN); e perfil, categoria e fornecedor foram separados para evitar dependências transitivas em usuário e produto (3FN).

Não há tabela `item_movimentacao`: no processo atual, uma movimentação contém somente um produto e uma quantidade. Caso uma futura operação exija um documento com vários itens, a tabela poderia ser desmembrada em cabeçalho e itens.

O saldo não é armazenado em `produto`. As views `v_saldo_produto` e `v_alerta_estoque` o derivam de todas as movimentações, evitando divergência entre uma coluna de saldo e o histórico. A procedure `registrar_movimentacao` é a via prevista para inserções operacionais, pois valida produto ativo, quantidade e saldo para saídas dentro de uma transação.
