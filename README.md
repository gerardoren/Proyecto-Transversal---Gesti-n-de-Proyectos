# Proyecto Transversal - Gestion de Proyectos

**Universidad de los Andes | Octavo Semestre - Analitica Computacional**

Reproduccion parcial de resultados cuantitativos del articulo:

> Deffner, D., Fedorova, N., Andrews, J., & McElreath, R. (2024). *Bridging theory and data: A computational workflow for cultural evolution*. Proceedings of the National Academy of Sciences, 121(48).
>
> - Paper: <https://doi.org/10.1073/pnas.2322887121>
> - Repositorio original: <https://github.com/DominikDeffworner/CulturalEvolutionWorkflow>
> - Datos en Zenodo: <https://zenodo.org/records/18879419>

---

## Descripcion

Este proyecto reproduce la relacion entre **migracion**, **conformidad** y **diversidad cultural** a partir de los modelos generativos presentados por Deffner et al. (2024). Se implementa un flujo computacional completo que incluye simulacion basada en agentes, inferencia bayesiana y analisis contrafactico causal.

El enfoque se centra en replicar la **Figura 4** del manuscrito original, que demuestra como cambios en tasas de migracion afectan la diversidad cultural (medida por el indice de fijacion Fst) entre grupos poblacionales.

### Resultado objetivo

La Figura 4 contiene cuatro paneles:

| Panel | Contenido |
|-------|-----------|
| **a** | Serie temporal de datos longitudinales (participantes en grupos coloreados) |
| **b** | Distribuciones posteriores de la tasa de innovacion (mu) y el exponente de conformidad (theta) |
| **c** | Tasas de migracion por edad estimadas vs. datos reales de Paises Bajos |
| **d** | Efecto causal contrafactico: cambio en Fst ante variaciones de +/-5% en migracion |

---

## Integrantes y roles

| Integrante | Rol |
|---|---|
| **Andres Gerardo Rendon** | Coordinacion general del proyecto y gestion del repositorio |
| **Juan Eduardo Gutierrez** | Revision teorica y definicion del resultado a reproducir |
| **Esteban Gonzalez Trujillo** | Analisis de datos y revision del codigo original |
| **Santiago Arias** | Documentacion y control de versiones |

---

## Estructura del repositorio

```
Proyecto-Transversal---Gesti-n-de-Proyectos/
|
|-- README.md                                    # Este archivo
|-- .gitignore                                   # Archivos excluidos del control de versiones
|
|-- code/
|   |-- README.md                                # Documentacion detallada de los scripts
|   |-- longitudinal_transmission_analysis.R     # Script principal de analisis (722 lineas)
|   |-- Longitudinal_Conf.stan                   # Modelo bayesiano jerarquico en Stan (128 lineas)
|   |-- test_compile.R                           # Script de prueba de compilacion del modelo Stan
|
|-- data/
|   |-- README.md                                # Documentacion de los datos
|   |-- beta_df.RDS                              # Tasas de migracion por edad (Paises Bajos, 1850-1950)
|
|-- docs/
|   |-- README.md                                # Indice de documentacion adicional
|   |-- notas.md                                 # Notas teoricas sobre el modelo longitudinal
|
|-- outputs/
|   |-- README.md                                # Descripcion de resultados esperados
```

---

## Metodologia

El flujo de trabajo se compone de cuatro etapas secuenciales:

```
[1. Simulacion ABM] --> [2. Preparacion datos] --> [3. Inferencia Stan] --> [4. Contrafacticos + Figura 4]
```

### Etapa 1: Simulacion basada en agentes (ABM)

- **3,000 agentes** organizados en **30 grupos** en una cuadricula espacial de 50x50.
- Dinamicas demograficas: nacimiento-muerte con mortalidad dependiente de la edad.
- Migracion entre grupos con tasas especificas por edad, calibradas con datos reales de Paises Bajos (1850-1950).
- **1,000 pasos de burn-in** para alcanzar equilibrio demografico, seguidos de 100 pasos de skip y 30 pasos de registro.

