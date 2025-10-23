SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TablaMetricas](
	[ID_Metricas] [smallint] NOT NULL,
	[ID_Influencer] [smallint] NOT NULL,
	[ID_Periodo] [tinyint] NOT NULL,
	[seguidores] [bigint] NOT NULL,
	[pais_Audiencia] [nvarchar](50) NULL,
	[likes_Promedio] [int] NULL,
	[comentarios_Promedio] [int] NULL,
	[audiencia_Autentica] [int] NULL,
	[interaccion_Promedio] [int] NULL,
 CONSTRAINT [PK_Tabla_Metricas] PRIMARY KEY CLUSTERED 
(
	[ID_Metricas] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TablaMetricas]  WITH CHECK ADD  CONSTRAINT [FK_Metricas_Influencer] FOREIGN KEY([ID_Influencer])
REFERENCES [dbo].[TablaInfluencer] ([ID_Influencer])
GO
ALTER TABLE [dbo].[TablaMetricas] CHECK CONSTRAINT [FK_Metricas_Influencer]
GO
ALTER TABLE [dbo].[TablaMetricas]  WITH CHECK ADD  CONSTRAINT [FK_Metricas_Periodo] FOREIGN KEY([ID_Periodo])
REFERENCES [dbo].[TablaPeriodo] ([ID_Periodo])
GO
ALTER TABLE [dbo].[TablaMetricas] CHECK CONSTRAINT [FK_Metricas_Periodo]
GO
