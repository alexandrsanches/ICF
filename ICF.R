#### Define working directory ####

switch (Sys.info()["sysname"],
    Linux = setwd("~/Desenvolvimento/SPE/Indicador de Condições Financeiras"),
    Darwin = setwd("~/Documents/GitHub/Indicador de Condições Financeiras"),
    Windows = setwd("~/ICF")
)

#### Load packages and functions #### 

suppressPackageStartupMessages({
    library(xts)
    library(readxl)
    library(bizdays)
    library(plyr)
    library(tidyverse)
    library(reshape2)
    library(rmarkdown)
    library(knitr) 
    library(FactoMineR)
})

source("Scripts/Functions.R", encoding = "utf8")

#### Import data ####

if(Sys.info()["nodename"] == "MESPE1048883") {
    
    serie <- "padrao"
    source("Scripts/Dados.R", encoding = "utf8")
    rm(serie)
    
} else {
    
    dados <- paste0("Dados/",max(list.files("Dados/", pattern = "Data")))
    load(dados)
    rm(dados, serie)
}

pesos <- structure(list(Grupos = c(1, 2, 3, 4, 5, 6, 7), 
                        Nomes = c("Juros Brasil", 
                                  "Juros Exterior", "Risco", "Moedas", "Petróleo", "Commodities", "Mercado de capitais"), 
                        Pesos = c(0.34, 0.33, 0.18, 0.2, 0.23, -0.13, -0.15)), 
                   row.names = c(NA, -7L), class = c("tbl_df", "tbl", "data.frame"))

#### Data transformation ####

pca_juroBrasil <- PCA(juroBrasil, graph = F)
pca_juroExterior <- PCA(juroExterior, graph = F)
pca_risco <- PCA(risco, graph = F)
pca_moedas <- PCA(moedas, graph = F)
pca_petroleo <- PCA(petroleo, graph = F)
pca_commodities <- PCA(commodities, graph = F)
pca_mercCapitais <- PCA(mercCapitais, graph = F)

pca <- prcomp(juroExterior)

# Avaliar tranformações em variação, log, etc.
# Padronizar dados
# Avaliar a questão das defasagens (talvez eu possa usar o mesmo procedimento que uso nos modelos via AutoMod e XGBoost)

#### Index construction ####



#### Plots #####

source("Scripts/Plots.R", encoding = "utf8") 

#### Tables #### 

source("Scripts/Tables.R", encoding = "utf8") 

#### Save data for Markdown rendering #### 

save.image(file = "Dados/Informações para o relatório.RData") 

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
