#install.packages("rvest")
library(rvest)
#leimos todo la pagina y la asignamos a una variable
pagina <- read_html("pagina.html")

#con la siguiente funcion solo sacamos la informacion que se contenga dentro de b (en este caso azul)
nodesDelHTML <- html_nodes(pagina,".azul")

#con esta nos manda solo el texto de lo que descargamos anteriormente./n son enter 
#/t son tabulaciones
texto <- html_text(nodesDelHTML)
#cambiamos los \n por nada.
texto <- gsub("\n","",texto)

nodesTabla <- html_nodes(pagina,".naranjo")
tabla1 <-html_table(html_nodes(nodesTabla,"table")[[1]])

#otra opcion
#tabla <- html_nodes(nodesTabla,"table")
#tabla1 <- html_table(tabla)[[1]]
#############################################################################
#-------------------------------Trabajando otra pagina----------------------------------------
###############################################################################
#intentamos extraer datos de una pagina.
#guardamos la pagina que trabajaremos.
html <- "https://www.emol.com/noticias/Internacional/2019/06/20/952042/Fiscal-general-de-Venezuela-le-afirma-a-Bachelet-que-la-oposicion-es-culpable-de-77-asesinatos.html"
paginaEmol <- read_html(html)
#teniendo la informacion realizamos la extraccion 
nodesDelHTMLEmol <- html_nodes(paginaEmol,"#cuDetalle_cuTexto_textoNoticia")
#solo trabajamos con el texto
textoEmol <- html_text(nodesDelHTMLEmol)
#####################################################
#--------------------Clase 21-06-2019-----------------
######################################################
#separando las palabras por espacio 
splitEspacioNoticia <- strsplit(texto," ")[[1]]

print(splitEspacioNoticia)
#pasando todas las palabras a minusculas 
splitEspacioNoticia <- tolower(splitEspacioNoticia)

#contando palabras 
unListNoticia <- unlist(splitEspacioNoticia)
tablaPalabras <- table(unListNoticia)
print(tablaPalabras)

#pasando la informacion a una data frame
dfPalabrasNoticia <- as.data.frame(tablaPalabras)

#almacenando la información en CSV
write.csv(dfPalabrasNoticia, file="PalabrasNoticia.csv")

#o en un txt(en esta parte perfectamente en vez de .txt puedo escribir .csv (.csv y .txt es solo una forma))
write.table(dfPalabrasNoticia, file="PalabrasNoticia.txt", sep = ";")

########################################################
#-----------Extraccion informacion tabla----------------
########################################################
#leimos todo la pagina y la asignamos a una variable
pagina <- read_html("pagina.html")

#con la siguiente funcion solo sacamos la informacion que se contenga dentro de b (en este caso azul)


nodesTabla <- html_nodes(pagina,".naranjo")

#extraccion de el contenido de las tablas usando el tag table 

contenedorDeTablas <- html_nodes(nodesTabla, "table")
#extracción informacion tabla 
tabla2 <- html_table(contenedorDeTablas[1][[1]])

#viendo el contenido de la posición 1,2 de la tabla1
print(tabla2[1,2])
#guardar tabla
write.table(tabla2, file="tablapagina.csv", sep = ";")

#limpiando $ comas y cambios de putnos por coma
tabla2$`Santa Isabel` <- gsub("\\$","",tabla2$`Santa Isabel`)
tabla2$Jumbo <- gsub("\\$","",tabla2$Jumbo)
#en caso de tener puntos en vez de coma ocupo lo siguiente yo eliminare las coma igual para aprender
tabla2$`Santa Isabel` <- gsub("[,]","",tabla2$`Santa Isabel`)
tabla2$Jumbo <- gsub("[,]","",tabla2$Jumbo)
#ahora cambio a numero
tabla2$`Santa Isabel` <- as.numeric(tabla2$`Santa Isabel`)
tabla2$Jumbo <- as.numeric(tabla2$Jumbo)

write.table(tabla2, file="tablapaginaConNumero.csv", sep = ";")

#para juntar dos tablas ocupo la funcion 
#tablaMerge <- rbind(tabla1,tabla2)

#para realizar una busqueda de solo algunos elementos ocupamos lo siguiente
#elementosEncontrados <- tablaMerge[which(tablamerge$nombrDeColumna==loQBuscamos),]

###############################################################################
#--------------------------------Graficos--------------------------------------
##############################################################################

#tableMerge %>%
  #ggplot() +


#############################################################################
#------------------------------tienda chilena del lirbo---------------------
#############################################################################
paginaChilenaDelLibro <- "https://www.feriachilenadellibro.cl/"

paginaChilenaRead <- read_html(paginaChilenaDelLibro)

paginaChilenaNodesImage <- html_nodes(paginaChilenaRead,".image-container")
#--------------------------------------------------------------------------

paginaChilenaNodesReferencias <- html_nodes(paginaChilenaRead,".product-item-photo")

Paginas <- html_attr(paginaChilenaNodesReferencias,"href")

for(refe in Paginas){
 print(refe)
  lecturaLibro <- read_html(refe)
  precio <- html_text(html_nodes(lecturaLibro,".price"))
  print(precio)
}


