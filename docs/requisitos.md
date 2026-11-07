# Documento de Requisitos

## 1. Introdução

Este documento formaliza os requisitos do protótipo **Estoque Fácil**, desenvolvido para a Situação-Problema 01 do Projeto Integrador Transdisciplinar em Engenharia de Software II (PIT II). A análise considera o código-fonte disponível nesta revisão e o contexto do PIT I fornecido para o projeto.

## 2. Contextualização e problema

Pequenas empresas precisam acompanhar produtos, níveis de estoque e movimentações para reduzir perdas e apoiar a reposição. O protótipo apresenta uma interface web de demonstração para centralizar essas informações. Não foi disponibilizado, nesta pasta, o documento original do PIT I; por isso, a comparação histórica limita-se ao contexto informado no projeto e aos artefatos atuais.

## 3. Objetivos

**Objetivo geral:** demonstrar uma solução web navegável de controle de estoque para pequenas empresas.

**Objetivos específicos:** permitir a consulta de indicadores; manter produtos demonstrativos; registrar entradas e saídas; sinalizar estoque baixo; apresentar relatórios filtráveis; e preservar o estado demonstrativo no navegador.

## 4. Escopo, público e personas

O escopo atual é um protótipo front-end estático. O público-alvo são gestores e funcionários responsáveis por estoque de pequenas empresas.

- **Gerente/proprietário:** acompanha indicadores e gerencia produtos, movimentações, relatórios e alertas.
- **Funcionário de estoque:** consulta produtos, registra movimentações e consulta alertas; a exclusão de produtos é restringida demonstrativamente.
- **Fornecedor:** persona de negócio prevista, sem portal, login ou interação implementada nesta versão.

## 5. Requisitos funcionais

| Código | Nome | Descrição | Prioridade | Critério de aceitação | Status |
|---|---|---|---|---|---|
| RF01 | Acesso demonstrativo | Permitir acesso por formulário ou atalhos de gerente e funcionário. | Alta | Ao informar campos no formulário ou escolher um perfil, a sessão demonstrativa é criada. | Demonstrativo |
| RF02 | Encerrar sessão | Permitir sair da sessão demonstrativa. | Média | O comando Sair remove a sessão local e retorna ao login. | Implementado |
| RF03 | Dashboard | Exibir totais de produtos, itens, alertas e movimentações recentes. | Alta | Indicadores são calculados dos dados mantidos no estado. | Implementado |
| RF04 | Listar produtos | Exibir produtos ativos e seu saldo calculado. | Alta | A listagem mostra código, categoria, preço, saldo e mínimo. | Implementado |
| RF05 | Buscar e filtrar produtos | Filtrar por nome/código e categoria. | Média | A lista é atualizada conforme busca ou categoria. | Implementado |
| RF06 | Cadastrar produto | Criar produto com dados obrigatórios e saldo inicial zero. | Alta | Dados válidos criam produto com identificador único. | Implementado |
| RF07 | Editar produto | Alterar dados cadastrais sem alterar saldo diretamente. | Alta | O formulário não edita saldo; este é derivado das movimentações. | Implementado |
| RF08 | Excluir/arquivar produto | Impedir exclusão quando há histórico; arquivar quando não há. | Média | Produto com movimentação não é excluído; sem histórico passa a inativo. | Implementado |
| RF09 | Registrar entrada | Registrar quantidade positiva de um produto ativo. | Alta | A movimentação é gravada e aumenta o saldo calculado. | Implementado |
| RF10 | Registrar saída | Registrar saída respeitando o saldo disponível. | Alta | Saída acima do saldo é rejeitada; saída válida reduz o saldo. | Implementado |
| RF11 | Consultar histórico | Exibir movimentações com produto, tipo, quantidade e data. | Média | Histórico é ordenado por data nas telas pertinentes. | Implementado |
| RF12 | Relatórios | Filtrar movimentações por período, tipo e produto. | Média | Resumo e lista refletem os filtros selecionados. | Implementado |
| RF13 | Exportar CSV | Exportar o resultado filtrado do relatório. | Média | Arquivo CSV é gerado no navegador com valores escapados. | Implementado |
| RF14 | Alertas de reposição | Identificar saldo menor ou igual ao estoque mínimo. | Alta | Produtos críticos aparecem na tela de alertas e no dashboard. | Implementado |
| RF15 | Restaurar demonstração | Recriar dados iniciais mediante confirmação. | Média | Após confirmação, estado local é substituído pela carga demonstrativa. | Demonstrativo |
| RF16 | Permissões por perfil | Diferenciar ações administrativas de gerente e funcionário. | Média | Funcionário não recebe controles de cadastro/edição/exclusão de produtos. | Demonstrativo |
| RF17 | Gestão de fornecedor | Permitir operação de fornecedor no sistema. | Baixa | Não aplicável nesta versão; entidade é futura. | Planejado |
| RF18 | Autenticação segura | Validar credenciais reais e controlar acesso no servidor. | Alta | Não implementado; não pode ser considerado controle de acesso. | Pendente |

## 6. Requisitos não funcionais

| Código | Nome | Descrição | Critério de verificação |
|---|---|---|---|
| RNF01 | Plataforma estática | Executar sem processo de build e com caminhos relativos. | Arquivos HTML, CSS e JS são servidos estaticamente. |
| RNF02 | Persistência local | Usar chave versionada `pit2-estoque-v1` e validar estrutura mínima ao carregar. | Inspeção de `storage.js`. |
| RNF03 | Usabilidade | Oferecer rótulos, mensagens de erro, foco visível e controles semânticos básicos. | Inspeção de HTML gerado e CSS. |
| RNF04 | Responsividade | Adaptar navegação, cards e formulários para telas menores. | Inspeção das media queries existentes; não há teste formal registrado. |
| RNF05 | Segurança de conteúdo | Evitar inserir texto de formulários como HTML arbitrário. | Dados exibidos são escapados pela função `esc`. |
| RNF06 | Compatibilidade | Operar em navegador moderno com JavaScript e `localStorage` disponíveis. | Uso de módulos ES, APIs Blob/URL e `localStorage`. |
| RNF07 | Manutenibilidade | Separar persistência, produtos, movimentações, relatórios e interface. | Estrutura de `assets/js`. |

Não foram executadas medições de desempenho, testes de carga ou auditorias de segurança; portanto, não há requisitos mensurados desses tipos confirmados.

## 7. Premissas e limitações

Os dados são fictícios, locais e podem ser apagados pelo usuário. Não há API, banco de dados, sincronização entre dispositivos, recuperação de senha, autenticação ou autorização reais. A data da movimentação é informada pelo navegador e a operação é consistente apenas no estado local. O login é explicitamente demonstrativo.

## 8. Critérios de aceitação gerais

Considera-se o protótipo aceito, no âmbito demonstrativo, quando as telas são navegáveis, os dados iniciais carregam, produtos obedecem às validações, entradas e saídas atualizam o saldo calculado, alertas e relatórios refletem o estado local e a restauração requer confirmação. Produção exigirá os requisitos pendentes de segurança, persistência no servidor e banco de dados.

## 9. Relação PIT I e PIT II

O PIT I forneceu a proposta de controle de estoque, perfis e funcionalidades esperadas. O PIT II materializa uma interface navegável com regras demonstrativas, persistência local e documentação formal. Permanecem para etapas posteriores a modelagem conceitual/lógica/física de banco, uma API, autenticação real, fornecedor como participante operacional e documentação acadêmica final.
