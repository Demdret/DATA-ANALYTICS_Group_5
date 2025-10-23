CREATE DATABASE INSTAGRAM_2022;

USE INSTAGRAM_2022;

--Crear consultas escalares
SELECT ID_Metricas, pais_Audiencia, UPPER(pais_Audiencia) AS Pais_Mayusculas
FROM TablaMetricas;

SELECT ID_Metricas, likes_Promedio, SQRT(likes_Promedio) AS Raiz_Likes
FROM TablaMetricas;

SELECT ID_Metricas, interaccion_Promedio, ROUND(interaccion_Promedio, 0) AS Interaccion_Entera
FROM TablaMetricas;

--Consultas Agregacion
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

--Consultas con Join + Subconsulta implementada
SELECT 
    c.ID_Influencer,
    c.categoria1,
    m.pais_Audiencia,
    AVG(CAST(m.likes_Promedio AS DECIMAL(12,2))) AS Promedio_Likes
FROM dbo.TablaMetricas AS m
INNER JOIN dbo.TablaContenido AS c
    ON m.ID_Influencer = c.ID_Influencer
WHERE CAST(m.likes_Promedio AS DECIMAL(12,2)) > (
    SELECT AVG(CAST(likes_Promedio AS DECIMAL(12,2)))
    FROM dbo.TablaMetricas
)
GROUP BY c.ID_Influencer, c.categoria1, m.pais_Audiencia;

SELECT 
    m.pais_Audiencia,
    ROUND(AVG(CAST(m.audiencia_Autentica AS DECIMAL(12,2))), 2) AS Promedio_Autenticidad,
    COUNT(DISTINCT m.ID_Influencer) AS Total_Influencers,
    (
        SELECT COUNT(DISTINCT c.ID_Influencer)
        FROM TablaContenido AS c
        INNER JOIN TablaMetricas AS m2
            ON c.ID_Influencer = m2.ID_Influencer
        WHERE c.categoria2 IS NOT NULL
          AND m2.pais_Audiencia = m.pais_Audiencia
    ) AS Influencers_Multicategoria
FROM TablaMetricas AS m
GROUP BY m.pais_Audiencia;

--Creacion de la vista
Go 
IF OBJECT_ID('dbo.vw_ResumenInfluencer','V') IS NOT NULL
    DROP VIEW dbo.vw_ResumenInfluencer;
GO
CREATE VIEW vw_ResumenInfluencer AS
SELECT 
    c.ID_Influencer,
    c.categoria1,
    c.categoria2,
    m.pais_Audiencia,
    AVG(CAST(m.seguidores AS DECIMAL(18,2))) AS Promedio_Seguidores,
    AVG(CAST(m.likes_Promedio AS DECIMAL(12,2))) AS Promedio_Likes,
    AVG(CAST(m.comentarios_Promedio AS DECIMAL(12,2))) AS Promedio_Comentarios,
    AVG(CAST(m.audiencia_Autentica AS DECIMAL(12,2))) AS Promedio_Autenticidad
FROM dbo.TablaMetricas AS m
INNER JOIN dbo.TablaContenido AS c
    ON m.ID_Influencer = c.ID_Influencer
GROUP BY c.ID_Influencer, c.categoria1, c.categoria2, m.pais_Audiencia;

GO