### Etapa 2: Transmision cultural

- Aprendizaje social con sesgo de conformidad (ley de potencia, exponente `f = 3`).
- Tasa de innovacion del 10% (`mu = 0.1`): probabilidad de que un individuo genere una variante nueva en lugar de copiar.
- 30 modelos de rol por aprendiz, seleccionados del mismo grupo.
- Se registran las elecciones, los modelos observados y los estados demograficos de 500 individuos focales.

### Etapa 3: Inferencia bayesiana con Stan

- Modelo jerarquico **EWA (Experience-Weighted Attraction)** multinivel.
- Parametros estimados: tasa de innovacion (`mu`), exponente de conformidad (`theta`), tasas de migracion por edad.
- Proceso Gaussiano sobre las tasas de migracion por edad para suavizado.
- **4 cadenas MCMC**, 3,000 iteraciones cada una, con `adapt_delta = 0.8` y `max_treedepth = 13`.
- Efectos aleatorios a nivel de individuo y grupo.

### Etapa 4: Analisis contrafactico causal

- Se toman 300 muestras del posterior (100 por condicion).
- Se simulan tres escenarios: tasas de migracion originales, +5%, y -5%.
- Se compara la diversidad cultural (Fst) entre escenarios.
- Se genera la Figura 4 combinando los cuatro paneles.

---

## Tecnologias y dependencias

### Lenguajes

| Lenguaje | Version recomendada | Uso |
|----------|---------------------|-----|
| **R** | >= 4.2.0 | Simulacion, analisis estadistico, visualizacion |
| **Stan** | >= 2.26 | Programacion probabilistica para inferencia bayesiana |

### Paquetes de R requeridos

| Paquete | Uso | Instalacion |
|---------|-----|-------------|
| `scales` | Transparencia de colores en graficos | `install.packages("scales")` |
| `RColorBrewer` | Paletas de colores para visualizacion | `install.packages("RColorBrewer")` |
| `rethinking` | Interfaz simplificada para Stan y utilidades bayesianas | Ver instrucciones abajo |
| `rstan` | Motor de inferencia bayesiana (backend de Stan) | `install.packages("rstan")` |
| `cmdstanr` | Alternativa a rstan (mas rapido) | Ver instrucciones abajo |

### Instalacion de dependencias

```r
# Paquetes estandar desde CRAN
install.packages(c("scales", "RColorBrewer", "rstan"))

# Paquete rethinking (requiere instalacion desde GitHub)
# Primero instalar remotes si no lo tienes:
install.packages("remotes")
remotes::install_github("rmcelreath/rethinking")

# Opcional: cmdstanr (alternativa mas rapida a rstan)
install.packages("cmdstanr", repos = c("https://mc-stan.org/r-packages/", getOption("repos")))
cmdstanr::install_cmdstan()
```

> **Nota sobre `rethinking`:** Este paquete no esta en CRAN. Requiere tener `rstan` instalado previamente. Consultar: <https://github.com/rmcelreath/rethinking>

---

## Datos

### `data/beta_df.RDS`

Archivo serializado de R que contiene datos empiricos de calibracion del modelo.

| Campo | Descripcion |
|---|---|
| **Formato** | Objeto R serializado (`.RDS`) |
| **Contenido** | `beta_mod_f` -- vector de 93 tasas de migracion especificas por edad |
| **Fuente** | Fedorova et al. (2022) -- analisis de 300,000 mudanzas residenciales en los Paises Bajos (1850-1950) |
| **Uso** | Calibra las tasas de migracion dependientes de la edad en el ABM |
| **Acceso remoto** | Tambien disponible via Zenodo: `https://zenodo.org/records/18879419/files/beta_df.RDS?download=1` |

El script principal carga los datos directamente desde Zenodo para garantizar reproducibilidad sin depender de archivos locales.

