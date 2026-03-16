# Datos

## `beta_df.RDS`

Tasas de migración por edad de los Países Bajos (1850-1950).

| Atributo | Valor |
|----------|-------|
| **Fuente** | Fedorova et al. (2022) - 300,000 mudanzas residenciales |
| **Contenido** | Vector `beta_mod_f`: 93 tasas de migración por edad |
| **Uso** | Calibra el modelo de simulación ABM |

**Lectura en R:**

```r
age_mig_NL <- readRDS("data/beta_df.RDS")$beta_mod_f
```

**Acceso remoto (Zenodo):**

```r
age_mig_NL <- readRDS(url("https://zenodo.org/records/18879419/files/beta_df.RDS?download=1"))$beta_mod_f
```

El script principal carga automáticamente desde Zenodo para garantizar reproducibilidad.

