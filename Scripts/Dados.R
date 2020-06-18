### Load packages

library(Rblpapi)
library(lubridate)
library(tidyverse)
library(xts)

### Load bloomberg terminal

blpConnect()

#### Séries originais

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

#juroBrasil <- xts(juroBrasil[,-1], order.by = juroBrasil$data)

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

# Jap?o
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
                     juros3m_jp, juros2a_jp, juros10a_jp) %>%
    join_all(by = "data") %>%
    arrange(data)

#juroExterior <- xts(juroExterior[,-1], order.by = juroExterior$data)

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

#risco <- xts(risco[,-1], order.by = risco$data)

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

#moedas <- xts(moedas[,-1], order.by = moedas$data)

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

#petroleo <- xts(petroleo[,-1], order.by = petroleo$data)

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

#commodities <- xts(commodities[,-1], order.by = commodities$data)

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

#mercCapitais <- xts(mercCapitais[,-1], order.by = mercCapitais$data)

rm(ibovespa, list = ls(pattern = "msci"))

#### Séries padronizadas

## Juro Brasil

({
    juros1a_br <- padronizar(loadb("BCSFLPDV CMPN Curncy"))
    juros5a_br <- padronizar(loadb("BCSFSPDV CMPN Curncy"))
})

colnames(juros1a_br) <- c("data", "juro1a_br")
colnames(juros5a_br) <- c("data", "juro5a_br")

juroBrasil <- list(juros1a_br, juros5a_br) %>%
    join_all(by = "data") %>%
    arrange(data) 

#juroBrasil <- xts(juroBrasil[,-1], order.by = juroBrasil$data)

## Juro internacional

# EUA
({
    juros3m_us <- padronizar(loadb("H15T3M Index"))
    juros2a_us <- padronizar(loadb("H15T2Y Index"))
    juros10a_us <- padronizar(loadb("H15T10Y Index"))
})

colnames(juros3m_us) <- c("data", "juros3m_us")
colnames(juros2a_us) <- c("data", "juros2a_us")
colnames(juros10a_us) <- c("data", "juros10a_us")

# Reino Unido
({
    juros3m_uk <- padronizar(loadb("GUKG3M Index"))
    juros2a_uk <- padronizar(loadb("GUKG2 Index"))
    juros10a_uk <- padronizar(loadb("GUKG10 Index"))
})

colnames(juros3m_uk) <- c("data", "juros3m_uk")
colnames(juros2a_uk) <- c("data", "juros2a_uk")
colnames(juros10a_uk) <- c("data", "juros10a_uk")

# Alemanha
({
    juros3m_de <- padronizar(loadb("I01603M Index"))
    juros2a_de <- padronizar(loadb("GDBR2 Index"))
    juros10a_de <- padronizar(loadb("GDBR10 Index"))
})

colnames(juros3m_de) <- c("data", "juros3m_de")
colnames(juros2a_de) <- c("data", "juros2a_de")
colnames(juros10a_de) <- c("data", "juros10a_de")
    
