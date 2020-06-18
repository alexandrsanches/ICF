#### Funções

b <- function(ticker) {
    
    data <- bdh(ticker, c("PX_LAST"), start.date = ymd("2000-01-01"), options = c("periodicitySelection" = "DAILY"))
    
}

sdev <- function(objeto) {
    
    media <- mean(objeto[,2])
    desv_pad <- sd(objeto[,2])
    
    objeto <- objeto %>%
        mutate(PX_LAST = PX_LAST - media,
               PX_LAST = PX_LAST / desv_pad)
    
}

