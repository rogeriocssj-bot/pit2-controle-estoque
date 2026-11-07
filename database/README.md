# Banco de Dados — Controle de Estoque

## Objetivo

Esta pasta contém a proposta de modelagem e implementação física em **MySQL 8.0+** para a evolução do protótipo Estoque Fácil. Ela é independente do `localStorage` usado pela interface atual: não há API, back-end ou integração automática nesta etapa.

## Modelos e decisões

- `modelo-conceitual.puml`: entidades, atributos e cardinalidades do domínio.
- `modelo-logico.puml` e `modelo-logico.md`: transformação relacional e justificativa de normalização.
- `dicionario-de-dados.md`: descrição exata das estruturas físicas.

O saldo não é persistido em `produto`. É calculado a partir do histórico em `v_saldo_produto`; `v_alerta_estoque` identifica o estoque baixo. Essa decisão evita redundância e inconsistência. `ItemMovimentacao` não foi criado porque cada movimentação atual contém apenas um produto. Fornecedor é entidade de negócio preparada para evolução e é opcional no produto.

As inserções operacionais devem usar a procedure `registrar_movimentacao`, que valida usuário ativo, quantidade e tipo, abre uma transação, bloqueia o produto consultado e valida status do produto e saldo para saídas. O banco não deve conceder inserção direta em `movimentacao` ao usuário da futura aplicação; isso mantém a regra de saída acima do saldo centralizada na procedure.

## Arquivos e ordem de execução

1. `01_criacao_banco.sql` — cria banco, tabelas, índices, views e procedure.
2. `02_dados_exemplo.sql` — insere dados estritamente fictícios e coerentes.
3. `03_consultas_validacao.sql` — contém consultas de inspeção e testes negativos comentados.

No terminal MySQL, a partir da raiz do repositório:

```powershell
mysql -u root -p < database/01_criacao_banco.sql
mysql -u root -p < database/02_dados_exemplo.sql
mysql -u root -p < database/03_consultas_validacao.sql
```

No MySQL Workbench, abra os três scripts e execute-os nessa ordem. Os testes negativos estão comentados no terceiro script para não interromper a validação normal; descomente um por vez para observar os erros esperados.

## Consultas de validação

O terceiro script lista tabelas, mostra DDL, consulta saldos, alertas e histórico. Após a carga, espera-se encontrar produtos normais, em nível mínimo/baixo e um produto zerado. A integridade de chave estrangeira, código único, preço não negativo e quantidade positiva é definida por constraints; a saída acima do saldo é protegida pela procedure.

## Diferença entre MySQL e localStorage

O protótipo guarda um objeto local por navegador, contém uma sessão demonstrativa e calcula saldo em JavaScript. O banco é uma proposta persistente multiusuário: normaliza categorias/perfis/fornecedores, armazena hashes de senha e mantém relacionamentos referenciais. A migração efetiva exigirá uma API, autenticação real, autorização e estratégia de migração de dados; nada disso é implementado aqui.

## Diagramas

Com PlantUML instalado, gere imagens dos modelos com:

```powershell
plantuml -tpng database/modelo-conceitual.puml database/modelo-logico.puml
```

Também é possível executar `java -jar plantuml.jar -tpng` com a distribuição oficial do PlantUML. As imagens não são necessárias para executar os scripts SQL.

## Limitações e próximos passos

Os scripts precisam ser executados em um MySQL 8.0+ de desenvolvimento para comprovação dinâmica. Não use um banco de produção. Próximas etapas: validar em servidor isolado, registrar evidências reais em `evidencias/banco/`, criar API segura, implementar autenticação e conectar uma futura interface ao banco.
