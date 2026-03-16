# Scripts de Análisis

Código para reproducir la Figura 4 del artículo de Deffner et al. (2024).

---

## Archivos

| Archivo | Líneas | Descripción |
|---------|--------|-------------|
| `longitudinal_transmission_analysis.R` | 722 | Pipeline completo: simulación ABM, inferencia Bayesiana, contrafácticos |
| `Longitudinal_Conf.stan` | 128 | Modelo Bayesiano EWA para inferencia de parámetros |
| `test_compile.R` | 10 | Verificar compilación del modelo Stan |
| `figure_4b.R` | 50 | Generar Figura 4B (distribuciones posteriores) |

---

## Pipeline del análisis

```
[Datos] → [ABM] → [Preparación] → [Inferencia Stan] → [Contrafácticos] → [Visualización]
```

### 1. **Simulación ABM** (longitudinal_transmission_analysis.R)
- 3,000 agentes, 30 grupos
- Migración, demografía y transmisión cultural
- 1,000 pasos burn-in + 30 pasos registro

### 2. **Inferencia Bayesiana** (Longitudinal_Conf.stan)
- Modelo EWA para aprendizaje cultural
- Parámetros: tasa innovación (μ), exponente conformidad (θ)
- 4 cadenas MCMC, 3,000 iteraciones

### 3. **Contrafácticos**
- Simulaciones con tasas migración: -5%, original, +5%
- Mide efecto en diversidad cultural (Fst)

### 4. **Figura 4**
- Panel a: Series temporales
- Panel b: Posteriores μ y θ
- Panel c: Migración por edad
- Panel d: Análisis causal contrafáctico

---

## Ejecución rápida

```r
# Verificar Stan
source("test_compile.R")

# Generar Figura 4B
source("figure_4b.R")

# Pipeline completo (2-3 horas)
source("longitudinal_transmission_analysis.R")
```

---

## Dependencias

```r
install.packages(c("rstan", "scales", "RColorBrewer"))
```

Para R 4.4.1, se requiere Rtools 4.3+ instalado en el sistema.


### `Longitudinal_Conf.stan`

Modelo jerarquico multinivel de Atraccion Ponderada por Experiencia (EWA), escrito por D. Deffner (2024).

**Estructura del modelo:**

| Bloque Stan | Contenido |
|-------------|-----------|
| `functions` | `GPL()` -- Kernel de Proceso Gaussiano para suavizado de efectos por edad |
| `data` | Variables observadas: elecciones, innovaciones, migraciones, frecuencias de rasgos, edades, IDs |
| `parameters` | `logit_mu` (innovacion), `log_theta` (conformidad), `logit_m` (migracion), efectos aleatorios por individuo y grupo |
| `transformed parameters` | Reconstruccion de efectos aleatorios y efectos de edad a partir de z-scores y Cholesky |
| `model` | Log-posterior: priors + likelihood (Bernoulli para innovacion/migracion, Categorical para elecciones) |

**Parametros estimados:**

| Parametro | Escala | Descripcion |
|-----------|--------|-------------|
| `logit_mu` | logit | Tasa de innovacion global |
| `log_theta` | log | Exponente de conformidad global |
| `logit_m` | logit | Tasa de migracion promedio |
| `age_effects[1..Max_age]` | logit | Tasas de migracion especificas por edad (via Proceso Gaussiano) |
| `v_ID[N_id, 3]` | -- | Efectos aleatorios por individuo (mu, migracion, theta) |
| `v_group[N_groups, 3]` | -- | Efectos aleatorios por grupo (mu, migracion, theta) |

**Priors:**

- `logit_mu ~ Normal(0, 2)`
- `log_theta ~ Normal(0, 1)`
- `logit_m ~ Normal(0, 2)`
- GP: `eta ~ Exp(3)`, `sigma ~ Exp(1)`, `rho ~ Beta(30, 1)`
- Efectos aleatorios: `z ~ Normal(0, 1)`, `sigma ~ Exp(1)`, `Rho ~ LKJ(4)`

---

### `test_compile.R`

Script corto que verifica que el entorno R/Stan esta correctamente configurado compilando el modelo sin ejecutar muestreo.

```r
# Uso:
source("code/test_compile.R")
# Salida esperada: "Modelo compilado correctamente."
```

Usa `rstan::stan_model()` directamente (no requiere `rethinking`).

---

## Notas de ejecucion

- El script principal usa `mclapply(mc.cores = 100)` para las simulaciones contrafacticas. **Ajustar `mc.cores`** al numero de nucleos disponibles en su maquina.
- En **Windows**, `mclapply` no paraleliza; considerar usar `parLapply` o ejecutar en Linux/macOS.
- La compilacion del modelo Stan puede tomar varios minutos la primera vez. Una vez compilado, las ejecuciones posteriores seran mas rapidas.
- Asegurar que el directorio de trabajo sea `code/` al ejecutar el script principal, ya que busca `Longitudinal_Conf.stan` en el directorio actual.
