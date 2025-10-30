# Glosario de Términos - Selección Estratégica de Influencers en Instagram

## Términos de Análisis (Dominio)
| Término | Definición |
|---|---|
| **Engagement** | Métrica que mide el nivel de interacción que la audiencia tiene con el contenido de un influencer. Se calcula sumando likes, comentarios, compartidos, etc., y dividiéndolo por el alcance o el número de seguidores. |
| **KPIs (Key Performance Indicators)** | Indicadores Clave de Rendimiento. Son métricas cuantificables utilizadas para evaluar el éxito de un objetivo. En este proyecto, ejemplos son `interaccion_Promedio` y `audiencia_Autentica`. |
| **Alcance (Reach)** | Número total de usuarios únicos que han visto una publicación o contenido. Es una métrica fundamental para medir la visibilidad de una campaña. |
| **Segmentación Temática** | Proceso de clasificar y agrupar a los influencers según las categorías principales de su contenido (ej. "Música", "Moda"). Permite a las marcas dirigirse a nichos de mercado específicos. |
| **Click-Through Rate (CTR)** | Porcentaje de usuarios que hacen clic en un enlace específico (ej. en la biografía o una historia) en relación con el número total de usuarios que lo vieron. Mide la efectividad para dirigir tráfico. |
| **Retention (Retención)** | Capacidad de un influencer para mantener a su audiencia interesada y comprometida a lo largo del tiempo. Una alta retención indica una comunidad leal. |

## Términos Técnicos (Base de Datos)
| Término | Definición |
|---|---|
| **Normalización** | Proceso de diseño de la base de datos que busca minimizar la redundancia de datos y mejorar la integridad. En este proyecto, se aplicó creando un esquema de estrella con tablas de hechos y dimensiones. |
| **PK (Primary Key)** | Clave Primaria. Es una columna (o conjunto de columnas) que identifica de forma única cada fila en una tabla. No puede contener valores nulos. Ejemplo: `ID_Influencer` en `TablaInfluencer`. |
| **FK (Foreign Key)** | Clave Foránea. Es una columna que crea una relación entre dos tablas, vinculando una fila de una tabla con una fila de otra. Garantiza la integridad referencial. Ejemplo: `ID_Influencer` en `TablaMetricas`. |
| **Índices (Indexes)** | Estructuras de datos que mejoran la velocidad de las operaciones de consulta en una tabla. Funcionan de manera similar al índice de un libro, permitiendo al motor de la base de datos encontrar datos rápidamente. |
| **Trigger** | Disparador. Es un tipo especial de procedimiento almacenado que se ejecuta automáticamente en respuesta a un evento (INSERT, UPDATE, DELETE) en una tabla. Ejemplo: `aviso_influencer_extraño`. |
| **Transaccional** | Se refiere a una operación (o secuencia de operaciones) que se trata como una única unidad de trabajo atómica. O todas las operaciones tienen éxito (COMMIT) o ninguna lo tiene (ROLLBACK), garantizando la consistencia de los datos. |
| **Not Null** | Restricción de columna que asegura que un campo no puede tener un valor nulo. Obliga a que siempre se proporcione un valor para esa columna al insertar una nueva fila. |
| **Unique** | Restricción que asegura que todos los valores en una columna (o conjunto de columnas) son diferentes entre sí. Permite valores nulos, pero solo uno. Ejemplo: `nombre_Usuario` en `TablaInfluencer`. |
| **Archivo Plano (Flat File)** | Archivo de texto (como .CSV o .TXT) donde los datos se almacenan sin una estructura jerárquica o relacional. Fue el formato de origen de los datos de Kaggle antes del proceso ETL. |

## Reglas de Análisis (Ejemplos del Proyecto)
| Regla | Descripción | Implementación Técnica |
|---|---|---|
| **Detección de Influencer Anómalo** | Un influencer es clasificado como "extraño" o potencialmente poco fiable si tiene una base de seguidores muy grande (> 20 millones) pero sus métricas de interacción (likes o comentarios) son desproporcionadamente bajas. | `TRIGGER aviso_influencer_extraño` en la tabla `TablaMetricas`. |
| **Clasificación de Influencer Confiable** | Un influencer se considera de "confiable" si su promedio de likes individuales es superior al 30% de su número de seguidores.| Consulta de análisis en `SQL Server QueryProyecto.sql` que utiliza una subconsulta para el promedio global. |
| **Segmentación por Tamaño de Audiencia** | Los influencers pueden ser segmentados según su número de seguidores (ej. > 1,000,000 para "macro-influencers") para facilitar análisis específicos. | `PROCEDURE mayorCantidadSeguidores` que acepta un umbral como parámetro. |
