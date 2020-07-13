########################################################
#                                                      #
# AutoIBGE: script para obtenção de dados do SGS/Bacen #
#                              Henrique Andrade (2017) #
#                                                      #
########################################################

# http://api.bcb.gov.br/dados/serie/bcdata.sgs.CODIGO_SERIE/dados?formato=csv

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
