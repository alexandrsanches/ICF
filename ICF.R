#### Define working directory ####

switch (Sys.info()["sysname"],
    Linux = setwd("~/Desenvolvimento/SPE/Indicador de Condições Financeiras"),
    Darwin = setwd("~/Documents/GitHub/Indicador de Condições Financeiras"),
    Windows = setwd("~/Documents/Indicador de Condições Financeiras")
)

#### Load packages and functions #### 

suppressPackageStartupMessages({
    library(xts)
    library(readxl)
    library(bizdays)
})

#source("Scripts/Functions.R", encoding = "utf8")

#### Import data ####

source("Scripts/Dados.R", encoding = "utf8")

#### Data transformation ####

#### Index construction ####

#### Plots #####

source("Scripts/Plots.R", encoding = "utf8") 

#### Tables #### 

source("Scripts/Tables.R", encoding = "utf8") 

#### Save data for Markdown rendering #### 

save.image(file = "Resultados/Informações para o relatório.RData") 

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
