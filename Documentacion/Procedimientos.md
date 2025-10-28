# Procedimiento: [mayorCantidadSeguidores]

Este procedimiento encapsula una consulta de análisis para segmentar y recuperar una lista de influencers cuyo número de seguidores excede un umbral específico. Su propósito es simplificar el acceso a esta información, permitiendo a los usuarios ejecutar un análisis recurrente sin necesidad de reescribir el código SQL, promoviendo la consistencia y reduciendo la posibilidad de errores.

## Parámetros
*   **@cantidadSeguidores** `INT` `IN`: Define el número mínimo de seguidores que un influencer debe tener para ser incluido en el resultado. Es un parámetro de entrada obligatorio.

## Tablas involucradas
*   **Consulta:**
    *   `TablaMetricas`
    *   `TablaInfluencer`
*   **Modifica:**
    *   Ninguna. El procedimiento es de solo lectura (`read-only`).

## Validaciones
No se implementan validaciones explícitas dentro del procedimiento. La validación del tipo de dato del parámetro `@cantidadSeguidores` es gestionada directamente por SQL Server.

## Rendimiento
*   **Cardinalidad:** Variable. El número de filas devueltas depende directamente del valor del parámetro `@cantidadSeguidores` y de la distribución de seguidores en la base de datos.
*   **Índices Usados:** El rendimiento de la consulta se beneficia significativamente de la existencia de índices en las columnas de la cláusula `JOIN` (`TablaMetricas.ID_Influencer`, `TablaInfluencer.ID_Influencer`) y en la columna de filtrado `WHERE` (`TablaMetricas.seguidores`).
*   **Transacciones:** El procedimiento no opera dentro de una transacción explícita, ya que solo realiza operaciones de lectura.
*   **Costo:** Bajo a medio. El costo es generalmente bajo, pero puede aumentar si el valor del parámetro es muy bajo, lo que resultaría en un escaneo de un gran número de filas.

## Dependencias
El procedimiento depende de la existencia y estructura de las tablas `dbo.TablaMetricas` y `dbo.TablaInfluencer`. No tiene dependencias de otros procedimientos, funciones o vistas.

## Seguridad
*   **Permisos Requeridos:** Se necesita permiso de `EXECUTE` sobre el procedimiento y permisos de `SELECT` sobre las tablas `dbo.TablaMetricas` y `dbo.TablaInfluencer`.
*   **Datos Sensibles:** Devuelve el nombre de usuario del influencer, que puede ser considerado información pública. No expone datos sensibles adicionales.

## Casos de uso
*   **Segmentación Rápida:** Un analista necesita obtener rápidamente una lista de todos los "macro-influencers" (ej. > 1,000,000 de seguidores) para un reporte.
    ```sql
    EXEC mayorCantidadSeguidores @cantidadSeguidores = 1000000;
    ```
*   **Análisis Comparativo:** Identificar a los influencers en un nicho más pequeño (ej. > 50,000 seguidores) para una campaña de marketing específica.
    ```sql
    EXEC mayorCantidadSeguidores @cantidadSeguidores = 50000;
    ```