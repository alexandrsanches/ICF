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

#### Save data#### 

save(base, file = paste0("Dados/ICF ", max(base$data), ".RData")) 

