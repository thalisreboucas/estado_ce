library(rvest , quietly = TRUE)
library(tidyverse , quietly = TRUE)
library(leaflet , quietly =  TRUE)
library(stringr , quietly = TRUE)

# Web scraping dos bairros caucaia

url_base <- paste0("https://cep.guiamais.com.br/busca/caucaia-ce?page=NUMBER")
dados <- data.frame()
for(i in 1:93){
  url <- stringr::str_replace(url_base, "NUMBER", as.character(i))
  print(url)
  lista.tabelas <- xml2::read_html(url) %>% rvest::html_table(header = T)
  tabela <- lista.tabelas[[1]]
  dados <- dplyr::bind_rows(dados, tabela)
}

dados <- dplyr::rename(dados ,BAIRRO = BAIRRO...2 , CIDADE_ESTADO = BAIRRO...4 )

dplyr::count(dados,BAIRRO) %>% View()

Pop <- xml2::read_html("https://populacao.net.br/os-maiores-bairros-caucaia_ce.html") %>% 
  rvest::html_table(header = T) %>% data.frame()


Pop$População[47] <- Pop$População[47]/1000
Pop$População[48] <- Pop$População[48]/1000
Pop$População[49] <- Pop$População[49]/1000
Pop$População[50] <- Pop$População[50]/1000
Pop$População[51] <- Pop$População[51]/1000
Pop$População[52] <- Pop$População[52]/1000
Pop$População[53] <- Pop$População[53]/1000
Pop$População[54] <- Pop$População[54]/1000
Pop$População[55] <- Pop$População[55]/1000
Pop$População[56] <- Pop$População[56]/1000
Pop$População[57] <- Pop$População[57]/1000

# Mapa de Caucaia
# rua jurupari 711 caucaia



Caucaia_pop <- Pop %>% mutate(População = População * 1000)
Caucaia_pop <- Caucaia_pop %>% mutate(População = round((População/sum(População)* 368918 )) )

setwd("E:/edime/Thalis/Execel")
write.table(Caucaia_pop, file="Caucaia_pop.csv", sep=";")

leaflet::leaflet() %>% 
  addTiles() %>%  
  addMarkers(lat = -3.7583621579693793, lng = -38.61966176042286, popup = "Jurema") %>% 
  addCircles(lat = -3.7583621579693793, lng = -38.61966176042286,weight = 1 , radius = 4000) 

Caucaia <- 13

BAIRROS_RAIOS <- c(
  "Parque São Gerardo - Caucaia",
  "Quintino Cunha",
  "Tabapuá - Caucaia",
  "Tabapuá Brasília - Caucaia",
  "Tabapuá Brasília II - Caucaia",
  "Parque das Nações - Caucaia",
  "Austran Nunes",
  "Geninaú",
  "Sobradinho - Caucaia",
  "Parque Potira - Caucaia",
  "Guadalajara - Caucaia",
  "Antônio Bezerra",
  "Conjuto Ceará I",
  "Conjuto Ceará II",
  "Araturi - Caucaia",
  "Marechal Rondon - Caucaia",
  "Urucutuba - Caucaia",
  "Granja Lisboa - Caucaia",
  "Granja Portugal",
  "Henrique Jorge",
  "Patrícia Gomes - Caucaia ",
  "João XXII"
    )


# Web scraping dos bairros Fortaleza 

url_fortal <- paste0("https://cep.guiamais.com.br/busca/fortaleza-ce?page=NUMBER")
dados_fortaleza <- data.frame()
for(i in 1:400){
  url <- stringr::str_replace(url_fortal, "NUMBER", as.character(i))
  print(url)
  lista.tabelas <- xml2::read_html(url) %>% rvest::html_table(header = T)
  tabela <- lista.tabelas[[1]]
  dados_fortaleza <- dplyr::bind_rows(dados_fortaleza, tabela)
}

dados_fortaleza <- dplyr::rename(dados_fortaleza ,BAIRRO = BAIRRO...2 , CIDADE_ESTADO = BAIRRO...4 )

setwd("E:/edime/Thalis/Excel")
write.table(dados_fortaleza, file="Fortaleza.csv", sep=";")

