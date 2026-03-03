# Code

Esta carpeta contiene el código necesario para reproducir el resultado seleccionado del artículo.

## Archivos incluidos

### longitudinal_transmission_analysis.R
Script principal que implementa el flujo completo de análisis de transmisión longitudinal de rasgos culturales.

**Funcionalidades:**
- **Simulación de evolución cultural:** Simula 3,000 agentes organizados en 30 grupos en una cuadrícula espacial
- **Dinámicas demográficas:** Implementa procesos de nacimiento-muerte dependientes de la edad
- **Migración:** Simula tasas de migración específicas por edad basadas en datos reales de los Países Bajos
- **Transmisión cultural:** Implementa mecanismos de aprendizaje social con conformidad e innovación
- **Análisis Bayesiano:** Ajusta modelos jerárquicos de atracción ponderada por experiencia usando Stan
- **Simulaciones contrafácticas:** Evalúa efectos causales de cambios en tasas de migración sobre diversidad cultural
- **Visualización:** Genera figura comparativa de resultados (Figure 4 del manuscrito)

**Dependencias de R:**
- `scales`: Para transparencia de colores
- `RColorBrewer`: Paletas de colores
- `rethinking`: Interfaz simplificada para Stan y funciones de utilidad Bayesiana
- `cmdstanr` o `rstan`: Motor de inferencia Bayesiana

**Archivos requeridos:**
- `../data/beta_df.RDS`: Trayectorias de edad para migración (datos reales de Países Bajos)
- `Longitudinal_Conf.stan`: Modelo Stan para análisis de transmisión cultural

**Tiempo de ejecución estimado:**
- Simulaciones iniciales: 30+ minutos
- Ajuste con Stan: 1-2 horas (4 cadenas, 3000 iteraciones)
- Simulaciones contrafácticas: 30+ minutos

## Estructura general del proyecto

Incluye scripts asociados a:
- Modelos causales (DAGs)
- Simulaciones basadas en agentes (Agent-Based Models)
- Procedimientos de inferencia Bayesiana con Stan
