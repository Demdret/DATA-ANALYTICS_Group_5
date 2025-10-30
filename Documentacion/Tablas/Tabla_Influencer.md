# Tabla: `TablaInfluencer`

Esta tabla de dimensión actúa como el registro de los influencers. Su función principal es almacenar los atributos descriptivos y únicos de cada perfil, como su nombre de usuario. Al centralizar esta información, se garantiza la consistencia de los datos y se evita la redundancia. Es el eje central del modelo de estrella, conectando las métricas (`TablaMetricas`) y el contenido (`TablaContenido`) a un perfil específico.

## Estructura
| Columna | Tipo | Reglas | Descripción |
|---|---|---|---|
| `ID_Influencer` | `SMALLINT` | `PK`, `NOT NULL`, `IDENTITY(1,1)` | Clave primaria subrogada que identifica de forma única a cada influencer. |
| `nombre_Usuario` | `NVARCHAR(100)` | `NOT NULL`, `UNIQUE` | Nombre de usuario del influencer en Instagram. Se aplica una restricción de unicidad para evitar duplicados. |

## Claves
- **PK:** `ID_Influencer`
- **FK:** Ninguna.

## Indices definidos
| Nombre del índice    | Columna        | Tipo       | Notas                                                                        |
| -------------------- | -------------- | ---------- | ---------------------------------------------------------------------------- |
| IX_Influencer_Nombre | nombre_Usuario | No clúster | Mejora búsquedas por nombre de usuario, especialmente en filtros o reportes. |


## Objetos relacionados
- **Triggers:** Ninguno.
- **Procedimientos:** `mayorCantidadSeguidores` (consulta esta tabla para obtener el nombre del influencer).
- **Vistas:** Ninguna directamente, pero es consultada por procedimientos y scripts que sí son usados en vistas o análisis.

## Seguridad y Clasificación
- **Nivel:** Confidencial.
- **Datos sensibles:** `nombre_Usuario` es información pública.
- **Roles con acceso:** Roles de analista de datos con permisos de `SELECT`. Roles de administrador de ETL con permisos de `INSERT` y `UPDATE`.
- **Dominio:** Análisis de Influencers.
- **Tipo:** Dimensión.
- **Uso:** Analítico.