# Reproducción - Evolución Cultural

**Universidad de los Andes | Octavo Semestre**

Reproducción de la Figura 4 del artículo de Deffner et al. (2024): *Bridging theory and data: A computational workflow for cultural evolution*.

- **Artículo:** https://doi.org/10.1073/pnas.2322887121
- **Datos:** https://zenodo.org/records/18879419

---

## Contenido

```
code/                          # Scripts de análisis
- longitudinal_transmission_analysis.R  # Pipeline principal
- Longitudinal_Conf.stan              # Modelo Bayesiano
- test_compile.R                      # Verificar compilación
- figure_4b.R                         # Generar Figura 4B

data/
- beta_df.RDS                  # Tasas de migración por edad (Países Bajos)

outputs/
- figure_4b.png                # Figura generada
```

---

## Requisitos

- R >= 4.2.0
- Rtools 4.3+
- Paquetes: `rstan`, `scales`, `RColorBrewer`

```r
install.packages(c("scales", "RColorBrewer", "rstan"))
```

---

## Uso rápido

```r
# Verificar que Stan compila
source("code/test_compile.R")

# Generar Figura 4B (distribuciones posteriores)
source("code/figure_4b.R")

# Pipeline completo (demanda ~2-3 horas)
source("code/longitudinal_transmission_analysis.R")
```

---

## Figura 4 - Paneles

| Panel | Contenido |
|-------|-----------|
| **a** | Serie temporal de participantes por grupo |
| **b** | Distribuciones posteriores: tasa de innovación (μ) y exponente de conformidad (θ) |
| **c** | Tasas de migración por edad estimadas vs. datos reales |
| **d** | Efecto causal: cambio en diversidad cultural con ±5% migración |

---

## Referencias

- Deffner et al. (2024). Bridging theory and data: A computational workflow for cultural evolution. PNAS 121(48).
- Datos de migración: Fedorova et al. (2022). 300,000 residential moves in 1850-1950 Netherlands.
