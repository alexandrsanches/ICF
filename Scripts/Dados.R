
#### Obtenção dos dados de planilhas ####

dados1_temp <- read_excel("Dados/bm&f.xlsx", sheet = "Swaps", skip = 13,
                          col_types = c("date", "skip", "skip", "skip", "skip", "skip", "numeric",
                                        "skip", "skip", "skip", "skip", "skip", "skip", "skip",
                                        "skip"))

colnames(dados1_temp) <- c("obs", "juros_360_br") # Não tem o de 5 anos. No BCB a de 360 dias tem no Bacen (código 7806)

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

dados4_temp <- read_excel("Dados/Commodity_research_bureau.xlsx", skip = 11, sheet = "CRB Future Spot",
                          col_types = c("date", "skip", "skip", "skip", "skip", "skip", "skip", "skip",
                                        "numeric", "skip", "skip", "numeric", "skip",
                                        "skip", "skip"))

colnames(dados4_temp) <- c("obs", "crb_metals", "crb_foodstuffs")

dados5_temp <- read_excel("Dados/Commodities_spot.xlsx", skip = 11, sheet = "Energia",
                          col_types = c("date", "numeric", "numeric", "skip", "skip", "skip", "skip",
                                        "skip", "skip", "skip", "skip"))

colnames(dados5_temp) <- c("obs", "petro_brent", "petro_wti")

#### Conversão para xts ####

#### Junção dos dados em um único data frame ####
