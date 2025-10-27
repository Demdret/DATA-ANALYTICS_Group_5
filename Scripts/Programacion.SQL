--- Clase 21/10/2025

--- Procediento con Parámetros: Buscar influencers con 
CREATE PROCEDURE mayorCantidadSeguidores 
    @cantidadSeguidores INT
AS
BEGIN
    SELECT i.nombre_Usuario, m.seguidores
    FROM TablaMetricas AS m
    INNER JOIN TablaInfluencer AS i
    ON m.ID_Influencer = i.ID_Influencer
    WHERE m.seguidores > @cantidadSeguidores;
END

EXEC mayorCantidadSeguidores @cantidadSeguidores = 1000000;
GO


--- Trigger de Auditoría


CREATE OR ALTER TRIGGER aviso_influencer_extraño
ON TablaMetricas
AFTER INSERT
AS
BEGIN
    DECLARE @id INT, @cantidadSeguidores INT, @likesPromedio INT, @cantidadComentarios INT;
    SELECT @id = ID_Influencer, @cantidadSeguidores = seguidores, @likesPromedio = likes_Promedio, @cantidadComentarios = comentarios_Promedio FROM inserted;

    IF @cantidadSeguidores > 20000000 AND (@likesPromedio < 5000000 OR @cantidadComentarios < 50000)
        PRINT '⚠️ Atención: El influencer con ID ' + CAST(@id AS NVARCHAR(100)) + ' parece un influencer extraño, tener cuidado.';
END;
GO



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

