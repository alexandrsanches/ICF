### Load packages

library(Rblpapi)
library(lubridate)
library(tidyverse)
library(xts)

loadb <- function(ticker) {

        data <- bdh(ticker, c("PX_LAST"), start.date = ymd("2000-01-01"), options = c("periodicitySelection" = "DAILY"))
        
}

### Load bloomberg terminal

blpConnect()

## Juro Brasil

({
juros1a_br <- loadb("BCSWFPD BGN Curncy")
juros5a_br <- loadb("BCSWNPD BGN Curncy")
})

## Juro internacional

# EUA
juros3m_us <- loadb("H15T3M Index")
juros2a_us <- loadb("H15T2Y Index")
juros10a_us <- loadb("H15T10Y Index")

# Reino Unido
juros3m_uk <- loadb("GUKG3M Index")
juros2a_uk <- loadb("GUKG2 Index")
juros10a_uk <- loadb("GUKG10 Index")

# Alemanha
juros3m_de <- loadb("I01603M Index")
juros2a_de <- loadb("GDBR2 Index")
juros10a_de <- loadb("GDBR10 Index")

# Jap?o
juros3m_jp <- loadb("GJGB3M Index")
juros2a_jp <- loadb("GJGB2 Index")
juros10a_jp <- loadb("GJGB10 Index")


## Moedas
({
cambio <- loadb("BZFXPTAX Index")
dxy_desenv <- loadb("DXY Curncy")
dxy_emerg <- loadb("FXJPEMCS Index")
})

## Commodities
({
crb_food <- loadb("CRB FOOD Index")
crb_metal <- loadb("CRB METL Index")
})

## Petr?leo
({
petro_wti <- loadb("CL1 Comdty")
petro_brent <- loadb("CO1 Comdty")
})

## Risco
({
cds_br <- loadb("CBRZ1U5 CBIN Curncy")
vix <- loadb("VIX Index")
})

## Mercado de capitais
({
msci_emerg <- loadb("MXEF Index")
msci_desenv <- loadb("MXWO Index")
ibovespa <- loadb("IBOV Index")
})

