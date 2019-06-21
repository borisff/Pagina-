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
gsub("\n","",texto)

nodesTabla <- html_nodes(pagina,".naranjo")
tabla1 <-html_table(html_nodes(nodesTabla,"table")[[1]])

#otra opcion
#tabla <- html_nodes(nodesTabla,"table")
#tabla1 <- html_table(tabla)[[1]]
#----------------------------------------------------------------------------

#intentamos extraer datos de una pagina.
read_html("weather.html")
