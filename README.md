# Estoque Fácil — Controle de Estoque

Protótipo web acadêmico do **Projeto Integrador Transdisciplinar em Engenharia de Software II (PIT II)**, evolução do planejamento realizado no PIT I. O objetivo é demonstrar um sistema de controle de estoque para pequenas empresas, com uma experiência navegável e dados fictícios.

## Funcionalidades

- Login e perfis demonstrativos de gerente e funcionário (não é autenticação real);
- Dashboard calculado a partir dos dados armazenados;
- Cadastro, edição, busca, filtros e exclusão lógica de produtos;
- Entradas e saídas com validações de saldo e histórico;
- Alertas automáticos de estoque baixo;
- Relatórios filtráveis e exportação CSV;
- Persistência local por `localStorage`, incluindo restauração explícita dos dados de demonstração.

## Tecnologias e execução

HTML5, CSS3 e JavaScript puro, sem build ou dependências. Abra a pasta em um servidor HTTP estático (por exemplo, a extensão Live Server do VS Code) e acesse `index.html`. O uso por `file://` pode limitar módulos ES em alguns navegadores.

Os dados são fictícios e ficam exclusivamente no navegador na chave versionada `pit2-estoque-v1`; limpar os dados do navegador remove a demonstração. O botão “Restaurar demonstração” recompõe a carga inicial após confirmação.

## Estrutura

`index.html` é a entrada da aplicação. `assets/css/style.css` contém o visual; `assets/js/` separa armazenamento, produtos, movimentações, relatórios e interface. As pastas `docs/uml`, `docs/prototipos`, `database` e `evidencias` estão reservadas para as próximas entregas acadêmicas.

## Limitações e próximos passos

Este é um protótipo front-end: não possui servidor, banco de dados, autenticação, autorização ou proteção de dados reais. O perfil de fornecedor permanece uma entidade de negócio futura, não um usuário autenticado. As próximas fases incluem UML, modelagem e implementação MySQL, dicionário de dados e documentação acadêmica final.

## GitHub Pages

No repositório, acesse **Settings → Pages**, escolha **Deploy from a branch**, selecione a branch publicada e a pasta `/(root)`, e salve. Como os caminhos são relativos e há `.nojekyll`, a aplicação é compatível com GitHub Pages. A URL só deve ser adicionada aqui após confirmação do deploy.
