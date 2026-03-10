# Proyecto Transversal - Gestión de Proyectos

Reproducción parcial de resultados cuantitativos del artículo:

> Deffner, D., Fedorova, N., Andrews, J., & McElreath, R. (2024). *Bridging theory and data: A computational workflow for cultural evolution*. Proceedings of the National Academy of Sciences.

## Descripción

Este proyecto reproduce la relación entre **migración**, **conformidad** y **diversidad cultural** a partir de los modelos generativos presentados por Deffner et al. (2024). Se implementa un flujo computacional completo que incluye simulación basada en agentes, inferencia bayesiana y análisis contrafáctico causal.

El enfoque se centra en replicar la **Figura 4** del manuscrito original, que demuestra cómo cambios en tasas de migración afectan la diversidad cultural entre grupos poblacionales.

## Integrantes y roles

| Integrante | Rol |
|---|---|
| **Andrés Gerardo Rendón** | Coordinación general del proyecto y gestión del repositorio |
| **Juan Eduardo Gutierrez** | Revisión teórica y definición del resultado a reproducir |
| **Esteban González Trujillo** | Análisis de datos y revisión del código original |
| **Santiago Arias** | Documentación y control de versiones |

## Estructura del repositorio

```
├── README.md                  # Este archivo
├── .gitignore                 # Archivos excluidos del control de versiones
├── code/
│   ├── README.md              # Documentación detallada de los scripts
│   ├── longitudinal_transmission_analysis.R   # Script principal de análisis
│   └── Longitudinal_Conf.stan                 # Modelo bayesiano en Stan
├── data/
│   ├── README.md              # Documentación de los datos
│   └── beta_df.RDS            # Tasas de migración por edad (Países Bajos, 1850-1950)
├── docs/
│   └── README.md              # Plan de análisis y decisiones metodológicas
└── outputs/
    └── README.md              # Resultados generados (figuras, tablas, intermedios)
```

## Metodología

El flujo de trabajo se compone de las siguientes etapas:

1. **Simulación basada en agentes (ABM):** 3,000 agentes organizados en 30 grupos en una cuadrícula espacial de 50x50, con dinámicas de nacimiento-muerte, migración dependiente de la edad e innovación cultural.
2. **Transmisión cultural:** Aprendizaje social con sesgo de conformidad (ley de potencia) y tasa de innovación del 10%, utilizando 30 modelos de rol por aprendiz.
3. **Inferencia bayesiana:** Ajuste de un modelo jerárquico de Atracción Ponderada por Experiencia (EWA) mediante Stan, con 4 cadenas MCMC de 3,000 iteraciones cada una.
4. **Análisis contrafáctico:** Evaluación del efecto causal de cambios en migración (+5% y -5%) sobre la diversidad cultural (Fst), usando 300 muestras posteriores con 100 simulaciones cada una.

## Tecnologías y dependencias

- **R** - Lenguaje principal para simulación y análisis estadístico
- **Stan** - Lenguaje de programación probabilística para inferencia bayesiana
- **Paquetes de R requeridos:**
  - `scales` - Funciones de transparencia de colores
  - `RColorBrewer` - Paletas de colores para visualización
  - `rethinking` - Interfaz simplificada para modelado bayesiano con Stan
  - `cmdstanr` / `rstan` - Motor de inferencia bayesiana

## Datos

### `data/beta_df.RDS`

Archivo serializado de R que contiene los datos empíricos de calibración del modelo de simulación.

| Campo | Descripción |
|---|---|
| **Formato** | Objeto R serializado (`.RDS`) |
| **Contenido** | `beta_mod_f` — vector de 93 tasas de migración específicas por edad |
| **Fuente** | Fedorova et al. (2022) — análisis de 300,000 mudanzas residenciales en los Países Bajos (1850–1950) |
| **Uso** | Calibra las tasas de migración dependientes de la edad en el modelo basado en agentes |

Este archivo es un insumo original del repositorio de Deffner et al. (2024) y es necesario para ejecutar el script principal `longitudinal_transmission_analysis.R`.

## Ejecución

```r
# Desde la carpeta code/
source("longitudinal_transmission_analysis.R")
```

**Tiempos estimados de ejecución:**
- Simulaciones iniciales: ~30 minutos
- Ajuste con Stan: 1-2 horas (4 cadenas, 3,000 iteraciones)
- Simulaciones contrafácticas: ~30 minutos

> **Nota:** Se recomienda un entorno con al menos 8 GB de RAM y múltiples núcleos para las simulaciones paralelas.

## Referencias

- Deffner, D., Fedorova, N., Andrews, J., & McElreath, R. (2024). Bridging theory and data: A computational workflow for cultural evolution. *Proceedings of the National Academy of Sciences*.
- Fedorova, N. et al. (2022). The complex life course of mobility: Quantitative description of 300,000 residential moves in 1850-1950 Netherlands.

## Licencia y atribución

Todos los datos y código base se derivan de los materiales públicos del repositorio oficial de Deffner et al. (2024). Se respetan las licencias y atribuciones de los autores originales.


## Estado actual de la reproducción

Se ha identificado y clonado el código relevante del artículo original, 
incluyendo el modelo bayesiano en Stan (Longitudinal_Conf.stan) y el script 
principal de análisis. Se realizaron pruebas preliminares de compilación del 
modelo. Se trabaja actualmente en la ejecución completa del muestreo MCMC 
y la generación de la Figura 4B.