### Load packages

library(Rblpapi)
library(lubridate)
library(tidyverse)
library(xts)
library(plyr)

loadb <- function(ticker) {
    
    data <- bdh(ticker, c("PX_LAST"), start.date = ymd("2000-01-01"), options = c("periodicitySelection" = "DAILY"))
    
}

### Load bloomberg terminal

blpConnect()

## Juro Brasil

({
    juros1a_br <- loadb("BCSFLPDV CMPN Curncy")
    juros5a_br <- loadb("BCSFSPDV CMPN Curncy")
})

colnames(juros1a_br) <- c("data", "juro1a_br")
colnames(juros5a_br) <- c("data", "juro5a_br")

juroBrasil <- list(juros1a_br, juros5a_br) %>%
    join_all(by = "data") %>%
    arrange(data)

## Juro internacional

# EUA
({
    juros3m_us <- loadb("H15T3M Index")
    juros2a_us <- loadb("H15T2Y Index")
    juros10a_us <- loadb("H15T10Y Index")
})

colnames(juros3m_us) <- c("data", "juros3m_us")
colnames(juros2a_us) <- c("data", "juros2a_us")
colnames(juros10a_us) <- c("data", "juros10a_us")

# Reino Unido
({
    juros3m_uk <- loadb("GUKG3M Index")
    juros2a_uk <- loadb("GUKG2 Index")
    juros10a_uk <- loadb("GUKG10 Index")
})

colnames(juros3m_uk) <- c("data", "juros3m_uk")
colnames(juros2a_uk) <- c("data", "juros2a_uk")
colnames(juros10a_uk) <- c("data", "juros10a_uk")

# Alemanha
({
    juros3m_de <- loadb("I01603M Index")
    juros2a_de <- loadb("GDBR2 Index")
    juros10a_de <- loadb("GDBR10 Index")
})

colnames(juros3m_de) <- c("data", "juros3m_de")
colnames(juros2a_de) <- c("data", "juros2a_de")
colnames(juros10a_de) <- c("data", "juros10a_de")
    
# Japão
({
    juros3m_jp <- loadb("GJGB3M Index")
    juros2a_jp <- loadb("GJGB2 Index")
    juros10a_jp <- loadb("GJGB10 Index")
})

colnames(juros3m_jp) <- c("data", "juros3m_jp")
colnames(juros2a_jp) <- c("data", "juros2a_jp")
colnames(juros10a_jp) <- c("data", "juros10a_jp")

juroExterior <- list(juros3m_us, juros2a_us, juros10a_us,
         juros3m_uk, juros2a_uk, juros10a_uk,
         juros3m_de, juros2a_de, juros10a_de,
         juros3m_jp, juros3m_jp, juros10a_jp) %>%
    join_all(by = "data") %>%
    arrange(data)

rm(list = ls(pattern = "_"))

## Risco
({
    cds_br <- loadb("CBRZ1U5 CBIN Curncy")
    vix <- loadb("VIX Index")
})

colnames(cds_br) <- c("data", "cds_br")
colnames(vix) <- c("data", "vix")

risco <- list(cds_br, vix) %>%
    join_all(by = "data") %>%
    arrange(data)

rm(cds_br, vix)

## Moedas

({
    cambio <- loadb("BZFXPTAX Index")
    dxy_desenv <- loadb("DXY Curncy")
    dxy_emerg <- loadb("FXJPEMCS Index")
})

colnames(cambio) <- c("data", "cambio")
colnames(dxy_desenv) <- c("data", "dxy_desenv")
colnames(dxy_emerg) <- c("data", "dxy_emerg")

moedas <- list(cambio, dxy_desenv, dxy_emerg) %>%
    join_all(by = "data") %>%
    arrange(data)

rm(cambio, list = ls(pattern = "dxy"))

## Petróleo
({
    petro_wti <- loadb("CL1 Comdty")
    petro_brent <- loadb("CO1 Comdty")
})

colnames(petro_wti) <- c("data", "petro_wti")
colnames(petro_brent) <- c("data", "petro_brent")

petroleo <- list(petro_wti, petro_brent) %>%
    join_all(by = "data") %>%
    arrange(data)

rm(list = ls(pattern = "_"))

## Commodities
({
    crb_food <- loadb("CRB FOOD Index")
    crb_metal <- loadb("CRB METL Index")
})

colnames(crb_food) <- c("data", "crb_food")
colnames(crb_metal) <- c("data", "crb_metal")

commodities <- list(crb_food, crb_metal) %>% 
    join_all(by = "data") %>%
    arrange(data)

rm(list = ls(pattern = "crb"))

## Mercado de capitais
({
    msci_emerg <- loadb("MXEF Index")
    msci_desenv <- loadb("MXWO Index")
    ibovespa <- loadb("IBOV Index")
})

colnames(msci_emerg) <- c("data", "msci_emerg")
colnames(msci_desenv) <- c("data", "msci_desenv")
colnames(ibovespa) <- c("data", "ibovespa")

mercCapitais <- list(msci_emerg, msci_desenv, ibovespa) %>%
    join_all(by = "data") %>%
    arrange(data)

rm(ibovespa, list = ls(pattern = "msci"))
