# Bitácora de Revisiones Técnicas - Asistente de IA

Este documento registra las revisiones técnicas, sugerencias y mejoras propuestas por el asistente de IA (Copilot Chat) durante el desarrollo del proyecto de análisis de datos.

---

## Revisión 1: Script de Limpieza de Datos (`Query_Clean_Database.sql`)

**Fecha:** 23/10/2025

### Análisis General

El script original intentaba rellenar valores nulos mediante CTEs y uniones, pero presentaba problemas críticos que impedirían su correcta ejecución y podrían corromper datos existentes.

### Puntos de Mejora y Alternativas Sugeridas

1.  **Violación de Restricciones (`CHECK`):**
    *   **Observación:** La generación de números aleatorios para `audiencia_Autentica` e `interaccion_Promedio` producía valores fuera del rango permitido (0-100), lo que causaría un error en el `UPDATE`.
    *   **Sugerencia Aceptada:** Ajustar la fórmula de `RAND()` para generar valores decimales dentro del rango correcto (ej: `60.00 + (RAND() * (95.00 - 60.00))`).

2.  **Sobrescritura de Datos Existentes:**
    *   **Observación:** Las sentencias `UPDATE` no filtraban por campos nulos, por lo que sobrescribirían todos los valores de la columna, incluyendo los que ya eran correctos.
    *   **Sugerencia Aceptada:** Añadir una cláusula `WHERE mi_columna IS NULL` a cada `UPDATE` para asegurar que solo se modifiquen las filas que lo necesitan.

3.  **Complejidad Innecesaria:**
    *   **Observación:** El uso de CTEs y `ROW_NUMBER()` para esta tarea era excesivamente complejo y propenso a errores.
    *   **Sugerencia Aceptada:** Simplificar el script utilizando sentencias `UPDATE` directas, que son más legibles, eficientes y seguras para esta operación.

### Ejemplo de Código Mejorado (Limpieza Directa)

```sql
-- Rellena valores nulos en 'audiencia_Autentica' con un valor aleatorio entre 60 y 95
UPDATE Tabla_Metricas
SET audiencia_Autentica = 60.00 + (RAND(CHECKSUM(NEWID())) * (95.00 - 60.00))
WHERE audiencia_Autentica IS NULL;
```

---

## Revisión 2: Consultas de Análisis (`SQL_Server_QueryProyecto.sql`)

**Fecha:** 23/10/2025


### Análisis General

El script de análisis demostró un buen manejo de funciones SQL, pero se identificaron oportunidades para refinar la lógica, mejorar la precisión de los cálculos y aumentar la eficiencia y legibilidad del código.

### Puntos de Mejora y Alternativas Sugeridas

1.  **Precisión en Agregaciones:**
    *   **Observación:** El uso de `CEILING()` antes de `AVG()` distorsiona el cálculo del promedio.
    *   **Sugerencia Aceptada:** Calcular `AVG()` sobre los datos crudos y aplicar `ROUND()` al resultado final para obtener una media precisa.

2.  **Robustez en Agrupaciones (`GROUP BY`):**
    *   **Observación:** Las agrupaciones por país (`GROUP BY pais_Audiencia`) son sensibles a mayúsculas y minúsculas (ej: "México" y "méxico" serían tratados como grupos distintos).
    *   **Sugerencia Aceptada:** Utilizar funciones como `UPPER()` en la cláusula `GROUP BY` para estandarizar los valores y asegurar que los datos se agrupen correctamente.

3.  **Lógica de Filtro (`WHERE` vs. `HAVING`):**
    *   **Observación:** Se utilizó una subconsulta en la cláusula `WHERE` para filtrar datos *antes* de la agregación. Esto respondía a la pregunta "¿cuál es el promedio de los posts de alto rendimiento de un influencer?", en lugar de la pregunta más común "¿qué influencers tienen un rendimiento promedio general alto?".
    *   **Sugerencia Aceptada:** Replantear la consulta usando una **Expresión de Tabla Común (CTE)** para calcular el promedio global y luego usar `HAVING` para filtrar a los influencers cuyo promedio de grupo (calculado después del `GROUP BY`) supera el global.

4.  **Eficiencia de Subconsultas Correlacionadas:**
    *   **Observación:** Se utilizó una subconsulta correlacionada para contar influencers con múltiples categorías por país. Aunque funcional, este patrón puede ser ineficiente en datasets grandes.
    *   **Sugerencia Aceptada:** Reemplazar la subconsulta con **agregación condicional** (`COUNT(DISTINCT CASE ... END)`). Este enfoque realiza el cálculo en una única pasada, mejorando el rendimiento y la claridad.

5.  **Idempotencia en Creación de Vistas:**
    *   **Observación:** La creación de la vista `vw_ResumenInfluencer` incluye una verificación (`IF OBJECT_ID...DROP VIEW`).
    *   **Sugerencia Aceptada:** Se validó esta implementación como una excelente práctica, ya que permite que el script se ejecute múltiples veces sin generar errores.

### Ejemplo de Código Mejorado (CTE y Agregación Condicional)

```sql
SELECT
    m.pais_Audiencia,
    COUNT(DISTINCT m.ID_Influencer) AS Total_Influencers,
    -- Conteo condicional en una sola pasada
    COUNT(DISTINCT CASE WHEN c.categoria2 IS NOT NULL THEN c.ID_Influencer END) AS Influencers_Multicategoria
FROM Tabla_Metricas AS m
INNER JOIN Tabla_Contenido AS c ON m.ID_Influencer = c.ID_Influencer
GROUP BY m.pais_Audiencia;
```
