# Code

Esta carpeta contiene todo el codigo necesario para reproducir la Figura 4 del articulo de Deffner et al. (2024).

---

## Archivos incluidos

| Archivo | Lineas | Descripcion |
|---------|--------|-------------|
| `longitudinal_transmission_analysis.R` | 722 | Script principal: simulacion ABM, inferencia bayesiana, contrafacticos y visualizacion |
| `Longitudinal_Conf.stan` | 128 | Modelo bayesiano jerarquico EWA para inferir parametros de transmision cultural |
| `test_compile.R` | 10 | Script de verificacion: compila el modelo Stan para confirmar que el entorno esta configurado |

---

## Pipeline de analisis

El script principal (`longitudinal_transmission_analysis.R`) ejecuta el siguiente flujo:

```
[Carga de datos]
      |
      v
[1. Simulacion ABM]  (lineas 1-291)
      |  - 3,000 agentes, 30 grupos, cuadricula 50x50
      |  - 1,000 pasos de burn-in demografico
      |  - 100 pasos de skip + 30 pasos de registro
      |  - Demografia, migracion y transmision cultural
      |
      v
[2. Preparacion de datos para Stan]  (lineas 293-366)
      |  - Reestructura datos de elecciones, innovaciones y migraciones
      |  - Genera lista stan.data con todas las variables requeridas
      |
      v
[3. Inferencia bayesiana]  (lineas 368-372)
      |  - Ajuste del modelo Longitudinal_Conf.stan
      |  - 4 cadenas MCMC, 3,000 iteraciones, adapt_delta=0.8
      |
      v
[4. Simulaciones contrafacticas]  (lineas 374-598)
      |  - 300 muestras del posterior (100 base, 100 +5%, 100 -5%)
      |  - Simulacion ABM con parametros estimados
      |
      v
[5. Visualizacion - Figura 4]  (lineas 600-722)
         - Panel a: Serie temporal de participantes
         - Panel b: Posteriores de mu y theta
         - Panel c: Tasas de migracion por edad
         - Panel d: Efecto causal contrafactico
```

---

## Detalle de cada archivo

### `longitudinal_transmission_analysis.R`

Script principal escrito por D. Deffner (deffner@mpib-berlin.mpg.de). Implementa el flujo completo de analisis.

**Funciones definidas:**

| Funcion | Linea | Descripcion |
|---------|-------|-------------|
| `f_age(increasing, rate, x)` | 22 | Funcion exponencial para probabilidades dependientes de la edad (supervivencia, aprendizaje) |
| `getFst(trait_vec)` | 31 | Calcula el indice de fijacion (Fst) a partir de vectores de rasgos culturales (basado en Mesoudi, 2018) |
| `sim.funct(N_steps, Nsim, sample, m_in)` | 397 | Funcion de simulacion contrafactica que ejecuta el ABM con parametros del posterior |

**Parametros del modelo (configuracion por defecto):**

| Parametro | Valor | Descripcion |
|-----------|-------|-------------|
| `N` | 3,000 | Numero de agentes |
| `N_groups` | 30 | Numero de grupos |
| `N_steps` | 30 | Pasos temporales de registro |
| `N_burn_in` | 1,000 | Pasos de burn-in demografico |
| `N_skip` | 100 | Pasos antes de registrar datos |
| `N_mod` | 30 | Modelos de rol por aprendiz |
| `mu` | 0.1 | Tasa de innovacion |
| `f` | 3 | Exponente de conformidad |
| `size_grid` | 50 | Tamano de la cuadricula espacial |
| `r_mort` | 0.001 | Tasa de decaimiento de mortalidad |
| `r_learn` | 0 | Tasa de decaimiento de aprendizaje (0 = todos aprenden) |
| `m_NL` | TRUE | Usar tasas reales de migracion de Paises Bajos |

**Dependencias de R:**

- `scales` -- Transparencia de colores
- `RColorBrewer` -- Paletas de colores
- `rethinking` -- Interfaz para Stan y utilidades bayesianas (funciones `stan()`, `extract.samples()`, `inv_logit()`, `HPDI()`)
- `rstan` -- Backend de inferencia bayesiana

**Datos de entrada:**

- Datos de migracion desde Zenodo: `https://zenodo.org/records/18879419/files/beta_df.RDS?download=1`
- Modelo Stan: `Longitudinal_Conf.stan` (debe estar en el mismo directorio)

---

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
