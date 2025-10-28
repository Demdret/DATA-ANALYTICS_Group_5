/* =========================================================================
   ARCHIVO: TablaInfluencer.sql
   TIPO: Script SQL
   DOMINIO: Modelo de Datos
   PROPÓSITO: Define la estructura de la tabla [TablaInfluencer], la cual
              almacena información básica de los influencers registrados,
              incluyendo su identificador único y nombre de usuario.
   AUTOR: Clemente Andreé Ortiz Ortiz
   FECHA CREACIÓN: 2025-10-07
   VERSIÓN: 1.0
   DEPENDENCIAS: Ninguna
   CLASIFICACIÓN: Público
   -------------------------------------------------------------------------
   HISTORIAL DE CAMBIOS:
   v1.0 - 2025-10-07 - Clemente Andreé Ortiz Ortiz - Creación inicial del script de la tabla [TablaInfluencer].
========================================================================= */

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TablaInfluencer](
	[ID_Influencer] [smallint] NOT NULL,
	[nombre_Usuario] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Tabla_Influencer] PRIMARY KEY CLUSTERED 
(
	[ID_Influencer] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
