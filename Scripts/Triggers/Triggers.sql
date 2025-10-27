/* =========================================================================
   ARCHIVO: Triggers.sql
   TIPO: Trigger
   DOMINIO: Auditoría de Datos
   PROPÓSITO: Define el trigger 'aviso_influencer_extraño' que se dispara
              tras una inserción en 'TablaMetricas' para detectar y
              advertir sobre perfiles con métricas inconsistentes
              (muchos seguidores, baja interacción).
   AUTOR: Francisco Peix
   FECHA CREACIÓN: 2025-10-25
   VERSIÓN: 1.0
   DEPENDENCIAS: TablaMetricas
   CLASIFICACIÓN: Confidencial
   -------------------------------------------------------------------------
   HISTORIAL DE CAMBIOS:
   v1.0 - 2025-10-25 - Francisco Peix - Creación inicial del trigger.
========================================================================= */


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