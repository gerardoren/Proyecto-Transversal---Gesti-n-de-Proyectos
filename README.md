# Proyecto-Transversal---Gestion-de-Proyectos
Paper seleccionado: 

Deffner, D., Fedorova, N., Andrews, J., & McElreath, R. (2024). Bridging theory and data: A computational workflow for cultural evolution. Proceedings of the National Academy of Sciences.

Integrantes del equipo y roles:

Andrés Gerardo Rendón: Coordinación general del proyecto y gestión del repositorio

Juan Eduardo Gutierrez: Revisión teórica y definición del resultado a reproducir

Esteban Gonzalez Trujillo: Análisis de datos y revisión del código original

Santiago Arias: Documentación y control de versiones


Descripción general del proyecto:

Este proyecto tiene como objetivo reproducir parcialmente uno de los resultados cuantitativos presentados en Deffner et al. (2024), un artículo que propone un flujo computacional basado en modelos generativos para conectar teoría y evidencia empírica en estudios de evolución cultural.

El objetivo principal del Proyecto Transversal busca replicar un resultado específico respaldado por evidencia cuantitativa, manteniendo las buenas prácticas de ciencia abierta, reproducibilidad y documentación.

En particular, este proyecto se enfoca en reproducir la relación entre migración, conformidad y diversidad cultural a partir de los modelos generativos presentados por los autores, utilizando el código y los insumos disponibles públicamente en el repositorio oficial del artículo.


Explicación de la estructura de directorios:

El repositorio se organiza en una estructura de carpetas diseñada para facilitar la reproducibilidad, la trazabilidad del análisis y el trabajo colaborativo. La carpeta data está destinada a contener los datos y/o insumos derivados de los materiales públicos asociados al artículo original, incluyendo datos simulados o procesados necesarios para reproducir el resultado seleccionado. La carpeta code albergará los scripts utilizados para implementar los modelos generativos, simulaciones y procedimientos de inferencia descritos en el artículo, manteniendo separada la lógica computacional de los datos y resultados.

La carpeta outputs se utilizará para almacenar los productos del análisis, tales como figuras, tablas y resultados intermedios generados durante la reproducción. Por su parte, la carpeta docs contiene documentación complementaria del proyecto, incluyendo el plan de análisis, decisiones metodológicas y notas sobre posibles desviaciones respecto al artículo original. Cada directorio incluye un archivo README.md interno que documenta su propósito y contenido esperado, y el archivo .gitignore permite controlar los archivos que no deben versionarse, manteniendo un repositorio limpio y enfocado en la reproducibilidad.


Requisitos iniciales identificados:

Para la reproducción del resultado seleccionado del artículo de Deffner et al. (2024), se identifican como requisitos iniciales el acceso al repositorio público de los autores, que contiene el código y los scripts anotados utilizados en el flujo computacional propuesto.Por otro lado, el proyecto requerirá el uso de lenguajes de programación orientados a simulación y análisis estadístico (principalmente R y/o Python), así como librerías asociadas a modelos generativos, simulaciones basadas en agentes e inferencia bayesiana.

Adicionalmente, se requiere un entorno de trabajo que permita la ejecución de simulaciones estocásticas y la generación de resultados reproducibles, junto con el uso de GitHub para el control de versiones y la colaboración entre los integrantes del equipo. En esta primera etapa, estos requisitos se identifican de manera preliminar y podrán ajustarse o detallarse con mayor precisión a medida que avance la implementación del proyecto y se profundice en el análisis del código original.

