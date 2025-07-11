# --------------------------------------------
# Fase 3 - Procesar datos unificados
# Proyecto Cyclistic - Alonso
# --------------------------------------------

library(tidyverse)

# 1. Cargar archivos limpios
abril <- read_csv("C:/Users/Alonso/OneDrive/Escritorio/Cyclistic_Proyecto - Caso 1/Cyclistic_Proyecto - Caso 1/Datos_limpios/2024-04_abril_limpio.csv")
mayo  <- read_csv("C:/Users/Alonso/OneDrive/Escritorio/Cyclistic_Proyecto - Caso 1/Cyclistic_Proyecto - Caso 1/Datos_limpios/2024-05_mayo_limpio.csv")
nov   <- read_csv("C:/Users/Alonso/OneDrive/Escritorio/Cyclistic_Proyecto - Caso 1/Cyclistic_Proyecto - Caso 1/Datos_limpios/2024-11_noviembre_limpio.csv")

nrow(abril)
nrow(mayo)
nrow(nov)

# 2. Unir los tres datasets
datos_consolidados <- bind_rows(abril, mayo, nov)

# Confirmar dimensiones
cat("✔️ Total de registros combinados:", nrow(datos_consolidados), "\n")
cat("✔️ Total de columnas:", ncol(datos_consolidados), "\n")

head(datos_consolidados)
str(datos_consolidados)

# 3. Revisiones finales

# A) Verificar duplicados por ride_id
duplicados <- sum(duplicated(datos_consolidados$ride_id))
cat("❗ Registros duplicados por ride_id:", duplicados, "\n")

# Eliminar duplicados si existen
datos_consolidados <- datos_consolidados %>%
  distinct(ride_id, .keep_all = TRUE)

# B) Revisar nulos por columna
cat("\n📌 Resumen de valores nulos por columna:\n")
print(colSums(is.na(datos_consolidados)))

# C) Filtrar viajes inválidos (ride_length <= 0 o > 24 horas)
datos_consolidados <- datos_consolidados %>%
  filter(!is.na(ride_length), ride_length > 0, ride_length <= 1440)

# D) Confirmar dimensiones después de limpieza
cat("\n✅ Registros finales después de limpieza:", nrow(datos_consolidados), "\n")

# 4. Guardar archivo consolidado
write_csv(
  datos_consolidados,
  "C:/Users/Alonso/OneDrive/Escritorio/Cyclistic_Proyecto - Caso 1/Cyclistic_Proyecto - Caso 1/Datos_limpios/datos_consolidados.csv"
)

cat("\n✅ Archivo consolidado guardado con éxito.\n")
