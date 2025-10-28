/* =========================================================================
   ARCHIVO: Transacciones.sql
   TIPO: Script SQL
   DOMINIO: Integridad de Datos
   PROPÓSITO: Ejemplifica el uso de una transacción explícita con manejo
              de errores (TRY/CATCH) para consultar datos de forma
              atómica y segura. Valida la existencia de un influencer
              y si cumple una condición de seguidores.
   AUTOR: Clemente Andreé Ortiz Ortiz
   FECHA CREACIÓN: 2025-10-16
   VERSIÓN: 1.0
   DEPENDENCIAS: TablaInfluencer, TablaMetricas
   CLASIFICACIÓN: Público
   -------------------------------------------------------------------------
   HISTORIAL DE CAMBIOS:
   v1.0 - 2025-10-16 - Clemente Andreé Ortiz Ortiz - Creación inicial del script de ejemplo.
========================================================================= */

--- Transacción con manejo de errores

BEGIN TRY
    BEGIN TRANSACTION;

    DECLARE
        @usuario NVARCHAR(100) = N'ejemplo_usuario',
        @idInfluencer SMALLINT = 4,
        @seguidoresMin BIGINT = 100000;

    -- (1) Buscar el influencer por nombre de usuario
    SELECT @idInfluencer = ID_Influencer
    FROM dbo.TablaInfluencer
    WHERE nombre_Usuario = @usuario;

    -- (2) Validar si existe
    IF @idInfluencer IS NULL
    BEGIN
        PRINT '❌ No existe el influencer con ese nombre de usuario.';
        ROLLBACK TRANSACTION;
        RETURN;
    END

    -- (3) Consultar si cumple con la condición
    SELECT i.nombre_Usuario, m.seguidores
    FROM dbo.TablaInfluencer AS i
    INNER JOIN dbo.TablaMetricas AS m
        ON i.ID_Influencer = m.ID_Influencer
    WHERE i.ID_Influencer = @idInfluencer
      AND m.seguidores > @seguidoresMin;

    -- (4) Validar si cumplió la condición
    IF @@ROWCOUNT = 0
    BEGIN
        PRINT '⚠️ El influencer existe, pero no supera la cantidad mínima de seguidores.';
    END
    ELSE
    BEGIN
        PRINT '✅ El influencer supera la cantidad mínima de seguidores.';
    END

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;

    PRINT '❗Ocurrió un error durante la ejecución.';
    PRINT ERROR_MESSAGE();  -- Muestra el mensaje del error
END CATCH;