# Tabla: `TablaPeriodo`

Esta tabla de dimensión almacena los periodos de tiempo discretos en los que se recopilaron los datos (Junio, Septiembre, Noviembre y Diciembre de 2022). Su función es permitir el análisis de tendencias y la evolución de las métricas de los influencers a lo largo del tiempo. En el esquema de estrella, conecta la tabla de hechos `TablaMetricas` con un contexto temporal específico.

## Estructura
| Columna | Tipo | Reglas | Descripción |
|---|---|---|---|
| `ID_Periodo` | `TINYINT` | `PK`, `NOT NULL`, `IDENTITY(1,1)` | Clave primaria subrogada que identifica de forma única cada periodo. |
| `Mes` | `NVARCHAR(20)` | `NOT NULL` | Nombre del mes en que se tomaron los datos. |
| `Anio` | `SMALLINT` | `NOT NULL` | Año en que se tomaron los datos. |

## Claves
- **PK:** `ID_Periodo`
- **FK:** Ninguna.

## Indices definidos
| Nombre del índice  | Columna  | Tipo       | Notas                                      |
| ------------------ | -------- | ---------- | ------------------------------------------ |
| IX_Periodo_Mes_Año | Mes, Año | No clúster | Mejora búsquedas combinadas por mes y año. |

## Objetos relacionados
- **Triggers:** Ninguno.
- **Procedimientos:** Ninguno.
- **Vistas:** Ninguna.

## Seguridad y Clasificación
- **Nivel:** Confidencial.
- **Datos sensibles:** Ninguno.
- **Roles con acceso:** Roles de analista de datos con permisos de `SELECT`. Roles de administrador de ETL con permisos de `INSERT` y `UPDATE`.
- **Dominio:** Dimensión Temporal / Análisis de Influencers.
- **Tipo:** Dimensión.
- **Uso:** Analítico.