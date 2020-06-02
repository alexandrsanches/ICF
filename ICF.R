#### Define working directory ####

if (Sys.info()["sysname"] == "Linux") {
  setwd("~/OneDrive/Desenvolvimento/SPE/Indicador de Condições Financeiras")
} else if (Sys.info()["sysname"] == "Darwin"){
  setwd("~/Documents/GitHub/Indicador de Condições Financeiras")
} else {
  setwd("~/Documents/Indicador de Condições Financeiras")
}

#### Load packages and functions #### 

suppressPackageStartupMessages({
  library(kableExtra)
  library(ggrepel)
  library(tidyverse)
  library(tidycovid19) # Pacote do GitHub - https://github.com/joachim-gassen/tidycovid19
  library(tsibble)
  library(reshape2)
  library(patchwork)
  library(gghighlight)
  library(zoo)
  library(knitr) 
  library(rmarkdown)
  library(openxlsx)
  library(tseries)
  library(wesanderson)
  library(lubridate)
  library(HDeconometrics) # Pacote do GitHub - https://github.com/gabrielrvsc/HDeconometrics
})

source("Scripts/Functions.R", encoding = "utf8")

#### Import data ####



#### Plots #####

source("Scripts/Plots.R", encoding = "utf8") 

#### Tables #### 

source("Scripts/Tables.R", encoding = "utf8") 

#### Save data for Markdown rendering #### 

save.image(file = "Dados/Data & Functions.RData") 

#### Render R Markdown ####

estilo_markdown <- "Scripts/Markdown/Estilos/Architect/architect.css" 
cabecalho_rodape_markdown <- includes(in_header = "Scripts/Markdown/Cabeçalhos/cabecalhoCOVID19.html",
                                      after_body = "Scripts/Markdown/Rodapés/rodape.html") 

render(input = "Scripts/Final (HTML).Rmd",
       output_file = "Resultados/Final (HTML).html",
       output_format = html_document(fig_width = 12,
                                     fig_height = 8,
                                     includes = cabecalho_rodape_markdown, 
                                     css = estilo_markdown),
       knit_root_dir = getwd(),
       encoding = "UTF-8",
       quiet = TRUE)

file.rename(from = "Resultados/Final (HTML).html",
            to = paste0("Resultados/Acompanhamento de COVID-19 - ", max(dados$data), ".html"))
