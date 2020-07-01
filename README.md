# Índice de Condições Financeiras (ICF)

[TOC]

## Apresentação

Construção de um Índice de Condições Financeiras com base em Bacen (2020).

## Componentes do ICF

Dados utilizados na nota do Banco Central:

**Tabela 1: Componentes do ICF**

| Grupos | Nomes               | Séries                                                                       | Pesos |
|--------|---------------------|------------------------------------------------------------------------------|-------|
| 1      | Juros Brasil        | Taxas de juros (Swap Pré-DI) de 1 e 5 anos                                   |  0,34 |
| 2      | Juros exterior      | Taxas de juros dos EUA, Reino Unido, Alemanha e Japão (3 meses, 2 e 10 anos) |  0,33 |
| 3      | Risco               | CDS Brasil (5 anos) e VIX                                                    |  0,18 |
| 4      | Moedas              | US dollar indexes (desenvolvidos, emergentes), taxa de câmbio (R\$/US\$)       |  0,20 |
| 5      | Petróleo            | Cotações em US$ do barril de petróleo (WTI e Brent)                          |  0,23 |
| 6      | Commodities         | Índices de commodities CRB (foodstuffs, metals)                              | -0,13 |
| 7      | Mercado de capitais | Índices de ações MSCI (desenvolvidos, emergentes) e Ibovespa                 | -0,15 |

## Metodologia para construção do ICF

Etapas para construção do ICF conforme sugerido pelo Bacen (2020):

1. remoção da tendência das séries dos grupos 4 até 7;
2. padronização de todas as séries, de modo a apresentarem média zero e variância unitária;
3. extração do primeira componente principal de cada grupo de variáveis;
4. cálculo da média ponderada das referidas componentes principais utilizando os pesos da Tabela 1;
5. definição do ICF como a média ponderada da etapa anterior, padronizada para apresentar média zero e variância unitária na amostra considerada.

Os pesos apresentados provêm de regressões capturando a capacidade de os componentes principais de cada grupo trazerem informação sobre a variação futura do Índice de Atividade Econômica do Banco Central (IBC-Br).

As regressões têm a taxa de variação em seis meses do IBC-Br como variável dependente. Como regressores, utilizam-se as primeiras componentes principais dos grupos, um intercepto e uma variável dummy para a crise global de 2008.

## Replicação do ICF

### Estratégias a serem adotadas

1. Utilizar inicialmente os pesos calculados pelo Bacen (2020);
2. Fazer o próprio cálculo dos pesos.

### Códigos das séries

| Série                                         |   Código    |
| :-------------------------------------------- | :---------: |
| Swap Pré-DI 1 ano                             | juros1a_br  |
| Swap Pré-DI 5 anos                            | juros5a_br  |
| Juros EUA 3 meses                             | juros3m_us  |
| Juros EUA 2 anos                              | juros2a_us  |
| Juros EUA 10 anos                             | juros10a_us |
| Juros Reino Unido 3 meses                     | juros3m_uk  |
| Juros Reino Unido 2 anos                      | juros2a_uk  |
| Juros Reino Unido 10 anos                     | juros10a_uk |
| Juros Alemanha 3 meses                        | juros3m_de  |
| Juros Alemanha 2 anos                         | juros2a_de  |
| Juros Alemanha 10 anos                        | juros10a_de |
| Juros Japão 3 meses                           | juros3m_jp  |
| Juros Japão 2 anos                            | juros2a_jp  |
| Juros Japão 10 anos                           | juros10a_jp |
| CDS Brasil (5 anos)                           |   cds_br    |
| VIX                                           |     vix     |
| US dollar indexes (desenvolvidos)             | dxy_desenv  |
| US dollar indexes (emergentes)                |  dxy_emerg  |
| Taxa de câmbio (R\$/US\$)                     |   cambio    |
| Cotações em US$ do barril de petróleo (WTI)   | petro_brent |
| Cotações em US$ do barril de petróleo (Brent) |  petro_wti  |
| Índices de commodities CRB (foodstuffs)       |  crb_metal  |
| Índices de commodities CRB (metals)           |  crb_food   |
| Índices de ações MSCI (desenvolvidos)         | msci_desenv |
| Índices de ações MSCI (emergentes)            | msci_emerg  |
| Ibovespa                                      |  ibovespa   |

### Estado dos dados

| Série                                         | Status | Fonte     |
|-----------------------------------------------|--------|-----------|
| Swap Pré-DI 1 ano                             | ok!    | Bloomberg |
| Swap Pré-DI 5 anos                            | ok!    | Bloomberg |
| Juros EUA 3 meses                             | ok!    | Bloomberg |
| Juros EUA 2 anos                              | ok!    | Bloomberg |
| Juros EUA 10 anos                             | ok!    | Bloomberg |
| Juros Reino Unido 3 meses                     | ok!    | Bloomberg |
| Juros Reino Unido 2 anos                      | ok!    | Bloomberg |
| Juros Reino Unido 10 anos                     | ok!    | Bloomberg |
| Juros Alemanha 3 meses                        | ok!    | Bloomberg |
| Juros Alemanha 2 anos                         | ok!    | Bloomberg |
| Juros Alemanha 10 anos                        | ok!    | Bloomberg |
| Juros Japão 3 meses                           | ok!    | Bloomberg |
| Juros Japão 2 anos                            | ok!    | Bloomberg |
| Juros Japão 10 anos                           | ok!    | Bloomberg |
| CDS Brasil (5 anos)                           | ok!    | Bloomberg |
| VIX                                           | ok!    | Bloomberg |
| US dollar indexes (desenvolvidos)             | ok!    | Bloomberg |
| US dollar indexes (emergentes)                | ok!    | Bloomberg |
| Taxa de câmbio (R\$/US\$)                     | ok!    | Bloomberg |
| Cotações em US$ do barril de petróleo (WTI)   | ok!    | Bloomberg |
| Cotações em US$ do barril de petróleo (Brent) | ok!    | Bloomberg |
| Índices de commodities CRB (foodstuffs)       | ok!    | Bloomberg |
| Índices de commodities CRB (metals)           | ok!    | Bloomberg |
| Índices de ações MSCI (desenvolvidos)         | ok!    | Bloomberg |
| Índices de ações MSCI (emergentes)            | ok!    | Bloomberg |
| Ibovespa                                      | ok!    | Bloomberg |

## FactoMineR

Retorna uma lista com os seguinte valores:

- `eig` - uma matriz contendo todos os autovalores, o percentual da variância e o percentual acumulado da variância;
- `var` - uma lista de matrizes contendo todos os resultados para as variáveis ativas (coordenadas, correlação entre variáveis e eixos, cosseno quadrado, contribuição);
- `ind` - uma lista de matrizes contendo todos os resultados para os indivíduos ativos (coordenadas, cosseno quadrado, contribuições);
- `ind.sup` - uma lista de matrizes contendo todos os resultados para os indivíduos suplementares (coordenadas, cosseno quadrado;)
- `quanti.sup` - uma lista de matrizes contendo todos os resultados das variáveis quantitativas suplementares (coordenadas, correlação entre variáveis e eixos);
- `quali.sup` - uma lista de matrizes contendo todos os resultados das variáveis categóricas suplementares (coordenadas de cada categoria de cada variável, v.test que é um critério de uma distribuição normal, eta2 que é o coeficiente de correlação quadrada entre uma variável qualitativa e uma dimensão).