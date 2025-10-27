/* =========================================================================
   ARCHIVO: Variables_y_Condiciones.sql
   TIPO: Script SQL
   DOMINIO: Análisis de Datos
   PROPÓSITO: Ejemplifica el uso de variables y estructuras de control
              condicional (IF/ELSE) para consultar y clasificar a un
              influencer específico según su número de seguidores.
   AUTOR: Andree Clemente Ortiz
   FECHA CREACIÓN: 2025-10-14
   VERSIÓN: 1.0
   DEPENDENCIAS: TablaInfluencer, TablaMetricas
   CLASIFICACIÓN: Confidencial
   -------------------------------------------------------------------------
   HISTORIAL DE CAMBIOS:
   v1.0 - 2025-10-14 - Andree Clemente Ortiz - Creación inicial del script de ejemplo.
========================================================================= */

--- Bloque con variables y condiciones

-- BLOQUE: variables y condiciones (script de ejemplo)
DECLARE 
    @usuario NVARCHAR(100) = N'ejemplo_usuario',                       
    @idInfluencer SMALLINT = 742,
    @idPeriodo TINYINT,
    @seguidoresActual BIGINT;

-- 1) Obtener el ID_Influencer a partir del nombre de usuario
SELECT @idInfluencer = ID_Influencer
FROM dbo.TablaInfluencer
WHERE nombre_Usuario = @usuario;

IF @idInfluencer IS NULL
BEGIN
    PRINT 'No existe el influencer con ese nombre de usuario.';
    RETURN; -- Salimos del script porque no hay influencer
END

-- 2) Verificar si ya hay métricas para ese influencer y periodo
SELECT @seguidoresActual = seguidores
FROM dbo.TablaMetricas
WHERE ID_Influencer = @idInfluencer

IF @seguidoresActual IS NULL
BEGIN
    PRINT 'No existe registro de métricas para ese influencer. Puedes insertarlo.';
END
ELSE
BEGIN
    -- Ejemplo de condición usando el número de seguidores
    IF @seguidoresActual >= 1000000
        PRINT 'Este influencer es de al menos 1M seguidores en ese periodo.';
    ELSE IF @seguidoresActual BETWEEN 100000 AND 999999
        PRINT 'Este influencer está entre 100k y 1M seguidores.';
    ELSE
        PRINT 'Menos de 100k seguidores.';
END

GO