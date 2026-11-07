# Histórias de Usuário

| ID | Persona | História | Prioridade | Critérios de aceitação | RF |
|---|---|---|---|---|---|
| HU01 | Gerente | Como gerente, quero entrar em uma sessão demonstrativa para acessar o sistema. | Alta | Perfil de gerente inicia sessão local. | RF01 |
| HU02 | Funcionário | Como funcionário, quero entrar com perfil demonstrativo para registrar operações permitidas. | Alta | Perfil de funcionário inicia sessão local. | RF01 |
| HU03 | Usuário | Como usuário, quero sair da demonstração para encerrar a sessão local. | Média | Sair retorna ao login. | RF02 |
| HU04 | Gerente | Como gerente, quero consultar indicadores para acompanhar o estoque. | Alta | Dashboard mostra totais calculados. | RF03 |
| HU05 | Funcionário | Como funcionário, quero consultar produtos para localizar itens disponíveis. | Alta | Lista exibe produtos ativos e saldo. | RF04 |
| HU06 | Usuário | Como usuário, quero buscar produtos por nome ou código para encontrá-los rapidamente. | Média | Busca atualiza a lista. | RF05 |
| HU07 | Gerente | Como gerente, quero filtrar produtos por categoria para organizar a consulta. | Média | Categoria limita a listagem. | RF05 |
| HU08 | Gerente | Como gerente, quero cadastrar produtos para ampliar o catálogo controlado. | Alta | Campos válidos criam novo produto. | RF06 |
| HU09 | Gerente | Como gerente, quero editar dados de produto sem manipular diretamente seu saldo. | Alta | Saldo é somente informativo no formulário. | RF07 |
| HU10 | Gerente | Como gerente, quero arquivar produto sem histórico para manter o catálogo organizado. | Média | Produto sem histórico deixa de aparecer como ativo. | RF08 |
| HU11 | Funcionário | Como funcionário, quero registrar entrada para atualizar a disponibilidade. | Alta | Quantidade positiva aumenta saldo. | RF09 |
| HU12 | Funcionário | Como funcionário, quero registrar saída para refletir retirada de itens. | Alta | Saída válida reduz saldo e entra no histórico. | RF10 |
| HU13 | Funcionário | Como funcionário, quero ser avisado quando a saída superar o saldo. | Alta | Operação é recusada com mensagem clara. | RF10 |
| HU14 | Gerente | Como gerente, quero consultar o histórico para auditar movimentações demonstrativas. | Média | Tela exibe produto, tipo, quantidade e data. | RF11 |
| HU15 | Gerente | Como gerente, quero filtrar relatórios para analisar um período ou produto. | Média | Filtros atualizam totais e lista. | RF12 |
| HU16 | Gerente | Como gerente, quero exportar o relatório para compartilhar a análise. | Média | CSV é baixado no navegador. | RF13 |
| HU17 | Funcionário | Como funcionário, quero consultar alertas para identificar reposições necessárias. | Alta | Produtos críticos são destacados. | RF14 |
| HU18 | Gerente | Como gerente, quero restaurar a demonstração para reiniciar os dados de teste. | Baixa | Sistema solicita confirmação antes de restaurar. | RF15 |
