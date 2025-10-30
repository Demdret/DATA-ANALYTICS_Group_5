/* =========================================================================
   ARCHIVO: Consultas.sql
   TIPO: Script SQL
   DOMINIO: Consultas y Análisis de Datos
   PROPÓSITO: Contiene ejemplos de consultas escalares aplicadas sobre la
              tabla [TablaMetricas], utilizando funciones de conversión,
              transformación y redondeo para obtener resultados derivados
              de los datos originales.
   AUTOR: Clemente Andreé Ortiz Ortiz
   FECHA CREACIÓN: 2025-10-14
   VERSIÓN: 1.0
   DEPENDENCIAS: TablaMetricas
   CLASIFICACIÓN: Público
   -------------------------------------------------------------------------
   HISTORIAL DE CAMBIOS:
   v1.0 - 2025-10-14 - Clemente Andreé Ortiz Ortiz - Creación inicial del script de consultas escalares.
========================================================================= */
SELECT ID_Metricas, pais_Audiencia, UPPER(pais_Audiencia) AS Pais_Mayusculas
FROM TablaMetricas;

SELECT ID_Metricas, likes_Promedio, SQRT(likes_Promedio) AS Raiz_Likes
FROM TablaMetricas;

SELECT ID_Metricas, interaccion_Promedio, ROUND(interaccion_Promedio, 0) AS Interaccion_Entera
FROM TablaMetricas;

/* =========================================================================
   ARCHIVO: Consultas.sql
   TIPO: Script SQL
   DOMINIO: Consultas y Análisis de Datos
   PROPÓSITO: Contiene ejemplos de consultas de agregación aplicadas sobre
              la tabla [TablaMetricas], empleando funciones como AVG, SUM,
              MAX y COUNT para obtener métricas resumidas sobre los
              influencers y su desempeño agrupado por país.
   AUTOR: Clemente Andreé Ortiz Ortiz
   FECHA CREACIÓN: 2025-10-14
   VERSIÓN: 1.0
   DEPENDENCIAS: TablaMetricas
   CLASIFICACIÓN: Público
   -------------------------------------------------------------------------
   HISTORIAL DE CAMBIOS:
   v1.0 - 2025-10-14 - Clemente Andreé Ortiz Ortiz - Creación inicial del script de consultas de agregación.
========================================================================= */
--Esta consulta nos muestra el promedio de seguidores, likes y comentarios de todos los influencer en la tabla metrica
SELECT 
AVG(CAST(CEILING(seguidores) AS BIGINT)) AS Promedio_Seguidores,
AVG(CAST(CEILING(likes_Promedio) AS BIGINT)) AS Promedio_Likes,
AVG(CAST(CEILING(comentarios_Promedio) AS BIGINT)) AS Promedio_Comentarios
FROM TablaMetricas;

--Esta consulta nos muestra la suma de seguidores agrupados por país
SELECT pais_Audiencia, SUM(seguidores) AS Total_Seguidores
FROM TablaMetricas
GROUP BY pais_Audiencia;

--Esta consulta nos muestra el promedio de la audiencia autentica que hay por país
SELECT 
    pais_Audiencia,
    ROUND(AVG(CAST(audiencia_Autentica AS DECIMAL(18,2))), 0) AS Promedio_Autenticidad
FROM TablaMetricas
GROUP BY pais_Audiencia;

--Esta consulta la interacción maxima que tiene un influencer agrupado por país
SELECT pais_Audiencia, MAX(interaccion_Promedio) AS Interaccion_Maxima
FROM TablaMetricas
GROUP BY pais_Audiencia;

--Esta consulta lo que haces agruparnos por país el promedio de autenticidad y el total de registros que hay
SELECT 
    pais_Audiencia, 
    AVG(CAST(audiencia_Autentica AS DECIMAL(18,2))) AS Promedio_Autenticidad, 
    COUNT(*) AS Total_Registros
FROM TablaMetricas
GROUP BY pais_Audiencia
HAVING AVG(CAST(audiencia_Autentica AS DECIMAL(18,2))) > 70 
   AND COUNT(*) > 2;

--Determinar influencer auténticos
SELECT 
    i.nombre_Usuario AS Nombre_Influencer,
    m.seguidores,
    m.likes_Promedio
FROM dbo.TablaMetricas AS m
INNER JOIN dbo.TablaInfluencer AS i
    ON m.ID_Influencer = i.ID_Influencer
WHERE m.likes_Promedio >= (m.seguidores * 0.30);

use INSTAGRAM_2022
