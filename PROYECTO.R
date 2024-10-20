file.choose()

#Importar mi dataframe
profesiones <- read.csv("C:\\Users\\USER1\\Downloads\\Profesiones.csv")

#Verificar las primeras filas de mi dataframe
head(profesiones)

#Cargamos las librerías necesarias
library(dplyr)
library(modeest)

#Cálculo de las medidas de tendencia centrales para cada profesión (media, mediana, moda)
tendencia_central <- profesiones %>%
  group_by(profesion) %>%
  summarise(
    Media = mean(edad),
    Mediana = median(edad),
    #Este método nos sirve para extraer el valor de la moda
    Moda = as.numeric(mlv(edad, method = "mfv")[1])
  )

#mostramos el cálculo de la tendencia central
print("Las medidas de tendencia central muestran la edad promedio (Media), la edad central (Mediana) y la edad más frecuente (Moda) de cada profesión.")
print(tendencia_central)



#Cáculo de las medidas de dispersión de las profesiones (varianza, desviación estándar, rango)
dispersión <- profesiones %>%
  group_by(profesion) %>%
  summarise(
    Varianza = var(edad),
    DesviacionEstandar = sd(edad), 
    Rango = max(edad) - min(edad)
  )

#Imprimimos el cálculo de las medidas de dispersión
print("Las medidas de dispersión indican la variabilidad de las edades en cada profesión: la Varianza, Desviación Estándar, y el Rango entre la edad más joven y la más vieja.")
print(dispersión)


#Visualización de Datos
#Cargamos la librería ggplot2
library(ggplot2)

#Creamos un histograma de edades por profesión
ggplot(profesiones, aes(x = edad, fill = profesion)) +
  geom_histogram(binwidth = 5, position = "dodge", alpha = 0.7) +
  theme_minimal() + 
  labs(title = "Distribución de edades por profesión",
       x = "Edad",
       y = "Frecuencia")

#Vamos a realizar el gráfico circular
#Cálculamos la proporción de cada profesión
profesion_count <- profesiones %>%
  count(profesion) %>%
  mutate(percentage = n / sum(n) * 100)

#Creamos el gráfico curcular
ggplot(profesion_count, aes(x = "", y = percentage, fill = profesion)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y", start = 0)+
  theme_void() +
  labs(title = "Distribución de Profesiones") + 
  theme(legend.position = "right")


#Vamos a realizar el diagrama de Pareto
#Preparamos los datos para el diagrama de pareto
pareto_data <- profesiones %>%
  group_by(profesion) %>%
  summarise(Count = n()) %>%
  arrange(desc(Count)) %>%
  mutate(Cumulative = cumsum(Count) / sum(Count) * 100)

# Crear el gráfico de Pareto
ggplot(pareto_data, aes(x = reorder(profesion, -Count), y = Count)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  geom_line(aes(x = profesion, y = Cumulative, group = 1), color = "blue", size = 1) +
  geom_point(aes(x = profesion, y = Cumulative), color = "red", size = 2) +
  labs(title = "Diagrama de Pareto de Profesiones", x = "Profesión", y = "Frecuencia") +
  theme_minimal()
