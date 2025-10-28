# Vista: `vw_ResumenInfluencer`

Esta vista proporciona una capa de abstracción sobre las tablas de métricas y contenido. Su propósito es ofrecer un resumen pre-agregado del rendimiento promedio de cada influencer, agrupado por sus categorías y el país de su audiencia. Simplifica la creación de reportes y análisis al encapsular la lógica de unión y cálculo de promedios.

## Tablas origen
*   `TablaMetricas`
*   `TablaContenido`

## Transformaciones
*   **Join:** Realiza un `INNER JOIN` entre `TablaMetricas` y `TablaContenido` utilizando la columna `ID_Influencer`.
*   **Agrupación:** Agrupa los resultados por `ID_Influencer`, `categoria1`, `categoria2` y `pais_Audiencia`.
*   **Cálculos:** Calcula el promedio (`AVG`) de las columnas `seguidores`, `likes_Promedio`, `comentarios_Promedio` y `audiencia_Autentica` para cada grupo.

## Uso recomendado
Está optimizada para consultas de alto nivel que buscan obtener un resumen del rendimiento de los influencers sin necesidad de acceder a los datos detallados de cada periodo. Es ideal para:
*   Crear dashboards en herramientas de visualización (Power BI, Tableau).
*   Generar reportes que comparen el rendimiento promedio entre diferentes categorías o países.
*   Análisis exploratorio rápido del perfil general de los influencers.

## Rendimiento
*   **Complejidad:** La consulta subyacente se ejecuta cada vez que se consulta la vista. Su rendimiento depende del tamaño de las tablas base.
*   **Índices Recomendados:** El rendimiento se beneficia enormemente de tener índices en las columnas `ID_Influencer` de ambas tablas (`TablaMetricas` y `TablaContenido`) para acelerar la operación de `JOIN`.
*   **Limitaciones:** No es una vista indexada, por lo que para datasets extremadamente grandes, las consultas repetidas pueden ser costosas.

## Seguridad
*   **Datos Expuestos:** Expone métricas agregadas (promedios), categorías e identificadores de influencers. No expone datos crudos de periodos individuales.
*   **Permisos Requeridos:** El usuario final solo necesita permisos de `SELECT` sobre la vista `vw_ResumenInfluencer`. No requiere acceso directo a las tablas base.