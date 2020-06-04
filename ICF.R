#### Define working directory ####

switch (Sys.info()["sysname"],
    Linux = setwd("~/Desenvolvimento/SPE/Indicador de Condições Financeiras"),
    Darwin = setwd("~/Documents/GitHub/Indicador de Condições Financeiras"),
    Windows = setwd("~/Documents/Indicador de Condições Financeiras")
)

#### Load packages and functions #### 

suppressPackageStartupMessages(
    library(xts)
)

source("Scripts/Functions.R", encoding = "utf8")

#### Import data ####

#| Grupos | Nomes               | Séries                                                                       | Pesos |
#|--------|---------------------|------------------------------------------------------------------------------|-------|
#| 1      | Juros Brasil        | Taxas de juros (Swap Pré-DI) de 1 e 5 anos                                   |  0,34 |
#| 2      | Juros exterior      | Taxas de juros dos EUA, Reino Unido, Alemanha e Japão (3 meses, 2 e 10 anos) |  0,33 |
#| 3      | Risco               | CDS Brasil (5 anos) e VIX                                                    |  0,18 |
#| 4      | Moedas              | US dollar indexes (desenvolvidos, emergentes), taxa de câmbio (R$/US$)       |  0,20 |
#| 5      | Petróleo            | Cotações em US$ do barril de petróleo (WTI e Brent)                          |  0,23 |
#| 6      | Commodities         | Índices de commodities CRB (foodstuffs, metals)                              | -0,13 |
#| 7      | Mercado de capitais | Índices de ações MSCI (desenvolvidos, emergentes) e Ibovespa                 | -0,15 |

| Séries                                        | Status | Fonte |
|-----------------------------------------------|--------|-------|
| Swap Pré-DI 1 ano                             |        |       |
| Swap Pré-DI 5 anos                            |        |       |
| Juros EUA 3 meses                             |        |       |
| Juros EUA 2 anos                              |        |       |
| Juros EUA 10 anos                             |        |       |
| Juros Reino Unido 3 meses                     |        |       |
| Juros Reino Unido 2 anos                      |        |       |
| Juros Reino Unido 10 anos                     |        |       |
| Juros Alemanha 3 meses                        |        |       |
| Juros Alemanha 2 anos                         |        |       |
| Juros Alemanha 10 anos                        |        |       |
| Juros Japão 3 meses                           |        |       |
| Juros Japão 2 anos                            |        |       |
| Juros Japão 10 anos                           |        |       |
| CDS Brasil (5 anos)                           |        |       |
| VIX                                           |        |       |
| US dollar indexes (desenvolvidos)             |        |       |
| US dollar indexes (emergentes)                |        |       |
| Taxa de câmbio (R$/US$)                       |        |       |
| Cotações em US$ do barril de petróleo (WTI)   |        |       |
| Cotações em US$ do barril de petróleo (Brent) |        |       |
| Índices de commodities CRB (foodstuffs)       |        |       |
| Índices de commodities CRB (metals)           |        |       |
| Índices de ações MSCI (desenvolvidos)         |        |       |
| Índices de ações MSCI (emergentes)            |        |       |
| Ibovespa                                      |        |       |

    
    
    
    




























#### Data transformation ####

#### Index construction ####

#### Plots #####

source("Scripts/Plots.R", encoding = "utf8") 

#### Tables #### 

source("Scripts/Tables.R", encoding = "utf8") 

#### Save data for Markdown rendering #### 

save.image(file = "Dados/Data & Functions.RData") 

#### Render R Markdown ####

markdown_custom_css <- "Scripts/Markdown/Estilos/Architect/architect.css" 
markdown_header_footer <- includes(in_header = "Scripts/Markdown/Cabeçalhos/cabecalhoCOVID19.html",
                                   after_body = "Scripts/Markdown/Rodapés/rodape.html") 

render(input = "Scripts/Final (HTML).Rmd",
       output_file = "Resultados/Final (HTML).html",
       output_format = html_document(fig_width = 12,
                                     fig_height = 8,
                                     includes = markdown_header_footer, 
                                     css = markdown_custom_css),
       knit_root_dir = getwd(),
       encoding = "UTF-8",
       quiet = TRUE)

file.rename(from = "Resultados/Final (HTML).html",
            to = paste0("Resultados/Indicador de Condições Financeiras - ", max(dados$data), ".html"))
