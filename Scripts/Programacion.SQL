--- Clase 21/10/2025

--- Procediento con Parámetros: Buscar influencers con 
CREATE PROCEDURE mayorCantidadSeguidores 
    @cantidadSeguidores INT
AS
BEGIN
    SELECT i.nombre_Usuario, m.seguidores
    FROM Tabla_Metricas AS m
    INNER JOIN Tabla_Influencer AS i
    ON m.ID_Influencer = i.ID_Influencer
    WHERE m.seguidores > @cantidadSeguidores;
END


EXEC mayorCantidadSeguidores @cantidadSeguidores = 1000000;
GO


--- Trigger de Auditoría


CREATE OR ALTER TRIGGER aviso_influencer_extraño
ON Tabla_Metricas
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

DECLARE @PromedioColesterol DECIMAL(6,2);
SELECT @PromedioColesterol = AVG(Colesterol) FROM clinica.Pacientes;

PRINT 'Promedio de colesterol: ' + CAST(@PromedioColesterol AS NVARCHAR(10));

IF @PromedioColesterol > 200
    PRINT 'El promedio es ALTO';
ELSE
    PRINT 'El promedio es NORMAL';
GO



--- Transacción con manejo de errores

BEGIN TRANSACTION;
    -- operaciones DML
    IF @@ERROR <> 0 ROLLBACK;
    ELSE COMMIT;
