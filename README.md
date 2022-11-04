# Medición de parámetros de testales

<p align="center">
    <img src="imgs/RadiosTestal.png" height="400"/>
</p>

<math>
    <mrow>
        <mrow>
            <mi>f</mi>
            <mo>(</mo>
            <mi>x</mi>
            <mo>)</mo>
        </mrow>
        <mo>=</mo>
        <mrow>
            <mmultiscripts>
                <mo>&Integral;</mo>
                <mi>a</mi>
                <mi>b</mi>
            </mmultiscripts>
            <mrow>
                <mi>K</mi>
                <mo>(</mo>
                <mi>x</mi>
                <mo>,</mo>
                <mi>t</mi>
                <mo>)</mo>
            </mrow>
            <mrow>
                <mi>&phi;</mi>
                <mo>(</mo>
                <mi>t</mi>
                <mo>)</mo>
            </mrow>
            <mi>d</mi>
            <mi>t</mi>
        </mrow>
    </mrow>
</math>


<h2>Firma de la imagen</h2> 
<p>
Consiste en la detección de puntos de interés en la imagen en los que se producen diferencias de gradiente significativas y luego construir un histograma con la información de la distancia de los puntos de interés a otro en específico, el centroide; esto permite generar un conjunto de datos único para cada tipo de imagen y a partir de intervalos establecidos, conocer si la imagen de la que se trata tiene alguna morfología en particular o no.
</p>