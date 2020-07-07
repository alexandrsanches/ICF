#### Funções

AutoBloomberg <- function(ticker) {
    
    data <- bdh(ticker, c("PX_LAST"),
                start.date = ymd("2000-01-01"),
                options = c("periodicitySelection" = "DAILY"))
    
    return(data)
}

sdev <- function(objeto) {
    
    media <- mean(objeto[,2], na.rm = T)
    desv_pad <- sd(objeto[,2], na.rm = T)
    
    objeto <- objeto %>%
        mutate(PX_LAST = (PX_LAST - media) / desv_pad)
    
    return(objeto)
}

removeNA <- function(objeto) {
    
    max_data_disponivel_temp <- max(as.Date(unlist(lapply(objeto, FUN = function(x) {end(na.omit(x))}))))
    min_data_disponivel_temp <- min(as.Date(unlist(lapply(objeto, FUN = function(x) {end(na.omit(x))}))))
    
    objeto <- objeto[paste0("/", max_data_disponivel_temp)]
    objeto <- merge(temp = index(objeto) <= as.Date(min_data_disponivel_temp), objeto)
    
    objeto <- rbind(na.omit(objeto[objeto$temp == 1,]),
                          objeto[objeto$temp == 0,])[, -1]
    
    return(objeto)
}

save <- function() {
    
    arquivo <- paste0("Dados/", list.files("Dados/")[1])
    
    file.remove(arquivo)
    
    save.image(paste0("Dados/Data & Functions ", format.Date(Sys.Date(), format = "%d-%B-%Y"), ".RData"))
    
}
