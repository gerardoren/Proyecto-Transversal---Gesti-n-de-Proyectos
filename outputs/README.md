# Outputs

Esta carpeta almacena los resultados generados durante la reproduccion del articulo.

---

## Contenido esperado

Al completar la ejecucion del script principal (`code/longitudinal_transmission_analysis.R`), esta carpeta debera contener:

### Figuras

| Archivo | Descripcion |
|---------|-------------|
| `TimeSeries.pdf` | Figura 4 completa del manuscrito (4 paneles: serie temporal, posteriores, migracion por edad, contrafacticos) |

### Resultados intermedios (futuros)

| Archivo | Descripcion |
|---------|-------------|
| `*.rds` | Objetos R serializados con resultados del ajuste Stan (muestras del posterior, diagnosticos) |
| `*.csv` | Tablas de resumen de parametros estimados |

---

## Notas

- Los archivos `.csv`, `.rds` y `.png` en esta carpeta **estan excluidos del control de versiones** (ver `.gitignore`) debido a su tamano.
- Para regenerar los resultados, ejecutar el script principal completo desde `code/`.
- La generacion de la Figura 4 actualmente esta comentada en el script (`pdf()` y `dev.off()` estan comentados). Para guardar la figura en archivo, descomentar las lineas correspondientes en el script.

---

## Estado actual

Esta carpeta esta vacia. Los resultados se generaran una vez que se complete la ejecucion completa del pipeline.
