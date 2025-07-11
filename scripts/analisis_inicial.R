# --------------------------------------------
# Fase 4 - Análisis inicial descriptivo
# Proyecto Cyclistic - Alonso
# --------------------------------------------

library(tidyverse)

# Cargar archivo consolidado limpio
datos <- read_csv("C:/Users/Alonso/OneDrive/Escritorio/Cyclistic_Proyecto - Caso 1/Cyclistic_Proyecto - Caso 1/Datos_limpios/datos_consolidados.csv")

# Convertir ride_length a numérico (por seguridad)
datos$ride_length <- as.numeric(datos$ride_length)

# 1. Número de viajes por tipo de usuario
viajes_por_usuario <- datos %>%
  group_by(member_casual) %>%
  summarise(viajes = n())

print(viajes_por_usuario)

# 2. Duración promedio de los viajes por tipo de usuario
duracion_promedio <- datos %>%
  group_by(member_casual) %>%
  summarise(promedio_minutos = mean(ride_length),
            mediana_minutos = median(ride_length))

print(duracion_promedio)

# 3. Viajes por día de la semana
viajes_por_dia <- datos %>%
  group_by(member_casual, day_of_week) %>%
  summarise(viajes = n()) %>%
  arrange(member_casual, desc(viajes))

print(viajes_por_dia)
