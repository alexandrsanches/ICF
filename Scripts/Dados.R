
#### Obtenção dos dados de planilhas ####

dados1_temp <- read_excel("Dados/bm&f.xlsx", sheet = "Swaps", skip = 13,
                          col_types = c("date", "skip", "skip", "skip", "skip", "skip", "numeric",
                                        "skip", "skip", "skip", "skip", "skip", "skip", "skip",
                                        "skip"))

colnames(dados1_temp) <- c("obs", "juros_360d_br") # Não tem o de 5 anos. No BCB a de 360 dias tem no Bacen (código 7806)

dados2_temp <- read_excel("Dados/credit_Default_Swap.xlsx", sheet = "CDS", skip = 11,
                          col_types = c("date", "skip", "skip", "skip", "skip", "skip", "skip",
                                        "numeric", "skip", "skip", "skip", "skip", "skip", "skip",
                                        "skip", "skip", "skip", "skip", "skip", "skip", "skip",
                                        "skip", "skip", "skip", "skip", "skip", "skip", "skip",
                                        "skip", "skip", "skip", "skip"))

colnames(dados2_temp) <- c("obs", "cds_br")

dados3_temp <- read_excel("Dados/vix.xlsx", sheet = "VIX", skip = 11,
                          col_types = c("date", "numeric", "skip"))

colnames(dados3_temp) <- c("obs", "vix")

dados4_temp <- read_excel("Dados/Commodity_research_bureau.xlsx", sheet = "CRB Future Spot", skip = 11,
                          col_types = c("date", "skip", "skip", "skip", "skip", "skip", "skip", "skip",
                                        "numeric", "skip", "skip", "numeric", "skip",
                                        "skip", "skip"))

colnames(dados4_temp) <- c("obs", "crb_metals", "crb_foodstuffs")

dados5_temp <- read_excel("Dados/Commodities_spot.xlsx", sheet = "Energia", skip = 11,
                          col_types = c("date", "numeric", "numeric", "skip", "skip", "skip", "skip",
                                        "skip", "skip", "skip", "skip"))

colnames(dados5_temp) <- c("obs", "petro_brent", "petro_wti")

dados6_temp <- read_excel("Dados/Indicadores.xlsx", sheet = "Câmbio - Brasil", skip = 11,
                          col_types = c("date", "skip", "numeric", "skip", "skip", "skip"))

colnames(dados6_temp) <- c("obs", "cambio")

dados7_temp <- read_excel("Dados/Indicadores.xlsx", sheet = "Bovespa", skip = 11,
                          col_types = c("date", "numeric", "skip", "skip", "skip"))

colnames(dados7_temp) <- c("obs", "ibovespa")

dados8_temp <- read_excel("Dados/Indicadores.xlsx", sheet = "Treasuries", skip = 11,
                          col_types = c("date", "skip", "numeric", "skip", "skip", "numeric",
                                        "skip", "skip", "skip", "numeric", "skip", "skip"))

colnames(dados8_temp) <- c("obs", "juros_us_3m", "juros_us_2a", "juros_us_10a")

#### Conversão para xts ####

dados1_temp <- xts(x = dados1_temp[, -1], order.by = dados1_temp$obs)["2002/"]
dados2_temp <- xts(x = dados2_temp[, -1], order.by = dados2_temp$obs)["2002/"]
dados3_temp <- xts(x = dados3_temp[, -1], order.by = dados3_temp$obs)["2002/"]
dados4_temp <- xts(x = dados4_temp[, -1], order.by = dados4_temp$obs)["2002/"]
dados5_temp <- xts(x = dados5_temp[, -1], order.by = dados5_temp$obs)["2002/"]
dados6_temp <- xts(x = dados6_temp[, -1], order.by = dados6_temp$obs)["2002/"]
dados7_temp <- xts(x = dados7_temp[, -1], order.by = dados7_temp$obs)["2002/"]
dados8_temp <- xts(x = dados8_temp[, -1], order.by = dados8_temp$obs)["2002/"]

#### Junção dos dados em um único data frame ####

dados <- merge.xts(dados1_temp, dados2_temp, dados3_temp, dados5_temp, dados6_temp, dados7_temp, dados8_temp) # O dados4_temp está dando problema!

#### Limpeza do ambiente ####

remove(list = ls(pattern = "_temp"))
