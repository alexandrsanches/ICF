#### Funções

AutoBloomberg <- function(ticker) {
    
    data <- bdh(ticker, c("PX_LAST"),
                start.date = ymd("2000-01-01"),
                options = c("periodicitySelection" = "DAILY"))
    
    return(data)
}

#padronizar <- function(serie) {
#    
#    media <- mean(serie[,2], na.rm = T)
#    desv_pad <- sd(serie[,2], na.rm = T)
#    
#    serie <- serie %>%
#        mutate(PX_LAST = (PX_LAST - media) / desv_pad)
#    
#    return(serie)
#}

removeNA <- function(serie) {
    
    max_data_disponivel_temp <- max(as.Date(unlist(lapply(serie, FUN = function(x) {end(na.omit(x))}))))
    min_data_disponivel_temp <- min(as.Date(unlist(lapply(serie, FUN = function(x) {end(na.omit(x))}))))
    
    serie <- serie[paste0("/", max_data_disponivel_temp)]
    serie <- merge(temp = index(serie) <= as.Date(min_data_disponivel_temp), serie)
    
    serie <- rbind(na.omit(serie[serie$temp == 1,]),
                          serie[serie$temp == 0,])[, -1]
    
    return(serie)
}

save <- function() {
    
    arquivo <- paste0("Dados/", list.files("Dados/")[1])
    
    file.remove(arquivo)
    
    save.image(paste0("Dados/Data & Functions ", format.Date(Sys.Date(), format = "%d-%B-%Y"), ".RData"))
    
}
