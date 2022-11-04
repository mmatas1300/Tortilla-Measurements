# Medición de parámetros de testales

<p align="center">
    <img src="imgs/RadiosTestal.png" height="400"/>
</p>

 <h2>Bordes de la imagen</h2>
    
Para resaltar aquellos píxeles considerados frontera o que estén cerca de ella, se utiliza el gradiente ya que permite determinar si un píxel es o no de borde. El gradiente de una imagen $f(x,y)$ en un punto de coordenadas $(x,y)$ se define como un vector bidimensional, siendo perpendicular al borde [1].

<h2>Firma de la imagen</h2> 
<p>
Consiste en la detección de puntos de interés en la imagen en los que se producen diferencias de gradiente significativas y luego construir un histograma con la información de la distancia de los puntos de interés a otro en específico, el centroide; esto permite generar un conjunto de datos único para cada tipo de imagen y a partir de intervalos establecidos, conocer si la imagen de la que se trata tiene alguna morfología en particular o no.
</p>