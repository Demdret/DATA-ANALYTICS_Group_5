# 📌 Bitácora de Análisis de Datos
# Proyecto: Selección Estratégica de Influencers en Instagram
# Autoras y Autores
# Base de Datos: Kaggle – Top 1000 Social Media Channels

**Base de Datos de Origen:** [Top 1000 Social Media Channels - Kaggle](https://www.kaggle.com/datasets/aayushmishra1512/top-1000-social-media-channels)

## 1. Objetivo del Proyecto
Desarrollar un sistema de análisis de datos que permita a las corporaciones identificar a influencers con audiencias auténticas y confiables en Instagram. El objetivo es optimizar la selección de perfiles para campañas publicitarias, evaluando métricas clave de rendimiento y engagement.

## 2. Metodología y Procesamiento de Datos (ETL)

El proceso se dividió en varias fases, desde la ingesta y limpieza hasta la estructuración final para el análisis.

### 2.1. Ingesta y Unificación de Datos
Se consolidaron múltiples archivos .CSV correspondientes a los meses de **Junio, Septiembre, Noviembre y Diciembre de 2022**. La herramienta **Power Query** se utilizó para unificar estas fuentes en un único conjunto de datos.

### 2.2. Limpieza y Estandarización
Se aplicaron las siguientes operaciones para ajustar, estabilizar y simplificar los datos, excluyendo información innecesaria o repetida:
- **Creación de IDs únicos:** Se generaron identificadores (`ID_Influencer`, `ID_Periodo`) para normalizar el modelo.
- **Conversión de Formatos:** Se transformaron valores abreviados a su equivalente numérico (ej. "1.5M" → "1500000").
- **Renombrado de Campos:** Se ajustaron los nombres de las columnas para mayor claridad y consistencia.

| Campo Original         | Campo Renombrado       |
|------------------------|------------------------|
| Instagram Name         | Nombre_Usuario         |
| Category_1             | Contenido              |
| Subscribers            | Cantidad_Seguidores    |
| Audience Country       | Audiencia_Promedio     |
| Authentic Engagement   | Engagement_Auténtico   |

- **Imputación de Nulos:** Se rellenaron valores nulos en columnas de métricas (`audiencia_Autentica`, `interaccion_Promedio`, `likes_Promedio`, `comentarios_Promedio`) utilizando scripts de SQL para generar valores aleatorios dentro de rangos realistas, basados en los datos existentes.
- **Corrección de Datos Categóricos:** Se estandarizaron nombres de países que contenían errores o caracteres numéricos.

### 2.3. Modelado de Datos
Se diseñó un **Modelo Entidad-Relación (DER)** y se implementó un **esquema de estrella** para optimizar las consultas analíticas.

*   **Tabla de Hechos:** `TablaMetricas` (contiene las métricas cuantitativas por influencer y periodo).
*   **Dimensiones:** `TablaInfluencer`, `TablaContenido`, `TablaPeriodo`.

Este modelo normalizado elimina redundancias y facilita el análisis multidimensional.

## 3. Exploración y Correlaciones (EDA)

Se calcularon estadísticas descriptivas (media, mediana, moda, rango, varianza y desviación estándar) para las métricas principales:
-Seguidores
-Likes promedio
-Comentarios promedio
-Audiencia auténtica
-Interacción promedio

Las correlaciones más significativas observadas fueron:

*   **Correlación Positiva Fuerte:** Entre `Likes` y `Comentarios`.
*   **Correlación Positiva Moderada:** Entre `Seguidores` y el total de `Likes/Comentarios`.
*   **Correlación Negativa (Observada):** Entre el número de `Seguidores` y la tasa de `Engagement` en perfiles de macroinfluencers, sugiriendo que a mayor audiencia, el engagement porcentual tiende a disminuir.

## 4. Lógica de Análisis y Reglas SQL
Para llevar a cabo el respectivo análisis de los datos que se tienen, ya normalizados, fueron empleadas diversas consultas SQL.
Estas consultas fueron implementadas, tomando siempre en cuenta el objetivo principal del análisis planteado inicialmente: identificar influencers confiables para que las empresas y campañas puedan acudir a los indicados, y no caigan en estafas, eligiendo a influencers ""falsos"".
Se implementaron diversos objetos y scripts SQL para automatizar el análisis y garantizar la integridad de los datos.

### 4.1. Consultas de Análisis
Se desarrollaron consultas para responder a preguntas clave del análisis.

*   **Identificación de Influencers de Alto Rendimiento:** Se construyó una consulta que utiliza una subconsulta para calcular el promedio general de `likes` en la plataforma. Luego, filtra y agrupa a aquellos influencers cuyo rendimiento individual supera esta media, permitiendo identificar a los perfiles más destacados por categoría y país.

*   **Análisis de Mercados por País:** Se implementó una consulta de agregación que calcula la autenticidad promedio de la audiencia y el número total de influencers por país. Mediante la cláusula `HAVING`, se filtra el resultado para mostrar únicamente aquellos mercados que cumplen con umbrales de calidad predefinidos (ej. autenticidad > 70% y un número mínimo de influencers), facilitando la identificación de mercados estratégicos.

*   **Conteo de Influencers Multicategoría:** Para entender la versatilidad de los perfiles, se diseñó una consulta que cuenta cuántos influencers pertenecen a más de una categoría dentro de cada país. Esto se logró mediante una subconsulta correlacionada, ofreciendo una visión sobre la diversidad de contenido en diferentes regiones.

### 4.2. Procedimientos Almacenados
Se crearon procedimientos para encapsular lógica de análisis reutilizable.

*   **`mayorCantidadSeguidores`**: Este procedimiento parametrizado permite a un usuario especificar una cantidad de seguidores y devuelve una lista de todos los influencers que superan dicho umbral. Esto simplifica la tarea de segmentar perfiles por tamaño de audiencia sin necesidad de reescribir la consulta.

### 4.3. Triggers de Auditoría
Para mantener la calidad de los datos, se implementó un trigger que actúa como un sistema de alerta.

*   **`aviso_influencer_extraño`**: Este trigger se activa automáticamente tras una inserción en la `TablaMetricas`. Su lógica interna evalúa si un influencer con una gran cantidad de seguidores (ej. > 20 millones) presenta métricas de interacción sospechosamente bajas. Si se cumple la condición, imprime una advertencia en la consola, ayudando a los analistas a detectar perfiles con audiencias potencialmente "infladas" o inactivas en tiempo real.

### 4.4. Transacciones y Manejo de Errores
Los scripts críticos se envolvieron en bloques de transacción con manejo de errores (`TRY/CATCH`) para garantizar la atomicidad de las operaciones. Si ocurre un error en cualquier punto, la transacción se revierte (`ROLLBACK`) para evitar estados de datos inconsistentes.

### 4.5. Vistas
Se creó una vista para simplificar el acceso a datos agregados y pre-unidos.

*   **`vw_ResumenInfluencer`**: Proporciona un resumen completo por influencer, uniendo las tablas de métricas y contenido y pre-calculando promedios de seguidores, likes, comentarios y autenticidad. Esto facilita la creación de reportes y dashboards.

## 5. Cómo Empezar

Para replicar el entorno de análisis, sigue estos pasos:

1.  **Crear y poblar la base de datos:** Ejecuta los scripts de creación de tablas y carga de datos iniciales (provenientes del ETL).
2.  **Limpiar los datos:** Ejecuta el script `Scripts/Query_Clean_Database.sql` para imputar valores nulos y corregir inconsistencias.
3.  **Implementar la lógica de análisis:** Ejecuta los scripts contenidos en las carpetas `Procedimientos`, `Triggers` y `Vistas` para crear los objetos de base de datos.
4.  **Realizar análisis:** Utiliza las consultas en `Scripts/SQL Server QueryProyecto.sql` para explorar los datos y obtener insights.

## 6. Estructura del Repositorio

```
/
├── Scripts/
│   ├── Procedimientos/
│   │   └── Procedimientos.sql
│   ├── Transacciones/
│   │   └── Transacciones.sql
│   ├── Triggers/
│   │   └── Triggers.sql
│   ├── Variables_y_Condiciones/
│   │   └── Variables_y_Coniciones.sql
│   ├── Query_Clean_Database.sql
│   └── SQL Server QueryProyecto.sql
├── README.md
└── ... (otros archivos de configuración y documentación)
```


## 6. Autoras y Autores
*   [Francisco Peix]
*   [Clemente Andreé Ortiz Ortiz]
*   [Perla Muñoz Arizai]
*   [Mizraim Jehosua Castillo Santoyo]
