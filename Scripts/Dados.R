### Load packages

library(Rblpapi)
library(lubridate)
library(tidyverse)
library(xts)

### Load Bloomberg terminal

blpConnect()

if (serie == "original") {
    #### Séries originais ####
    
    ## Juro Brasil
    juros1a_br <- AutoBloomberg("BCSFLPDV CMPN Curncy")
    juros5a_br <- AutoBloomberg("BCSFSPDV CMPN Curncy")
    
    colnames(juros1a_br) <- c("data", "juro1a_br")
    colnames(juros5a_br) <- c("data", "juro5a_br")
    
    juroBrasil <- list(juros1a_br, juros5a_br) %>%
        join_all(by = "data") %>%
        arrange(data)
    
    #juroBrasil <- xts(juroBrasil[,-1], order.by = juroBrasil$data)
    
    ## Juro internacional
    
    # EUA
    juros3m_us <- AutoBloomberg("H15T3M Index")
    juros2a_us <- AutoBloomberg("H15T2Y Index")
    juros10a_us <- AutoBloomberg("H15T10Y Index")
    
    colnames(juros3m_us) <- c("data", "juros3m_us")
    colnames(juros2a_us) <- c("data", "juros2a_us")
    colnames(juros10a_us) <- c("data", "juros10a_us")
    
    # Reino Unido
    juros3m_uk <- AutoBloomberg("GUKG3M Index")
    juros2a_uk <- AutoBloomberg("GUKG2 Index")
    juros10a_uk <- AutoBloomberg("GUKG10 Index")
    
    colnames(juros3m_uk) <- c("data", "juros3m_uk")
    colnames(juros2a_uk) <- c("data", "juros2a_uk")
    colnames(juros10a_uk) <- c("data", "juros10a_uk")
    
    # Alemanha
    juros3m_de <- AutoBloomberg("I01603M Index")
    juros2a_de <- AutoBloomberg("GDBR2 Index")
    juros10a_de <- AutoBloomberg("GDBR10 Index")
    
    colnames(juros3m_de) <- c("data", "juros3m_de")
    colnames(juros2a_de) <- c("data", "juros2a_de")
    colnames(juros10a_de) <- c("data", "juros10a_de")
    
    # Japão
    juros3m_jp <- AutoBloomberg("GJGB3M Index")
    juros2a_jp <- AutoBloomberg("GJGB2 Index")
    juros10a_jp <- AutoBloomberg("GJGB10 Index")
    
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
    cds_br <- AutoBloomberg("CBRZ1U5 CBIN Curncy")
    vix <- AutoBloomberg("VIX Index")
    
    colnames(cds_br) <- c("data", "cds_br")
    colnames(vix) <- c("data", "vix")
    
    risco <- list(cds_br, vix) %>%
        join_all(by = "data") %>%
        arrange(data)
    
    #risco <- xts(risco[,-1], order.by = risco$data)
    
    rm(cds_br, vix)
    
    ## Moedas
    
    cambio <- AutoBloomberg("BZFXPTAX Index")
    dxy_desenv <- AutoBloomberg("DXY Curncy")
    dxy_emerg <- AutoBloomberg("FXJPEMCS Index")
    
    colnames(cambio) <- c("data", "cambio")
    colnames(dxy_desenv) <- c("data", "dxy_desenv")
    colnames(dxy_emerg) <- c("data", "dxy_emerg")
    
    moedas <- list(cambio, dxy_desenv, dxy_emerg) %>%
        join_all(by = "data") %>%
        arrange(data)
    
    #moedas <- xts(moedas[,-1], order.by = moedas$data)
    
    rm(cambio, list = ls(pattern = "dxy"))
    
    ## Petróleo
    petro_wti <- AutoBloomberg("CL1 Comdty")
    petro_brent <- AutoBloomberg("CO1 Comdty")
    
    colnames(petro_wti) <- c("data", "petro_wti")
    colnames(petro_brent) <- c("data", "petro_brent")
    
    petroleo <- list(petro_wti, petro_brent) %>%
        join_all(by = "data") %>%
        arrange(data)
    
    #petroleo <- xts(petroleo[,-1], order.by = petroleo$data)
    
    rm(list = ls(pattern = "_"))
    
    ## Commodities
    crb_food <- AutoBloomberg("CRB FOOD Index")
    crb_metal <- AutoBloomberg("CRB METL Index")
    
    colnames(crb_food) <- c("data", "crb_food")
    colnames(crb_metal) <- c("data", "crb_metal")
    
    commodities <- list(crb_food, crb_metal) %>%
        join_all(by = "data") %>%
        arrange(data)
    
    #commodities <- xts(commodities[,-1], order.by = commodities$data)
    
    rm(list = ls(pattern = "crb"))
    
    ## Mercado de capitais
    msci_emerg <- AutoBloomberg("MXEF Index")
    msci_desenv <- AutoBloomberg("MXWO Index")
    ibovespa <- AutoBloomberg("IBOV Index")
    
    colnames(msci_emerg) <- c("data", "msci_emerg")
    colnames(msci_desenv) <- c("data", "msci_desenv")
    colnames(ibovespa) <- c("data", "ibovespa")
    
    mercCapitais <- list(msci_emerg, msci_desenv, ibovespa) %>%
        join_all(by = "data") %>%
        arrange(data)
    
    #mercCapitais <- xts(mercCapitais[,-1], order.by = mercCapitais$data)
    
    rm(ibovespa, list = ls(pattern = "msci"))
    
    
} else if (serie == "padrao") {
    #### Séries padronizadas ####
    
    ## Juro Brasil
    
    juros1a_br <- padronizar(AutoBloomberg("BCSFLPDV CMPN Curncy"))
    juros5a_br <- padronizar(AutoBloomberg("BCSFSPDV CMPN Curncy"))
    
    colnames(juros1a_br) <- c("data", "juro1a_br")
    colnames(juros5a_br) <- c("data", "juro5a_br")
    
    juroBrasil <- list(juros1a_br, juros5a_br) %>%
        join_all(by = "data") %>%
        arrange(data)
    
    juroBrasil <- xts(juroBrasil[, -1], order.by = juroBrasil$data) %>%
        removeNA()
    
    ## Juro internacional
    
    # EUA
    juros3m_us <- padronizar(AutoBloomberg("H15T3M Index"))
    juros2a_us <- padronizar(AutoBloomberg("H15T2Y Index"))
    juros10a_us <- padronizar(AutoBloomberg("H15T10Y Index"))
    
    colnames(juros3m_us) <- c("data", "juros3m_us")
    colnames(juros2a_us) <- c("data", "juros2a_us")
    colnames(juros10a_us) <- c("data", "juros10a_us")
    
    # Reino Unido
    juros3m_uk <- padronizar(AutoBloomberg("GUKG3M Index"))
    juros2a_uk <- padronizar(AutoBloomberg("GUKG2 Index"))
    juros10a_uk <- padronizar(AutoBloomberg("GUKG10 Index"))
    
    colnames(juros3m_uk) <- c("data", "juros3m_uk")
    colnames(juros2a_uk) <- c("data", "juros2a_uk")
    colnames(juros10a_uk) <- c("data", "juros10a_uk")
    
    # Alemanha
    juros3m_de <- padronizar(AutoBloomberg("I01603M Index"))
    juros2a_de <- padronizar(AutoBloomberg("GDBR2 Index"))
    juros10a_de <- padronizar(AutoBloomberg("GDBR10 Index"))
    
    colnames(juros3m_de) <- c("data", "juros3m_de")
    colnames(juros2a_de) <- c("data", "juros2a_de")
    colnames(juros10a_de) <- c("data", "juros10a_de")
    
    # Japão
    juros3m_jp <- padronizar(AutoBloomberg("GJGB3M Index"))
    juros2a_jp <- padronizar(AutoBloomberg("GJGB2 Index"))
    juros10a_jp <- padronizar(AutoBloomberg("GJGB10 Index"))
    
    colnames(juros3m_jp) <- c("data", "juros3m_jp")
    colnames(juros2a_jp) <- c("data", "juros2a_jp")
    colnames(juros10a_jp) <- c("data", "juros10a_jp")
    
    juroExterior <- list(juros3m_us, juros2a_us, juros10a_us,
                         juros3m_uk, juros2a_uk, juros10a_uk,
                         juros3m_de, juros2a_de, juros10a_de,
                         juros3m_jp, juros2a_jp, juros10a_jp) %>%
        join_all(by = "data") %>%
        arrange(data)
    
    juroExterior <- xts(juroExterior[, -1], order.by = juroExterior$data) %>%
        removeNA()
    
    rm(list = ls(pattern = "_"))
    
    ## Risco
    cds_br <- padronizar(AutoBloomberg("CBRZ1U5 CBIN Curncy"))
    vix <- padronizar(AutoBloomberg("VIX Index"))
    
    colnames(cds_br) <- c("data", "cds_br")
    colnames(vix) <- c("data", "vix")
    
    risco <- list(cds_br, vix) %>%
        join_all(by = "data") %>%
        arrange(data)
    
    risco <- xts(risco[, -1], order.by = risco$data) %>%
        removeNA()
    
    rm(cds_br, vix)
    
    ## Moedas
    
    cambio <- AutoBloomberg("BZFXPTAX Index") %>%
        mutate(PX_LAST = PX_LAST - lag(PX_LAST, 1)) %>%
        padronizar()
    dxy_desenv <- AutoBloomberg("DXY Curncy") %>%
        mutate(PX_LAST = PX_LAST - lag(PX_LAST, 1)) %>%
        padronizar()
    dxy_emerg <- AutoBloomberg("FXJPEMCS Index")  %>%
        mutate(PX_LAST = PX_LAST - lag(PX_LAST, 1)) %>%
        padronizar()
    
    colnames(cambio) <- c("data", "cambio")
    colnames(dxy_desenv) <- c("data", "dxy_desenv")
    colnames(dxy_emerg) <- c("data", "dxy_emerg")
    
    moedas <- list(cambio, dxy_desenv, dxy_emerg) %>%
        join_all(by = "data") %>%
        arrange(data)
    
    moedas <- xts(moedas[, -1], order.by = moedas$data) %>%
        removeNA()
    
    rm(cambio, list = ls(pattern = "dxy"))
    
    ## Petróleo
    petro_wti <- AutoBloomberg("CL1 Comdty") %>%
        mutate(PX_LAST = PX_LAST - lag(PX_LAST, 1)) %>%
        padronizar()
    petro_brent <- AutoBloomberg("CO1 Comdty") %>%
        mutate(PX_LAST = PX_LAST - lag(PX_LAST, 1)) %>%
        padronizar()
    
    colnames(petro_wti) <- c("data", "petro_wti")
    colnames(petro_brent) <- c("data", "petro_brent")
    
    petroleo <- list(petro_wti, petro_brent) %>%
        join_all(by = "data") %>%
        arrange(data)
    
    petroleo <- xts(petroleo[, -1], order.by = petroleo$data) %>%
        removeNA()
    
    rm(list = ls(pattern = "_"))
    
    ## Commodities
    crb_food <- AutoBloomberg("CRB FOOD Index") %>%
        mutate(PX_LAST = PX_LAST - lag(PX_LAST, 1)) %>%
        padronizar()
    crb_metal <- AutoBloomberg("CRB METL Index") %>%
        mutate(PX_LAST = PX_LAST - lag(PX_LAST, 1)) %>%
        padronizar()
    
    colnames(crb_food) <- c("data", "crb_food")
    colnames(crb_metal) <- c("data", "crb_metal")
    
    commodities <- list(crb_food, crb_metal) %>%
        join_all(by = "data") %>%
        arrange(data)
    
    commodities <- xts(commodities[, -1], order.by = commodities$data) %>%
        removeNA()
    
    rm(list = ls(pattern = "crb"))
    
    ## Mercado de capitais
    msci_emerg <- AutoBloomberg("MXEF Index") %>%
        mutate(PX_LAST = PX_LAST - lag(PX_LAST, 1)) %>%
        padronizar()
    msci_desenv <- AutoBloomberg("MXWO Index") %>%
        mutate(PX_LAST = PX_LAST - lag(PX_LAST, 1)) %>%
        padronizar()
    ibovespa <- AutoBloomberg("IBOV Index") %>%
        mutate(PX_LAST = PX_LAST - lag(PX_LAST, 1)) %>%
        padronizar()
    
    colnames(msci_emerg) <- c("data", "msci_emerg")
    colnames(msci_desenv) <- c("data", "msci_desenv")
    colnames(ibovespa) <- c("data", "ibovespa")
    
    mercCapitais <- list(msci_emerg, msci_desenv, ibovespa) %>%
        join_all(by = "data") %>%
        arrange(data)
    
    mercCapitais <-
        xts(mercCapitais[, -1], order.by = mercCapitais$data) %>%
        removeNA()
    
    rm(ibovespa, list = ls(pattern = "msci"))
    
    save.image(file = paste0("Dados/Data & Functions ",
                             format.Date(Sys.Date(), format = "%d-%b-%Y"),
                             ".RData" ))
}
