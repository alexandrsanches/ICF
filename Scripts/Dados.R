
#### Obtenção dos dados de planilhas ####

dados1_temp <- read_excel("Dados/bm&f.xlsx", sheet = "Swaps", skip = 13)[, c(1, 7, 9)]
colnames(dados1_temp) <- c("obs", "juros_360_br") # Não tem o de 5 anos. No BCB a de 360 dias tem no Bacen (código 7806)

dados2_temp <- read_excel("Dados/credit_Default_Swap.xlsx", skip = 11)[, c(1, 8)]
colnames(dados2_temp) <- c("obs", "cds_br")

dados3_temp <- read_excel("Dados/vix.xlsx", skip = 11)[, c(1, 2)]
colnames(dados3_temp) <- c("obs", "vix")

dados4_temp <- read_excel("Dados/Commodity_research_bureau.xlsx",
                          col_types = c("date", "skip", "skip", "skip", "skip", "skip", "skip",
                                        "skip", "numeric", "skip", "skip", "numeric", "skip",
                                        "skip", "skip"), skip = 11)
colnames(dados4_temp) <- c("obs", "crb_metals", "crb_foodstuffs")
