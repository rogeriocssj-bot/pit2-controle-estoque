# Regras de Negócio

As regras abaixo foram identificadas no código do protótipo e no escopo informado. “Demonstrativa” indica execução local, sem garantia transacional de servidor.

| Código | Regra | Situação |
|---|---|---|
| RB01 | O código do produto deve ser único entre produtos cadastrados. | Implementada: validação no cadastro/edição. |
| RB02 | Código, nome e categoria são obrigatórios no cadastro/edição. | Implementada. |
| RB03 | Preço não pode ser negativo; estoque mínimo deve ser inteiro não negativo. | Implementada. |
| RB04 | O saldo não é editado no produto; é calculado por saldo inicial mais entradas menos saídas. | Implementada. |
| RB05 | Uma movimentação deve referir-se a produto ativo e possuir quantidade inteira positiva. | Implementada. |
| RB06 | Entrada acrescenta a quantidade ao saldo calculado. | Implementada. |
| RB07 | Saída reduz a quantidade do saldo calculado. | Implementada. |
| RB08 | Saída não pode superar o saldo disponível. | Implementada. |
| RB09 | Cada movimentação armazena tipo, produto, quantidade, data, observação e usuário demonstrativo. | Implementada. |
| RB10 | Produto com saldo menor ou igual ao estoque mínimo exige reposição. | Implementada. |
| RB11 | Exclusão de produto com histórico é bloqueada; sem histórico, o produto é desativado logicamente. | Implementada. |
| RB12 | Somente o gerente possui controles administrativos de produto; a separação é visual e demonstrativa. | Implementada parcialmente: não há proteção no servidor. |
| RB13 | A restauração de dados demonstrativos exige confirmação. | Implementada. |
| RB14 | Valores monetários e datas são apresentados em padrão brasileiro quando exibidos pela interface. | Implementada na interface. |
| RB15 | Fornecedor não participa como usuário do protótipo atual. | Planejada para evolução do domínio. |
| RB16 | A coerência de saldo e histórico ocorre no estado em memória antes da gravação em `localStorage`. | Demonstrativa; não há transação concorrente ou servidor. |
