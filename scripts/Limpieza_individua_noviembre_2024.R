# limpieza.individual.R

# Cargar librerías necesarias
library(readr)
library(dplyr)
library(lubridate)


datos <- read.csv(file.choose(), header = TRUE)
noviembre_2024 <- datos

# --------------------------------------------------
# Limpieza de datos: noviembre_2024
# Proyecto: Cyclistic - Portafolio Analista de Datos
# Autor: Alonso
# Fecha: [Reemplazar con la fecha actual]
# --------------------------------------------------

# 0. Cargar librerías necesarias
library(readr)
library(dplyr)
library(lubridate)

# 1. Cargar archivo CSV manualmente
noviembre_2024 <- read_csv(file.choose())  # Archivo 202411-divvy-tripdata.csv

# 2. Verificar estructura básica del archivo
print(paste("Número de filas:", nrow(noviembre_2024)))
print(paste("Número de columnas:", ncol(noviembre_2024)))
str(noviembre_2024)
head(noviembre_2024)

# 3. Convertir columnas de fecha/hora
noviembre_2024 <- noviembre_2024 %>%
  mutate(
    started_at = as.POSIXct(started_at),
    ended_at   = as.POSIXct(ended_at)
  )

# 4. Crear columna 'ride_length' (duración en minutos)
noviembre_2024 <- noviembre_2024 %>%
  mutate(ride_length = as.numeric(difftime(ended_at, started_at, units = "mins")))

# 5. Crear columna 'day_of_week' (día de la semana)
noviembre_2024 <- noviembre_2024 %>%
  mutate(day_of_week = weekdays(started_at))

# 6. Eliminar viajes inválidos (duración negativa, 0 o más de 24h)
noviembre_2024 <- noviembre_2024 %>%
  filter(ride_length > 0 & ride_length <= 1440)

# 7. Eliminar rides duplicados
noviembre_2024 <- noviembre_2024 %>%
  distinct(ride_id, .keep_all = TRUE)

# 8. Resumen de valores nulos por columna
cat("\nResumen de valores nulos:\n")
print(colSums(is.na(noviembre_2024)))

# 9. Guardar archivo limpio
write_csv(
  noviembre_2024,
  "C:/Users/Alonso/OneDrive/Escritorio/Cyclistic_Proyecto - Caso 1/Cyclistic_Proyecto - Caso 1/Datos_limpios/2024-11_noviembre_limpio.csv"
)

cat("\n✅ Limpieza finalizada. Archivo guardado con éxito.\n")

