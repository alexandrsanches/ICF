#### Funções

AutoBloomberg <- function(ticker) {
    
    data <- bdh(ticker, c("PX_LAST"),
                start.date = ymd("2000-01-01"),
                options = c("periodicitySelection" = "DAILY"))
    
    return(data)
}


AutoBloombergTendencia <- function(ticker) {
    
    data <- bdh(ticker, c("PX_LAST"),
                start.date = ymd("2000-01-01"),
                options = c("periodicitySelection" = "DAILY"))
    
    serie <- lm(data$PX_LAST ~ seq(1, nrow(data), 1))
    
    data$PX_LAST <- serie$residuals
    
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

# save <- function() {
#     
#     arquivo <- paste0("Dados/", list.files("Dados/")[1])
#     
#     file.remove(arquivo)
#     
#     save.image(paste0("Dados/Data & Functions ", format.Date(Sys.Date(), format = "%d-%B-%Y"), ".RData"))
#     
# }

AutoBCB <- function(codigoBCB, period) {
    
    enderecoBCB <- paste("http://api.bcb.gov.br/dados/serie/bcdata.sgs.", codigoBCB, "/dados?formato=csv", sep = "")
    
    dados <- read.csv2(url(enderecoBCB))
    
    if (period == "dia") {
        colnames(dados) <- c("dia", "valor")
        dados$dia <- as.Date(dados$dia, format = "%d/%m/%Y")
    }
    
    if (period == "mes") {
        colnames(dados) <- c("mes", "valor")
        dados$mes <- as.Date(dados$mes, format = "%d/%m/%Y")
    }
    
    if (period == "tri") {
        colnames(dados) <- c("trimestre", "valor")
        dados$trimestre <- as.Date(dados$trimestre, format = "%d/%m/%Y")
    }
    
    if (period == "ano") {
        colnames(dados) <- c("ano", "valor")
        dados$ano <- as.Date(dados$ano, format = "%d/%m/%Y")
    }
    
    dados$valor <- ifelse(dados$valor == "-", NA, dados$valor)
    
    print(paste("Endereço: ", enderecoBCB, sep = ""))
    
    return(dados)
}
