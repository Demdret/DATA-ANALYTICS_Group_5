# Tabla: `TablaMetricas`

Esta es la tabla de hechos central del modelo de estrella. Su propósito es almacenar las métricas de rendimiento cuantitativas de cada influencer en un periodo de tiempo específico. Cada fila representa una "fotografía" del rendimiento de un influencer en un mes determinado, conectando las dimensiones (`Influencer`, `Contenido`, `Periodo`) con los datos medibles.

## Estructura
| Columna | Tipo | Reglas | Descripción |
|---|---|---|---|
| `ID_Metricas` | `INT` | `PK`, `NOT NULL`, `IDENTITY(1,1)` | Clave primaria subrogada que identifica de forma única cada registro de métrica. |
| `ID_Influencer` | `SMALLINT` | `FK`, `NOT NULL` | Clave foránea que vincula el registro con un influencer en `TablaInfluencer`. |
| `ID_Periodo` | `TINYINT` | `FK`, `NOT NULL` | Clave foránea que vincula el registro con un periodo en `TablaPeriodo`. |
| `pais_Audiencia` | `NVARCHAR(100)` | `NULL` | País principal de la audiencia del influencer en ese periodo. |
| `seguidores` | `BIGINT` | `NULL` | Cantidad de seguidores del influencer. |
| `audiencia_Autentica` | `DECIMAL(18,2)` | `NULL` | Porcentaje de la audiencia considerada auténtica. |
| `interaccion_Promedio` | `DECIMAL(18,2)` | `NULL` | Tasa de interacción promedio del influencer. |
| `likes_Promedio` | `BIGINT` | `NULL` | Cantidad promedio de 'Me Gusta' por publicación. |
| `comentarios_Promedio` | `BIGINT` | `NULL` | Cantidad promedio de comentarios por publicación. |

## Claves
- **PK:** `ID_Metricas`
- **FK:**
    *   `ID_Influencer` → `TablaInfluencer(ID_Influencer)`
    *   `ID_Periodo` → `TablaPeriodo(ID_Periodo)`

## Indices definidos
| Nombre del índice         | Columna              | Tipo       | Notas                                                           |
| ------------------------- | -------------------- | ---------- | --------------------------------------------------------------- |
| IX_Metricas_Influencer    | ID_Influencer        | No clúster | Optimiza consultas por influencer y sus métricas.               |
| IX_Metricas_Periodo       | ID_Periodo           | No clúster | Acelera filtros por mes o año del periodo.                      |
| IX_Metricas_PaisAudiencia | pais_Audiencia       | No clúster | Mejora segmentación y reportes por país de audiencia.           |
| IX_Metricas_Seguidores    | seguidores           | No clúster | Facilita ordenamientos o comparativas por número de seguidores. |
| IX_Metricas_Interaccion   | interaccion_Promedio | No clúster | Mejora reportes de interacción promedio.                        |

## Objetos relacionados
- **Triggers:** `aviso_influencer_extraño` (se dispara en eventos `INSERT` sobre esta tabla).
- **Procedimientos:** `mayorCantidadSeguidores` (consulta esta tabla para filtrar por seguidores).
- **Vistas:** `vw_ResumenInfluencer` (utiliza esta tabla como fuente principal de datos).

## Seguridad y Clasificación
- **Nivel:** Confidencial.
- **Datos sensibles:** Ninguno. Todas las métricas provienen de una fuente de datos pública.
- **Roles con acceso:** Roles de analista de datos con permisos de `SELECT`. Roles de administrador de ETL con permisos de `INSERT` y `UPDATE`.
- **Dominio:** Métricas de Rendimiento / Análisis de Influencers.
- **Tipo:** Hechos.
- **Uso:** Analítico.