---

## Ejecucion

### Prerequisitos

1. Tener R (>= 4.2.0) instalado.
2. Tener una instalacion funcional de Stan (via `rstan` o `cmdstanr`).
3. Instalar todos los paquetes listados arriba.

### Verificar compilacion del modelo Stan

```r
# Desde la raiz del repositorio
source("code/test_compile.R")
```

Si la compilacion es exitosa, se imprimira: `Modelo compilado correctamente.`

### Ejecutar el analisis completo

```r
# Desde la carpeta code/
source("longitudinal_transmission_analysis.R")
```

### Tiempos estimados de ejecucion

| Etapa | Tiempo aproximado |
|-------|-------------------|
| Simulaciones iniciales (ABM + burn-in) | ~30 minutos |
| Ajuste bayesiano con Stan (4 cadenas, 3000 iter) | 1-2 horas |
| Simulaciones contrafacticas (300 muestras x 100 sim) | ~30 minutos |
| **Total** | **~2-3 horas** |

### Requisitos de hardware

- **RAM:** Minimo 8 GB recomendados.
- **CPU:** Multiples nucleos recomendados. El script contrafactico usa `mclapply` con hasta 100 nucleos (`mc.cores = 100`); ajustar este valor segun el hardware disponible.
- **Nota para Windows:** `mclapply` no soporta paralelismo en Windows. Si se ejecuta en Windows, considerar usar `parLapply` de la libreria `parallel` o ejecutar en una maquina Linux/macOS.

---

## Resultados esperados

Al completar la ejecucion, el script genera la **Figura 4** del manuscrito, compuesta por:

- **Panel a:** Serie temporal de datos longitudinales mostrando participantes coloreados por grupo.
- **Panel b:** Distribuciones posteriores marginales de mu (innovacion) y theta (conformidad) con intervalos de credibilidad al 90% (HPDI).
- **Panel c:** Tasas de migracion por edad estimadas por el modelo vs. datos reales (linea punteada).
- **Panel d:** Efecto causal contrafactico de cambios en migracion (+5% y -5%) sobre la diversidad cultural (Fst).

Los archivos de salida se almacenan en la carpeta `outputs/`.

---

## Referencias

1. Deffner, D., Fedorova, N., Andrews, J., & McElreath, R. (2024). Bridging theory and data: A computational workflow for cultural evolution. *Proceedings of the National Academy of Sciences*, 121(48). <https://doi.org/10.1073/pnas.2322887121>
2. Fedorova, N. et al. (2022). The complex life course of mobility: Quantitative description of 300,000 residential moves in 1850-1950 Netherlands.
3. Mesoudi, A. (2018). Migration, acculturation, and the maintenance of between-group cultural variation. *PLOS ONE*, 13(10).
4. McElreath, R. (2020). *Statistical Rethinking: A Bayesian Course with Examples in R and Stan*. CRC Press.

---

## Licencia y atribucion

Todos los datos y codigo base se derivan de los materiales publicos del repositorio oficial de Deffner et al. (2024). Se respetan las licencias y atribuciones de los autores originales. El codigo del modelo Stan y el script principal de analisis fueron escritos por D. Deffner (deffner@mpib-berlin.mpg.de).

---

## Estado actual de la reproduccion

- [x] Identificacion y clonacion del codigo relevante del articulo original.
- [x] Inclusion del modelo bayesiano en Stan (`Longitudinal_Conf.stan`).
- [x] Inclusion del script principal de analisis (`longitudinal_transmission_analysis.R`).
- [x] Pruebas preliminares de compilacion del modelo Stan.
- [x] Carga de datos desde Zenodo para reproducibilidad.
- [ ] Ejecucion completa del muestreo MCMC.
- [ ] Generacion de la Figura 4B (distribuciones posteriores).
- [ ] Generacion de la Figura 4 completa (4 paneles).
- [ ] Analisis contrafactico y comparacion con resultados originales.