# Jap?o
({
    juros3m_jp <- padronizar(loadb("GJGB3M Index"))
    juros2a_jp <- padronizar(loadb("GJGB2 Index"))
    juros10a_jp <- padronizar(loadb("GJGB10 Index"))
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

#juroExterior <- xts(juroExterior[,-1], order.by = juroExterior$data)

rm(list = ls(pattern = "_"))

## Risco
({
    cds_br <- padronizar(loadb("CBRZ1U5 CBIN Curncy"))
    vix <- padronizar(loadb("VIX Index"))
})

colnames(cds_br) <- c("data", "cds_br")
colnames(vix) <- c("data", "vix")

risco <- list(cds_br, vix) %>%
    join_all(by = "data") %>%
    arrange(data)

#risco <- xts(risco[,-1], order.by = risco$data)

rm(cds_br, vix)

## Moedas

({
    cambio <- padronizar(loadb("BZFXPTAX Index"))
    dxy_desenv <- padronizar(loadb("DXY Curncy"))
    dxy_emerg <- padronizar(loadb("FXJPEMCS Index"))
})

colnames(cambio) <- c("data", "cambio")
colnames(dxy_desenv) <- c("data", "dxy_desenv")
colnames(dxy_emerg) <- c("data", "dxy_emerg")

moedas <- list(cambio, dxy_desenv, dxy_emerg) %>%
    join_all(by = "data") %>%
    arrange(data)

#moedas <- xts(moedas[,-1], order.by = moedas$data)

rm(cambio, list = ls(pattern = "dxy"))

## Petróleo
({
    petro_wti <- padronizar(loadb("CL1 Comdty"))
    petro_brent <- padronizar(loadb("CO1 Comdty"))
})

colnames(petro_wti) <- c("data", "petro_wti")
colnames(petro_brent) <- c("data", "petro_brent")

petroleo <- list(petro_wti, petro_brent) %>%
    join_all(by = "data") %>%
    arrange(data)

#petroleo <- xts(petroleo[,-1], order.by = petroleo$data)

rm(list = ls(pattern = "_"))

## Commodities
({
    crb_food <- padronizar(loadb("CRB FOOD Index"))
    crb_metal <- padronizar(loadb("CRB METL Index"))
})

colnames(crb_food) <- c("data", "crb_food")
colnames(crb_metal) <- c("data", "crb_metal")

commodities <- list(crb_food, crb_metal) %>% 
    join_all(by = "data") %>%
    arrange(data)

#commodities <- xts(commodities[,-1], order.by = commodities$data)

rm(list = ls(pattern = "crb"))

## Mercado de capitais
({
    msci_emerg <- padronizar(loadb("MXEF Index"))
    msci_desenv <- padronizar(loadb("MXWO Index"))
    ibovespa <- padronizar(loadb("IBOV Index"))
})

colnames(msci_emerg) <- c("data", "msci_emerg")
colnames(msci_desenv) <- c("data", "msci_desenv")
colnames(ibovespa) <- c("data", "ibovespa")

mercCapitais <- list(msci_emerg, msci_desenv, ibovespa) %>%
    join_all(by = "data") %>%
    arrange(data)

#mercCapitais <- xts(mercCapitais[,-1], order.by = mercCapitais$data)

rm(ibovespa, list = ls(pattern = "msci"))

#### Dados antigos ####

## Obtenção dos dados de planilhas 

#dados1_temp <- read_excel("Dados/bm&f.xlsx", sheet = "Swaps", skip = 13,
#                          col_types = c("date", "skip", "skip", "skip", "skip", "skip", "numeric",
#                                        "skip", "skip", "skip", "skip", "skip", "skip", "skip",
#                                        "skip"))
#
#colnames(dados1_temp) <- c("obs", "juros1a_br") # Não tem o de 5 anos. No BCB a de 360 dias tem no Bacen (código 7806)
#
#dados2_temp <- read_excel("Dados/credit_Default_Swap.xlsx", sheet = "CDS", skip = 11,
#                          col_types = c("date", "skip", "skip", "skip", "skip", "skip", "skip",
#                                        "numeric", "skip", "skip", "skip", "skip", "skip", "skip",
#                                        "skip", "skip", "skip", "skip", "skip", "skip", "skip",
#                                        "skip", "skip", "skip", "skip", "skip", "skip", "skip",
#                                        "skip", "skip", "skip", "skip"))
#
#colnames(dados2_temp) <- c("obs", "cds_br")
#
#dados3_temp <- read_excel("Dados/vix.xlsx", sheet = "VIX", skip = 11,
#                          col_types = c("date", "numeric", "skip"))
#
#colnames(dados3_temp) <- c("obs", "vix")
#
#dados4_temp <- read_excel("Dados/Commodity_research_bureau.xlsx", sheet = "CRB Future Spot", skip = 11,
#                          col_types = c("date", "skip", "skip", "skip", "skip", "skip", "skip", "skip",
#                                        "numeric", "skip", "skip", "numeric", "skip",
#                                        "skip", "skip"))
#
#colnames(dados4_temp) <- c("obs", "crb_metal", "crb_food")
#
#dados5_temp <- read_excel("Dados/Commodities_spot.xlsx", sheet = "Energia", skip = 11,
#                          col_types = c("date", "numeric", "numeric", "skip", "skip", "skip", "skip",
#                                        "skip", "skip", "skip", "skip"))
#
#colnames(dados5_temp) <- c("obs", "petro_brent", "petro_wti")
#
#dados6_temp <- read_excel("Dados/Indicadores.xlsx", sheet = "Câmbio - Brasil", skip = 11,
#                          col_types = c("date", "skip", "numeric", "skip", "skip", "skip"))
#
#colnames(dados6_temp) <- c("obs", "cambio")
#
#dados7_temp <- read_excel("Dados/Indicadores.xlsx", sheet = "Bovespa", skip = 11,
#                          col_types = c("date", "numeric", "skip", "skip", "skip"))
#
#colnames(dados7_temp) <- c("obs", "ibovespa")
#
#dados8_temp <- read_excel("Dados/Indicadores.xlsx", sheet = "Treasuries", skip = 11,
#                          col_types = c("date", "skip", "numeric", "skip", "skip", "numeric",
#                                        "skip", "skip", "skip", "numeric", "skip", "skip"))
#
#colnames(dados8_temp) <- c("obs", "juros3m_us", "juros2a_us", "juros10a_us")

## Conversão para xts 

#dados1_temp <- xts(x = dados1_temp[, -1], order.by = dados1_temp$obs)["2002/"]
#dados2_temp <- xts(x = dados2_temp[, -1], order.by = dados2_temp$obs)["2002/"]
#dados3_temp <- xts(x = dados3_temp[, -1], order.by = dados3_temp$obs)["2002/"]
#dados4_temp <- xts(x = dados4_temp[, -1], order.by = dados4_temp$obs)["2002/"]
#dados5_temp <- xts(x = dados5_temp[, -1], order.by = dados5_temp$obs)["2002/"]
#dados6_temp <- xts(x = dados6_temp[, -1], order.by = dados6_temp$obs)["2002/"]
#dados7_temp <- xts(x = dados7_temp[, -1], order.by = dados7_temp$obs)["2002/"]
#dados8_temp <- xts(x = dados8_temp[, -1], order.by = dados8_temp$obs)["2002/"]

## Junção dos dados em um único data frame 

#dados <- merge.xts(dados1_temp, dados2_temp, dados3_temp, dados4_temp, dados5_temp, dados6_temp, dados7_temp, dados8_temp)

## Remoção de dias não úteis 

#dias_temp <- seq.Date(from = as.Date("2000-01-01"), to = Sys.Date(), by = "day")
#dias_temp <- xts(x = rep(NA, times = length(dias_temp)), order.by = dias_temp)
#
#create.calendar(name = "Brazil/ANBIMA", holidays = holidaysANBIMA, weekdays = c("saturday", "sunday"))
#
#dias_uteis_temp <- ifelse(test = is.bizday(dates = index(dias_temp), cal = "Brazil/ANBIMA"), yes = 1, no = NA)
#dias_uteis_temp <- xts(x = dias_uteis_temp, order.by = index(dias_temp))
#colnames(dias_uteis_temp) <- "dias_uteis"
#
#dados <- merge.xts(dias_uteis_temp, dados)
#dados <- dados[!is.na(dados$dias_uteis), -1]

## Remoção dos valores NA dentro das séries 

#dados$vix["2020-06"] <- NA

#max_data_disponivel_temp <- max(as.Date(unlist(lapply(dados, FUN = function(x) {end(na.omit(x))}))))
#min_data_disponivel_temp <- min(as.Date(unlist(lapply(dados, FUN = function(x) {end(na.omit(x))}))))
#
#dados <- dados[paste0("/", max_data_disponivel_temp)]
#dados <- merge(temp = index(dados) <= as.Date(min_data_disponivel_temp), dados)
#
#dados <- rbind(na.omit(dados[dados$temp == 1,]),
#               dados[dados$temp == 0,])[, -1]

## Limpeza do ambiente 

#remove(list = ls(pattern = "_temp"))
