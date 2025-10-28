/* =========================================================================
   ARCHIVO: Join.sql
   TIPO: Script SQL
   DOMINIO: Consultas y Análisis de Datos
   PROPÓSITO: Contiene ejemplos de consultas que combinan el uso de 
              sentencias JOIN y subconsultas para relacionar información 
              entre las tablas [TablaMetricas] y [TablaContenido]. 
              Estas consultas permiten obtener promedios, conteos y 
              comparaciones complejas basadas en condiciones anidadas.
   AUTOR: Clemente Andreé Ortiz Ortiz
   FECHA CREACIÓN: 2025-10-16
   VERSIÓN: 1.0
   DEPENDENCIAS: TablaMetricas, TablaContenido
   CLASIFICACIÓN: Público
   -------------------------------------------------------------------------
   HISTORIAL DE CAMBIOS:
   v1.0 - 2025-10-16 - Clemente Andreé Ortiz Ortiz - Creación inicial del script de consultas con JOIN y subconsultas.
========================================================================= */

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








