/* =========================================================================
   ARCHIVO: TablaPeriodo.sql
   TIPO: Script SQL
   DOMINIO: Modelo de Datos
   PROPÓSITO: Define la estructura de la tabla [TablaPeriodo], la cual
              almacena la información de los periodos de análisis o
              evaluación asociados a las métricas de los influencers.
              Cada periodo se identifica por un ID único, el mes y el año.
   AUTOR: Clemente Andreé Ortiz Ortiz
   FECHA CREACIÓN: 2025-10-07
   VERSIÓN: 1.0
   DEPENDENCIAS: Ninguna
   CLASIFICACIÓN: Público
   -------------------------------------------------------------------------
   HISTORIAL DE CAMBIOS:
   v1.0 - 2025-10-07 - Clemente Andreé Ortiz Ortiz - Creación inicial del script de la tabla [TablaPeriodo].
========================================================================= */

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TablaPeriodo](
	[ID_Periodo] [tinyint] NOT NULL,
	[Mes] [nvarchar](50) NOT NULL,
	[Año] [smallint] NOT NULL,
 CONSTRAINT [PK_Tabla_Periodo] PRIMARY KEY CLUSTERED 
(
	[ID_Periodo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
