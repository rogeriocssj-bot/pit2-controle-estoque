# Evolução do PIT I para o PIT II

O PIT I definiu, conforme o contexto disponibilizado, uma proposta de sistema de controle de estoque para pequenas empresas, incluindo login, dashboard, produtos, movimentações, relatórios, alertas e perfis. O documento original daquele projeto não está disponível nesta pasta; logo, esta análise não declara ter auditado seus artefatos.

No PIT II, a proposta foi convertida em um protótipo web navegável, composto por HTML, CSS e JavaScript puro. A interface passou a apresentar navegação lateral, dashboard calculado, formulários, tabelas, modais, mensagens de validação e adaptação para telas menores. A camada local de armazenamento mantém produtos, movimentações e sessão demonstrativa com dados fictícios.

As validações materializadas incluem código único, obrigatoriedade de campos, valores não negativos, quantidade positiva, bloqueio de saída acima do saldo, alerta por estoque mínimo e impedimento de exclusão de produto com histórico. Os dados de saldo são calculados a partir do saldo inicial e das movimentações.

O avanço documental desta etapa formaliza requisitos, regras de negócio, histórias de usuário e diagramas UML coerentes com o protótipo. As limitações permanecem relevantes: não há banco de dados, API, autenticação real, permissões protegidas no servidor, gestão operacional de fornecedor ou sincronização de dados. A próxima etapa acadêmica deve detalhar o modelo de dados, o dicionário de dados e a implementação física do banco, antes da integração com back-end.
