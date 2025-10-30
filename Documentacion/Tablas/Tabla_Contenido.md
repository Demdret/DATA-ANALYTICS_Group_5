# Tabla: `TablaContenido`

Esta tabla de dimensión almacena las categorías de contenido asociadas a cada influencer. Su propósito es describir y clasificar a los perfiles según su área de especialización (ej. "Música", "Cine y televisión", "Moda"). Dentro del esquema de estrella, esta tabla enriquece la tabla de hechos `TablaMetricas`, permitiendo segmentar y analizar la interacción de los influencers con la audiencia y el impacto que estos generan

## Estructura
| Columna | Tipo | Reglas | Descripción |
|---|---|---|---|
| `ID_Contenido` | `SMALLINT` | `PK`, `NOT NULL`, `IDENTITY(1,1)` | Identificador único autoincremental para cada registro de contenido. |
| `ID_Influencer` | `SMALLINT` | `FK`, `NOT NULL` | Clave foránea que vincula el contenido con un influencer específico en `TablaInfluencer`. |
| `categoria1` | `NVARCHAR(100)` | `NULL` | Categoría principal del contenido del influencer. |
| `categoria2` | `NVARCHAR(100)` | `NULL` | Categoría secundaria del contenido, si aplica. |

## Claves
- **PK:** `ID_Contenido`
- **FK:** `ID_Influencer` → `TablaInfluencer(ID_Influencer)`

## Indices definidos
| Nombre del índice       | Columna       | Tipo       | Notas                                                         |
| ----------------------- | ------------- | ---------- | ------------------------------------------------------------- |
| IX_Contenido_Categoria1 | categoria1    | No clúster | Optimiza consultas y agrupamientos por categoría principal.   |
| IX_Contenido_Categoria2 | categoria2    | No clúster | Facilita análisis por categoría secundaria.                   |
| IX_Contenido_Influencer | ID_Influencer | No clúster | Mejora rendimiento en uniones (JOIN) con la tabla Influencer. |


## Índices
Se recomienda un índice no agrupado (`Non-Clustered`) en la columna `ID_Influencer` para optimizar las operaciones de `JOIN` con la tabla `TablaMetricas`.

## Objetos relacionados
- **Triggers:** Ninguno.
- **Procedimientos:** Ninguno.
- **Vistas:** `vw_ResumenInfluencer` (utiliza esta tabla para agrupar métricas por categoría).

## Seguridad y Clasificación
- **Nivel:** Confidencial.
- **Datos sensibles:** Ninguno. La información de categoría es considerada pública.
- **Roles con acceso:** Roles de analista de datos con permisos de `SELECT`. Roles de administrador de ETL con permisos de `INSERT` y `UPDATE`.
- **Dominio:** Análisis de Influencers.
- **Tipo:** Dimensión.
- **Uso:** Analítico.