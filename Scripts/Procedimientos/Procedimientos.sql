/* =========================================================================
   ARCHIVO: Procedimientos.sql
   TIPO: Procedimiento Almacenado
   DOMINIO: Análisis de Datos
   PROPÓSITO: Define el procedimiento 'mayorCantidadSeguidores' para
              buscar y listar influencers que superan una cantidad
              específica de seguidores.
   AUTOR: Francisco Peix
   FECHA CREACIÓN: 2025-10-21
   VERSIÓN: 1.0
   DEPENDENCIAS: TablaMetricas, TablaInfluencer
   CLASIFICACIÓN: Público
   -------------------------------------------------------------------------
   PARÁMETROS:
   @cantidadSeguidores: INT - Umbral mínimo de seguidores para filtrar los resultados.
   -------------------------------------------------------------------------
   HISTORIAL DE CAMBIOS:
   v1.0 - 2025-10-21 - Francisco Peix - Creación inicial del procedimiento.
========================================================================= */

--- Procedimiento con Parámetros: Buscar influencers con una mayor cantidad de seguidores a un parámetro pasado

CREATE OR ALTER PROCEDURE mayorCantidadSeguidores 
    @cantidadSeguidores INT
AS
BEGIN
    SELECT i.nombre_Usuario, m.seguidores
    FROM TablaMetricas AS m
    INNER JOIN TablaInfluencer AS i
    ON m.ID_Influencer = i.ID_Influencer
    WHERE m.seguidores > @cantidadSeguidores;
END

-- Ejemplo de ejecución:
EXEC mayorCantidadSeguidores @cantidadSeguidores = 1000000;
GO
