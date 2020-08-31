#### Define working directory ####

switch (Sys.info()["nodename"],
        alexandresanches = setwd("~/Documentos/GitHub/ICF"),
        elementaryOS = setwd("~/Desenvolvimento/SPE/ICF"),
        MESPE1048883 = setwd("~/GitHub/ICF")
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
    library(Rblpapi)
    library(lubridate)
    library(RColorBrewer)
    library(gridExtra)
})

source("Scripts/Functions.R", encoding = "utf8")
# source("Scripts/AutoBCB.R", encoding = "utf8")

#### Import data ####

source("Scripts/Dados.R", encoding = "utf8")

#### Weights definition ####

pesos <- data.frame(Grupos = c(1, 2, 3, 4, 5, 6, 7),
                    Nomes = c("Juros Brasil", "Juros Exterior", "Risco", "Moedas", "Petróleo",
                              "Commodities", "Mercado de capitais"),
                    Pesos = c(0.34, 0.33, 0.18, 0.2, 0.23, -0.13, -0.15))

#### First principal component extraction ####
juroBrasil <- removeNA(xts(juroBrasil[,-1], order.by = juroBrasil[,1]))
juroExterior <- na.locf(juroExterior, fromLast = TRUE)
juroExterior <- removeNA(xts(juroExterior[,-1], order.by = juroExterior[,1]))
risco <- removeNA(xts(risco[,-1], order.by = risco[,1]))
moedas <- removeNA(xts(moedas[,-1], order.by = moedas[,1]))
petroleo <- removeNA(xts(petroleo[,-1], order.by = petroleo[,1]))
commodities <- removeNA(xts(commodities[,-1], order.by = commodities[,1]))
mercCapitais <- removeNA(xts(mercCapitais[,-1], order.by = mercCapitais[,1]))

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

base$pca_juroBrasil <- padronizar(base$pca_juroBrasil) * pesos[1,3]
base$pca_juroExterior <- padronizar(base$pca_juroExterior) * pesos[2,3]
base$pca_risco <- padronizar(base$pca_risco) * pesos[3,3]
base$pca_moedas <- padronizar(base$pca_moedas) * pesos[4,3]
base$pca_petroleo <- padronizar(base$pca_petroleo) * pesos[5,3]
base$pca_commodities <- padronizar(base$pca_commodities) * pesos[6,3]
base$pca_mercCapitais <- padronizar(base$pca_mercCapitais) * pesos[7,3]

base <- data.frame(data = index(base), base)
rownames(base) <- NULL

base <- base %>%
    mutate(index = pca_juroBrasil + pca_juroExterior + pca_risco + pca_moedas +
               pca_petroleo + pca_commodities + pca_mercCapitais)

#### Plots #####

nb.cols <- 8
mycolors <- colorRampPalette(brewer.pal(8, "Spectral"))(nb.cols)
mycolors <- c("black", mycolors[-1])

p <- base %>%
    na.omit() %>%
    pivot_longer(-c(data, index),
                 names_to = "variavel",
                 values_to = "valor") %>%
    ggplot(aes(x = data)) +
    geom_area(aes(y = valor, fill = variavel), 
             position = "stack") +
    geom_line(aes(y = index, fill = "ICF"), 
              size = 1) +
    geom_hline(yintercept = 0) +
    labs(x = "", y = "", fill = "", title = "Indicador de Condições Financeiras - SPE") +
    scale_x_date(date_breaks = "6 month",
                 date_labels = "%b/%Y") +
    scale_y_continuous(breaks = seq(-3, 3, 0.5)) +
    scale_fill_manual(values = mycolors, labels = c("ICF", "Commodities",
                                                    "Juros Brasil", "Juros exterior",
                                                    "Mercado de capitais", "Moedas",
                                                    "Petróleo", "Risco")) + 
    annotate("text", 
             x = as.Date("2014-10-01"), y = 2, 
             label = "Condições financeiras \n mais restritivas", color = "#800000") +
    annotate("text", 
             x = as.Date("2019-09-01"), y = -1.5, 
             label = "Condições financeiras \n menos restritivas", color = "#2b579e") +
    theme(panel.background = element_rect(fill = "white", colour = "grey10"),
          panel.grid.major = element_line(colour = "gray", linetype = "dashed"),
          legend.position = c(0.5, 0.1),
          legend.background = element_blank(),
          legend.direction = "horizontal")

p1 <- base %>%
    na.omit() %>%
    pivot_longer(-c(data, index),
                 names_to = "variavel",
                 values_to = "valor") %>%
    filter(data >= "2020-01-01") %>%
    ggplot(aes(x = data)) +
    geom_area(aes(y = valor, fill = variavel), 
              position = "stack") +
    geom_line(aes(y = index, fill = "ICF"), 
              size = 1) +
    geom_hline(yintercept = 0) +
    labs(x = "", y = "", fill = "", title = "Indicador de Condições Financeiras - SPE", subtitle = "Desde 01/2020") +
    scale_x_date(date_breaks = "1 month",
                 date_labels = "%b/%Y") +
    scale_y_continuous(breaks = seq(-3, 3, 0.5)) +
    scale_fill_manual(values = mycolors, labels = c("ICF", "Commodities",
                                                    "Juros Brasil", "Juros exterior",
                                                    "Mercado de capitais", "Moedas",
                                                    "Petróleo", "Risco")) + 
    theme(panel.background = element_rect(fill = "white", colour = "grey10"),
          panel.grid.major = element_line(colour = "gray", linetype = "dashed"),
          legend.position = c(0.83, 0.9),
          legend.background = element_blank(),
          legend.direction = "horizontal")

grid.arrange(p, p1)

source("Scripts/Plots.R", encoding = "utf8") 

#### Tables #### 

source("Scripts/Tables.R", encoding = "utf8") 

#### Save data for Markdown rendering #### 

save(base, file = paste0("Dados/ICF ", max(base$data), ".RData")) 

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
    
