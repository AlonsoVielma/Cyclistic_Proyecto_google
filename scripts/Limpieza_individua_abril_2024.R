datos <- read.csv(file.choose(), header = TRUE)
abril_2024 <- datos

# --------------------------------------------------
# Limpieza de datos: abril_2024
# Proyecto: Cyclistic - Portafolio Analista de Datos
# Autor: Alonso
# --------------------------------------------------

library(readr)
library(dplyr)
library(lubridate)

# 1. Cargar archivo CSV manualmente
abril_2024 <- read_csv(file.choose()) 

# 2. Verificar estructura
print(paste("Filas:", nrow(abril_2024)))
print(paste("Columnas:", ncol(abril_2024)))
str(abril_2024)

# 3. Convertir fechas
abril_2024 <- abril_2024 %>%
  mutate(
    started_at = as.POSIXct(started_at),
    ended_at   = as.POSIXct(ended_at)
  )

# 4. Calcular duración en minutos
abril_2024 <- abril_2024 %>%
  mutate(ride_length = as.numeric(difftime(ended_at, started_at, units = "mins")))

# 5. Agregar columna día de la semana
abril_2024 <- abril_2024 %>%
  mutate(day_of_week = weekdays(started_at))

# 6. Filtrar viajes inválidos (negativos, 0 o >24h)
abril_2024 <- abril_2024 %>%
  filter(ride_length > 0 & ride_length <= 1440)

# 7. Eliminar duplicados por ride_id
abril_2024 <- abril_2024 %>%
  distinct(ride_id, .keep_all = TRUE)

# 8. Mostrar resumen de nulos
cat("\nResumen de valores nulos por columna:\n")
print(colSums(is.na(abril_2024)))

# 9. Guardar archivo limpio
write_csv(abril_2024,
          "C:/Users/Alonso/OneDrive/Escritorio/Cyclistic_Proyecto - Caso 1/Cyclistic_Proyecto - Caso 1/Datos_limpios/2024-04_abril_limpio.csv"
)

cat("\n✅ Archivo limpio de abril guardado con éxito.\n")

