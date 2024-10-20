# An-lisis-de-la-Distribuci-n-de-Edades-en-Diferentes-Profesiones

Este proyecto analiza la distribución de edades de un grupo de 100 personas, clasificadas por diferentes profesiones. El objetivo es identificar patrones y características comunes en las edades de cada profesión, aplicando medidas de tendencia central (media, mediana, moda) y de dispersión (varianza, desviación estándar, rango). Los resultados se visualizan mediante histogramas, gráficos circulares y diagramas de Pareto.

Estructura de los Datos
El análisis se basa en un archivo CSV (Profesiones.csv) con los siguientes campos:

id: Identificador único para cada persona.
nombre: Nombre de la persona.
edad: Edad de la persona.
profesion: Profesión de la persona.

Instrucciones de Uso
Requisitos previos:

Instalar las siguientes librerías en R:

install.packages("dplyr")
install.packages("modeest")
install.packages("ggplot2")

Preparación del entorno:

Descarga el archivo Profesiones.csv y guárdalo en tu sistema.
Abre el script analisis_profesiones.R en RStudio.
Asegúrate de que la ruta del archivo CSV esté correcta:

profesiones <- read.csv("ruta/donde/guardaste/Profesiones.csv")

Ejecutar el análisis:
Ejecuta el script completo para obtener los cálculos de las medidas y las visualizaciones.

Detalles sobre los Análisis

1. Medidas de Tendencia Central
Media: Edad promedio de cada profesión.
Mediana: Edad central de cada grupo.
Moda: Edad más frecuente en cada profesión.

2. Medidas de Dispersión
Varianza: Variabilidad de las edades.
Desviación Estándar: Desviación promedio respecto a la media.
Rango: Diferencia entre la edad máxima y mínima.

3. Visualización de los Resultados
Histograma: Distribución de edades por profesión.
Gráfico Circular: Proporción de personas en cada profesión.
Diagrama de Pareto: Frecuencia y acumulado de cada profesión.

Resultados Esperados
El análisis describe cómo se distribuyen las edades en cada profesión, resaltando tendencias y diferencias. Las visualizaciones ayudan a entender mejor la distribución de edades y la prevalencia de cada grupo profesional.

Contacto y Soporte
Para cualquier consulta, puedes contactarme a través de mi perfil de GitHub.
https://github.com/FelixR93/An-lisis-de-la-Distribuci-n-de-Edades-en-Diferentes-Profesiones
