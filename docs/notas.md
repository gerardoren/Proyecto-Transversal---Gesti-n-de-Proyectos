# Notas teoricas: Modelo longitudinal de transmision cultural

## Contexto general

El articulo de Deffner et al. (2024) propone un flujo computacional para estudiar **evolucion cultural** combinando tres componentes:

1. **Modelos generativos (ABM):** Simulaciones basadas en agentes que generan datos sinteticos bajo supuestos teoricos explicitos.
2. **Modelos estadisticos (Stan):** Inferencia bayesiana para recuperar los parametros generativos a partir de los datos.
3. **Analisis causal contrafactico:** Manipulacion de variables del posterior para evaluar efectos causales.

---

## Modelo de Atraccion Ponderada por Experiencia (EWA)

El modelo EWA es un framework de aprendizaje social donde los individuos eligen variantes culturales basandose en:

- **Frecuencia observada** de cada variante entre sus modelos de rol.
- **Sesgo de conformidad** que amplifica o reduce la preferencia por variantes frecuentes.
- **Innovacion** que introduce variantes completamente nuevas.

La probabilidad de que un individuo elija la variante `j` es:

```
P(j) = n_j^theta / sum(n_k^theta)
```

donde `n_j` es la frecuencia de la variante `j` entre los modelos de rol y `theta` es el exponente de conformidad.

---

## Parametros principales

### theta (exponente de conformidad)

Controla la direccion e intensidad del sesgo dependiente de frecuencia:

| Valor | Interpretacion |
|-------|----------------|
| `theta = 1` | Transmision no sesgada (copia proporcional a la frecuencia) |
| `theta > 1` | **Transmision conformista**: preferencia desproporcionada por variantes mas comunes |
| `0 < theta < 1` | **Anti-conformismo**: preferencia por variantes raras |

En la simulacion se usa `theta = 3` (conformidad fuerte). El modelo bayesiano estima `theta` en escala logaritmica (`log_theta`), transformado como `theta = exp(log_theta)`.

### mu (tasa de innovacion)

Probabilidad de que un individuo introduzca una variante cultural completamente nueva en lugar de copiar socialmente de sus modelos de rol.

- Valor generador: `mu = 0.1` (10% de las interacciones de aprendizaje resultan en innovacion).
- El modelo estima `mu` en escala logit (`logit_mu`), transformado como `mu = inv_logit(logit_mu)`.

### m (tasas de migracion por edad)

Vector de probabilidades de que un agente de cierta edad migre a otro grupo en un paso temporal. Calibrado con datos reales de Paises Bajos (1850-1950).

- El modelo estima las tasas en escala logit usando un **Proceso Gaussiano** que impone suavidad sobre la curva de migracion por edad.
- `age_effects[a] = logit_m + age_offsets[a]`, donde `age_offsets` sigue un GP.

---

## Indice de fijacion (Fst)

El Fst mide la diversidad cultural **entre grupos** relativa a la diversidad total. Basado en Mesoudi (2018):

```
Fst = (V_total - V_within) / V_total
```

donde:
- `V_total = 1 - sum(p_k^2)` -- diversidad total (uno menos la suma de cuadrados de frecuencias promedio).
- `V_within = mean(1 - sum(p_gk^2))` -- diversidad promedio dentro de cada grupo.

| Valor Fst | Interpretacion |
|-----------|----------------|
| `Fst = 0` | No hay diferenciacion entre grupos (misma distribucion de rasgos) |
| `Fst = 1` | Maxima diferenciacion (cada grupo tiene rasgos unicos) |

---

## Resultado a reproducir: Figura 4

La Figura 4 del articulo demuestra el ciclo completo del flujo computacional:

### Panel a -- Serie temporal longitudinal
Muestra la participacion de individuos a lo largo de 30 pasos temporales, con colores indicando el grupo al que pertenecen. Permite visualizar migraciones (cambios de color) y mortalidad (lineas que terminan antes de t=30).

### Panel b -- Distribuciones posteriores de mu y theta
Distribuciones marginales del posterior para:
- Tasa de innovacion `mu`: se espera que el posterior se centre cerca de 0.1 (valor generador).
- Exponente de conformidad `theta`: se espera que se centre cerca de 3 (valor generador).
- La linea punteada marca el valor generador; las areas sombreadas muestran intervalos de credibilidad (HPDI 90% oscuro, 100% claro).

### Panel c -- Tasas de migracion por edad
Compara las estimaciones del modelo (banda de credibilidad) con las tasas reales (linea punteada). Valida que el modelo recupera correctamente la curva de migracion empirica.

### Panel d -- Efecto causal contrafactico (M -> CF_ST)
Muestra como cambia la diversidad cultural (Fst) cuando las tasas de migracion se modifican en +5% o -5%. El modelo predice que:
- **+5% migracion** reduce Fst (mas mezcla entre grupos, menos diferenciacion).
- **-5% migracion** aumenta Fst (menos mezcla, mas diferenciacion cultural).

---

## Fuentes

1. Deffner, D., Fedorova, N., Andrews, J., & McElreath, R. (2024). Bridging theory and data: A computational workflow for cultural evolution. *PNAS*, 121(48).
2. Mesoudi, A. (2018). Migration, acculturation, and the maintenance of between-group cultural variation. *PLOS ONE*, 13(10).
3. McElreath, R. (2020). *Statistical Rethinking*. CRC Press.
