# Diagramas UML

Os arquivos `.puml` descrevem o protótipo atual. Eles não pressupõem API, servidor ou MySQL.

| Arquivo | Objetivo e elementos | Relação e decisão de modelagem |
|---|---|---|
| `casos-de-uso.puml` | Atores gerente e funcionário e suas ações disponíveis. | Relaciona-se aos RF01–RF16. Busca/filtro é ação independente, pois consultar produtos não a exige. Exportar CSV estende, opcionalmente, a consulta de relatórios. Fornecedor não é ator porque não há interação comprovada no código. |
| `classes.puml` | Entidades de domínio, atributos, multiplicidades e operações relevantes. | Apoia RB01–RB16. `Categoria` é conceitual: no protótipo ela é uma string, mas foi explicitada para orientar o banco futuro. |
| `atividades.puml` | Fluxo de saída, validações, decisões, persistência e confirmação. | Detalha RF10 e RB05–RB08. A confirmação depende de persistência bem-sucedida. |
| `sequencia.puml` | Troca entre usuário, interface, lógica JavaScript e `localStorage`. | Detalha RF10/RB16; distingue êxito e falha de persistência, sem confirmar registro não salvo. `localStorage` substitui temporariamente uma persistência de produção. |

## Nota de consistência com o protótipo

Os diagramas de atividade e sequência expressam a semântica requerida: uma confirmação somente ocorre após persistência bem-sucedida. A implementação atual exibe uma mensagem de erro quando `localStorage` falha, mas o fluxo de submissão não interrompe explicitamente a confirmação nem desfaz a alteração em memória. Como esta etapa é exclusivamente documental, o protótipo não foi modificado; essa divergência deve ser tratada como melhoria técnica futura.

## Como gerar as imagens

1. Instale o PlantUML e uma JVM, ou abra os arquivos em uma extensão PlantUML do VS Code.
2. Abra cada arquivo `.puml` e exporte em PNG ou SVG.
3. Salve os PNGs, sem alterar os nomes, em `docs/uml/imagens/`:

```text
casos-de-uso.png
classes.png
atividades.png
sequencia.png
```

Pela linha de comando, quando o PlantUML estiver instalado, use:

```powershell
plantuml -tpng docs/uml/casos-de-uso.puml docs/uml/classes.puml docs/uml/atividades.puml docs/uml/sequencia.puml
```

Depois, mova os PNGs gerados para `docs/uml/imagens/`. A disponibilidade de Java não valida isoladamente a sintaxe; nesta execução, a validação foi feita temporariamente com o JAR oficial do PlantUML, conforme registrado abaixo.

## Geração realizada nesta etapa

Em 07/11/2026, os quatro diagramas foram validados e renderizados com a distribuição GPL oficial **PlantUML 1.2026.9**, executada temporariamente com Java 17. O JAR foi obtido pela página oficial de downloads do PlantUML e não foi incluído no repositório.

O comando de validação empregado foi:

```powershell
java -jar plantuml-1.2026.9.jar -checkonly docs/uml/casos-de-uso.puml docs/uml/classes.puml docs/uml/atividades.puml docs/uml/sequencia.puml
```

Após a validação, os PNGs foram gerados com `-Sdpi=200` e os SVGs com `-tsvg`, ambos usando `-o imagens`. Os arquivos finais encontram-se em `docs/uml/imagens/`. Os quatro PNGs foram abertos para inspeção visual de legibilidade e de limites da imagem.
