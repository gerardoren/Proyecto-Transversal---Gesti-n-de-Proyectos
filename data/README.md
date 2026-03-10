# Data

Esta carpeta contiene los datos de entrada utilizados para la reproduccion del resultado seleccionado del articulo de Deffner et al. (2024).

---

## Archivos incluidos

### `beta_df.RDS`

Datos empiricos de trayectorias de migracion por edad, derivados de registros historicos de Paises Bajos.

| Atributo | Valor |
|----------|-------|
| **Formato** | Objeto R serializado (`.RDS`), legible con `readRDS()` |
| **Contenido** | Lista con el campo `beta_mod_f`: vector numerico de 93 elementos |
| **Interpretacion** | Cada elemento representa la tasa de migracion para una edad especifica (edades 1 a 93) |
| **Fuente** | Fedorova, N. et al. (2022). *The complex life course of mobility: Quantitative description of 300,000 residential moves in 1850-1950 Netherlands* |
| **Articulo original** | Deffner et al. (2024), PNAS 121(48) |

**Acceso remoto (Zenodo):**

El script principal carga estos datos directamente desde Zenodo para garantizar reproducibilidad:

```
https://zenodo.org/records/18879419/files/beta_df.RDS?download=1
```

La copia local en esta carpeta sirve como respaldo.

**Lectura en R:**

```r
# Desde archivo local
age_mig_NL <- readRDS("data/beta_df.RDS")$beta_mod_f

# Desde Zenodo (como lo hace el script principal)
age_mig_NL <- readRDS(url("https://zenodo.org/records/18879419/files/beta_df.RDS?download=1"))$beta_mod_f
```

---

## Uso en el pipeline

Los datos de migracion se usan en dos momentos del analisis:

1. **Simulacion ABM (Etapa 1):** Las tasas de migracion por edad calibran las probabilidades de que un agente migre a otro grupo en cada paso temporal. Se accede a la tasa de migracion de un agente con `m[Age]`, donde `Age` es la edad actual del agente.

2. **Visualizacion (Panel c de la Figura 4):** Las tasas reales se sobreponen como linea punteada sobre las estimaciones del modelo bayesiano, para evaluar que tan bien el modelo recupera los datos empiricos.

---

## Notas

- Los datos **no son generados** por el equipo; provienen de los insumos publicos del repositorio oficial del articulo.
- Se respetan las licencias y atribuciones de los autores originales.
- Si el enlace de Zenodo deja de funcionar, la copia local `beta_df.RDS` permite continuar con el analisis.

---

## Licencia y atribucion

- **Datos originales:** Deffner et al. (2024), Proceedings of the National Academy of Sciences.
- **Datos fuente de migracion:** Fedorova et al. (2022).
