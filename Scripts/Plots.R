#### Plots

### Juros

## Juro Brasil

juro_brasil <- juroBrasil %>%
    melt(id.vars = "data") %>%
    filter(data >= "2014-03-01") %>%
    ggplot(aes(x = data, y = value, color = variable)) +
    geom_line(na.rm = TRUE) +
    labs(x = "", y = "", color = "") +
    scale_y_continuous(labels = function(x) paste0(x, "%")) +
    ggthemes::scale_colour_economist() +
    theme(legend.position = "bottom") +
    theme(panel.background = element_rect(fill = "white", colour = "grey10")) +
    theme(panel.grid.major = element_line(colour = "gray", linetype = "dashed"))
    
## Juro Exterior

# Juro 3 meses
juro_3m <- juroExterior %>%
    select(data, juros3m_us, juros3m_uk, juros3m_jp, juros3m_de) %>%
    filter(data >= "2010-01-01") %>%
    melt(id.vars = "data") %>%
    ggplot(aes(x = data, y = value, color = variable)) +
    geom_line(na.rm = TRUE) +
    geom_hline(yintercept = 0) +
    labs(x = "", y = "", color = "") +
    scale_y_continuous(labels = function(x) paste0(x, "%")) +
    coord_cartesian(ylim = c(-1, 2.5)) +
    ggthemes::scale_colour_economist() +
    theme(legend.position = "bottom") +
    theme(panel.background = element_rect(fill = "white", colour = "grey10")) +
    theme(panel.grid.major = element_line(colour = "gray", linetype = "dashed")) +
    facet_wrap(~ variable, ncol = 2)


# Juro 2 anos
juro_2a <- juroExterior %>%
    select(data, juros2a_us, juros2a_uk, juros2a_jp, juros2a_de) %>%
    filter(data >= "2010-01-01") %>%
    melt(id.vars = "data") %>%
    ggplot(aes(x = data, y = value, color = variable)) +
    geom_line(na.rm = TRUE) +
    geom_hline(yintercept = 0) +
    labs(x = "", y = "", color = "") +
    scale_y_continuous(labels = function(x) paste0(x, "%")) +
    coord_cartesian(ylim = c(-1, 2.5)) +
    ggthemes::scale_colour_economist() +
    theme(legend.position = "bottom") +
    theme(panel.background = element_rect(fill = "white", colour = "grey10")) +
    theme(panel.grid.major = element_line(colour = "gray", linetype = "dashed")) +
    facet_wrap(~ variable, ncol = 2)

# Juro 10 anos
juro_10a <- juroExterior %>%
    select(data, juros10a_us, juros10a_uk, juros10a_jp, juros10a_de) %>%
    filter(data >= "2010-01-01") %>%
    melt(id.vars = "data") %>%
    ggplot(aes(x = data, y = value, color = variable)) +
    geom_line(na.rm = TRUE) +
    geom_hline(yintercept = 0) +
    labs(x = "", y = "", color = "") +
    scale_y_continuous(labels = function(x) paste0(x, "%")) +
    coord_cartesian(ylim = c(-1, 4)) +
    ggthemes::scale_colour_economist() +
    theme(legend.position = "bottom") +
    theme(panel.background = element_rect(fill = "white", colour = "grey10")) +
    theme(panel.grid.major = element_line(colour = "gray", linetype = "dashed")) +
    facet_wrap(~ variable, ncol = 2)


### Commodities

commodities_plot <- commodities %>%
    filter(data >= "2010-01-01") %>%
    ggplot(aes(x = data)) +
    geom_line(aes(x = data, y = crb_metal, color = "Metal")) +
    geom_line(aes(x = data, y = crb_food, color = "Food")) +
    labs(x = "", y = "", color = "", title = "CRB") +
    ggthemes::scale_colour_economist() +
    theme(legend.position = "bottom") +
    theme(panel.background = element_rect(fill = "white", colour = "grey10")) +
    theme(panel.grid.major = element_line(colour = "gray", linetype = "dashed")) 

### Mercado de capitais

merc <- mercCapitais %>%
    melt(id.vars = "data") %>%
    filter(data >= "2010-01-01") %>%
    ggplot(aes(x = data, y = value, color = variable)) +
    geom_line(na.rm = TRUE) +
    labs(x = "", y = "", color = "") +
    ggthemes::scale_colour_economist() +
    theme(legend.position = "bottom") +
    theme(panel.background = element_rect(fill = "white", colour = "grey10")) +
    theme(panel.grid.major = element_line(colour = "gray", linetype = "dashed")) +
    facet_wrap(~ variable, ncol = 1, scales = "free_y")

### Moedas 

moeda <- moedas %>%
    melt(id.vars = "data") %>%
    filter(data >= "2012-01-01") %>%
    ggplot(aes(x = data, y = value, color = variable)) +
    geom_line(na.rm = TRUE) +
    labs(x = "", y = "", color = "") +
    ggthemes::scale_colour_economist() +
    theme(legend.position = "bottom") +
    theme(panel.background = element_rect(fill = "white", colour = "grey10")) +
    theme(panel.grid.major = element_line(colour = "gray", linetype = "dashed")) +
    facet_wrap(~ variable, ncol = 1, scales = "free_y")
    
### Petroleo

wti_brent <- petroleo %>%
    melt(id.vars = "data") %>%
    filter(data >= "2010-01-01") %>%
    ggplot(aes(x = data, y = value, color = variable)) +
    geom_line(na.rm = TRUE) +
    labs(x = "", y = "", color = "") +
    ggthemes::scale_colour_economist() +
    theme(legend.position = "bottom") +
    theme(panel.background = element_rect(fill = "white", colour = "grey10")) +
    theme(panel.grid.major = element_line(colour = "gray", linetype = "dashed")) +
    facet_wrap(~ variable)

petro_separado <- petroleo %>%
    filter(data >= "2010-01-01") %>%
    ggplot(aes(x = data)) +
    geom_line(aes(x = data, y = petro_wti, color = "WTI"), na.rm = TRUE) +
    geom_line(aes(x = data, y = petro_brent, color = "Brent"), na.rm = TRUE) +
    labs(x = "", y = "", color = "") +
    ggthemes::scale_colour_economist() +
    theme(legend.position = "bottom") +
    theme(panel.background = element_rect(fill = "white", colour = "grey10")) +
    theme(panel.grid.major = element_line(colour = "gray", linetype = "dashed"))
    
### Risco

risk <- risco %>%
    melt(id.vars = "data") %>%
    filter(data >= "2010-01-01") %>%
    ggplot(aes(x = data, y = value, color = variable)) +
    geom_line(na.rm = TRUE) +
    labs(x = "", y = "", color = "") +
    ggthemes::scale_colour_economist() +
    theme(legend.position = "bottom") +
    theme(panel.background = element_rect(fill = "white", colour = "grey10")) +
    theme(panel.grid.major = element_line(colour = "gray", linetype = "dashed"))

