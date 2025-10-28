/* =========================================================================
   ARCHIVO: Vistas.sql
   TIPO: Vista 
   DOMINIO: Reportes y Análisis
   PROPÓSITO: Define la vista 'vw_ResumenInfluencer' para proporcionar
              un resumen pre-calculado y agrupado de las métricas
              promedio de cada influencer, uniendo datos de contenido
              y métricas para simplificar las consultas de reporte.
   AUTOR: Clemente Andreé Ortiz Ortiz
   FECHA CREACIÓN: 2024-05-21
   VERSIÓN: 1.0
   DEPENDENCIAS: TablaMetricas, TablaContenido
   CLASIFICACIÓN: Confidencial
   -------------------------------------------------------------------------
   HISTORIAL DE CAMBIOS:
   v1.0 - 2025-10-16 - Clemente Andreé Ortiz Ortiz - Creación inicial de la vista.
========================================================================= */


-- Creación de la vista para un resumen de métricas por influencer
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