# Cargar librerías
library(tidyverse)

# Cargar el dataset consolidado limpio
datos <- read_csv("C:/Users/Alonso/OneDrive/Escritorio/Cyclistic_Proyecto - Caso 1/Cyclistic_Proyecto - Caso 1/Datos_limpios/datos_consolidados.csv")

# Total de viajes por tipo de usuario
viajes_por_usuario <- datos %>%
  group_by(member_casual) %>%
  summarise(viajes = n())

# Duración promedio y mediana por usuario
duracion_promedio <- datos %>%
  group_by(member_casual) %>%
  summarise(promedio_minutos = mean(ride_length),
            mediana_minutos = median(ride_length))

# Total de viajes por día de la semana
viajes_por_dia <- datos %>%
  group_by(member_casual, day_of_week) %>%
  summarise(viajes = n())

# Asegurar el orden de los días
viajes_por_dia$day_of_week <- factor(
  viajes_por_dia$day_of_week,
  levels = c("lunes", "martes", "miércoles", "jueves", "viernes", "sábado", "domingo")
)

ggplot(viajes_por_usuario, aes(x = member_casual, y = viajes, fill = member_casual)) +
  geom_col() +
  labs(
    title = "Total de viajes por tipo de usuario",
    x = "Tipo de usuario",
    y = "Cantidad de viajes"
  ) +
  theme_minimal()

ggplot(duracion_promedio, aes(x = member_casual, y = promedio_minutos, fill = member_casual)) +
  geom_col() +
  labs(
    title = "Duración promedio de los viajes por tipo de usuario",
    x = "Tipo de usuario",
    y = "Duración promedio (minutos)"
  ) +
  theme_minimal()

ggplot(viajes_por_dia, aes(x = day_of_week, y = viajes, fill = member_casual)) +
  geom_col(position = "dodge") +
  labs(
    title = "Viajes por día de la semana",
    x = "Día de la semana",
    y = "Cantidad de viajes",
    fill = "Tipo de usuario"
  ) +
  theme_minimal()
