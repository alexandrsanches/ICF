#### Define working directory ####

switch (Sys.info()["sysname"],
    Linux = setwd("~/Desenvolvimento/SPE/ICF"),
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

if (Sys.info()["nodename"] == "MESPE1048883") {
    source("Scripts/Dados.R", encoding = "utf8")
} else {
    dados <- paste0("Dados/", max(list.files("Dados/", pattern = "Data")))
    load(dados)
    rm(dados)
}

pesos <- data.frame(Grupos = c(1, 2, 3, 4, 5, 6, 7),
                    Nomes = c("Juros Brasil", "Juros Exterior", "Risco", "Moedas", "Petróleo",
                              "Commodities", "Mercado de capitais"),
                    Pesos = c(0.34, 0.33, 0.18, 0.2, 0.23, -0.13, -0.15))

# pesos <- structure(list(Grupos = c(1, 2, 3, 4, 5, 6, 7), 
#                         Nomes = c("Juros Brasil", "Juros Exterior", "Risco", "Moedas", "Petróleo",
#                                   "Commodities", "Mercado de capitais"), 
#                         Pesos = c(0.34, 0.33, 0.18, 0.2, 0.23, -0.13, -0.15)), 
#                    row.names = c(NA, -7L), class = c("tbl_df", "tbl", "data.frame"))

#### First principal component extraction ####

pca_juroBrasil <- as.xts(PCA(juroBrasil, graph = FALSE)[["ind"]][["coord"]][,1], dateFormat = "Date")
pca_juroExterior <- as.xts(PCA(juroExterior, graph = FALSE)[["ind"]][["coord"]][,1], dateFormat = "Date")
pca_risco <- as.xts(PCA(risco, graph = FALSE)[["ind"]][["coord"]][,1], dateFormat = "Date")
pca_moedas <- as.xts(PCA(moedas, graph = FALSE)[["ind"]][["coord"]][,1], dateFormat = "Date")
pca_petroleo <- as.xts(PCA(petroleo, graph = FALSE)[["ind"]][["coord"]][,1], dateFormat = "Date")
pca_commodities <- as.xts(PCA(commodities, graph = FALSE)[["ind"]][["coord"]][,1], dateFormat = "Date")
pca_mercCapitais <- as.xts(PCA(mercCapitais, graph = FALSE)[["ind"]][["coord"]][,1], dateFormat = "Date")

#### Data base merging and filtering ####

base <- merge(pca_juroBrasil, pca_juroExterior, pca_risco, pca_moedas, pca_petroleo,
              pca_commodities, pca_mercCapitais)

base <- base[paste0(start(na.omit(base)), "/")]

#### Index construction ####

# To do:
# Ler o artigo para ver como é feita a construção do ICF.

#### Plots #####

juroBrasil %>%
    fortify() %>%
    ggplot(aes(x = Index)) +
    geom_line(aes(y = juro1a_br, color = "juro1")) +
    geom_line(aes(y = juro5a_br, color = "juro5")) +
    geom_line(data = base, aes(x = data, y = pc1, color = "rbase")) +
    geom_line(data = facto, aes(x = data, y = pc1, color = "factomine")) +
    ggthemes::scale_color_economist()

teste <- juroBrasil %>%
    fortify()

petroleo %>%
    fortify() %>%
    filter(Index >= "2010-01-01") %>%
    ggplot(aes(x = Index)) +
    geom_line(aes(y = petro_wti, color = "wti")) +
    geom_line(aes(y = petro_brent, color = "brent")) +
    geom_line(data = facto, aes(x = data, y = pc1, color = "factomine")) +
    geom_line(data = base, aes(x = data, y = pc1, color = "rbase")) +
    coord_cartesian(ylim = c(-15,15)) 

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
    
