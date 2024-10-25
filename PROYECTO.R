# ---------------------------------------------------------------
# Análisis de la Distribución de Edades en Diferentes Profesiones
# ---------------------------------------------------------------

#Instalar librerias
install.packages("dplyr")
install.packages("modeest")
install.packages("ggplot2")
install.packages("viridis")

# Cargar las librerías necesarias
library(dplyr)
library(modeest)
library(ggplot2)
library(plotly)
library(viridis)

file.choose()

# ---------------------------------------------------------------
# Importación de Datos
# ---------------------------------------------------------------
# Importar el dataframe de profesiones
profesiones <- read.csv("C:\\Users\\Lenovo\\Downloads\\Profesiones.csv")

# Verificar las primeras filas del dataframe
head(profesiones)

# ---------------------------------------------------------------
# Cálculo de Medidas de Tendencia Central
# ---------------------------------------------------------------
tendencia_central <- profesiones %>%
  group_by(profesion) %>%
  summarise(
    Media = mean(edad, na.rm = TRUE),
    Mediana = median(edad, na.rm = TRUE),
    Moda = as.numeric(mlv(edad, method = "mfv")[1])
  )

# Mostrar el cálculo de las medidas de tendencia central
cat("Medidas de Tendencia Central:\n")
print(tendencia_central)

# ---------------------------------------------------------------
# Cálculo de Medidas de Dispersión
# ---------------------------------------------------------------
dispersión <- profesiones %>%
  group_by(profesion) %>%
  summarise(
    Varianza = var(edad, na.rm = TRUE),
    DesviacionEstandar = sd(edad, na.rm = TRUE), 
    Rango = max(edad, na.rm = TRUE) - min(edad, na.rm = TRUE)
  )

# Imprimir el cálculo de las medidas de dispersión
cat("\nMedidas de Dispersión:\n")
print(dispersión)

# ---------------------------------------------------------------
# Visualización de Datos
# ---------------------------------------------------------------

# 1. Histograma de Edades por Profesión
# Este gráfico muestra la distribución de edades de cada profesión, facilitando la comparación visual.
histograma <- ggplot(profesiones, aes(x = edad, fill = profesion)) +
  geom_histogram(binwidth = 5, position = "dodge", alpha = 0.7) +
  theme_minimal() + 
  labs(title = "Distribución de Edades por Profesión",
       subtitle = "Comparativa de la distribución de edades según la profesión",
       caption = "Fuente: Distrubución de edades",
       x = "Edad",
       y = "Frecuencia") +
  scale_fill_viridis(discrete = TRUE, name = "Profesión")

# Mostrar el histograma.
print(histograma)

# 2. Histograma 2D de Edades por Profesión utilizando Plotly
# Este gráfico interactivo muestra un histograma de edades con colores para cada profesión.
fig_hist <- plot_ly(data = profesiones, x = ~edad, color = ~profesion, type = "histogram2d", 
                    colors = viridis(10)) %>%  
  layout(title = "Distribución de Edades por Profesión",
         subtitle = "Histograma 2D interactivo para explorar la distribución de edades",
         scene = list(xaxis = list(title = "Edad"),
                      yaxis = list(title = "Frecuencia"),
                      zaxis = list(title = "Profesión")))

# Mostrar el gráfico interactivo.
fig_hist

# 3. Gráfico Circular de Distribución de Profesiones
# Muestra la proporción de cada profesión en el dataset usando un gráfico de pastel.
profesion_count <- profesiones %>%
  count(profesion) %>%
  mutate(percentage = n / sum(n) * 100)

fig_pie <- plot_ly(profesion_count, labels = ~profesion, values = ~percentage, type = "pie", 
                   textinfo = 'label+percent', insidetextorientation = 'radial') %>%
  layout(title = list(text = "Distribución de Profesiones<br><sup>Porcentaje de cada profesión en el conjunto de datos</sup>"),
         showlegend = TRUE)


# Mostrar el gráfico de pastel interactivo.
fig_pie

# 4. Diagrama de Pareto de Profesiones
# Un diagrama de Pareto combina un gráfico de barras (frecuencia) con una línea de acumulación.
pareto_data <- profesiones %>%
  group_by(profesion) %>%
  summarise(Count = n()) %>%
  arrange(desc(Count)) %>%
  mutate(Cumulative = cumsum(Count) / sum(Count) * 100)

# Crear el gráfico de Pareto con barras y línea de porcentaje acumulado
fig_pareto <- plot_ly(pareto_data, x = ~reorder(profesion, -Count), y = ~Count, type = "bar", 
                      name = "Frecuencia", marker = list(color = 'skyblue')) %>%
  add_trace(x = ~reorder(profesion, -Count), y = ~Cumulative * max(Count) / 100, 
            type = "scatter", mode = "lines+markers", 
            name = "Porcentaje Cumulativo", line = list(color = 'blue')) %>%
  layout(
    title = list(text = "Diagrama de Pareto de Profesiones<br><sup>Frecuencia y porcentaje acumulativo de profesiones</sup>"),
    yaxis = list(title = "Frecuencia"),
    xaxis = list(title = "Profesión"),
    yaxis2 = list(title = "Porcentaje Acumulativo", overlaying = "y", side = "right")
  )
# Mostrar el diagrama de Pareto interactivo.
fig_pareto
