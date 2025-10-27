SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TablaContenido](
	[ID_Contenido] [smallint] NOT NULL,
	[ID_Influencer] [smallint] NOT NULL,
	[categoria1] [nvarchar](50) NULL,
	[categoria2] [nvarchar](50) NULL,
 CONSTRAINT [PK_Tabla_Contenido] PRIMARY KEY CLUSTERED 
(
	[ID_Contenido] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TablaContenido]  WITH CHECK ADD  CONSTRAINT [FK_Contenido_Influencer] FOREIGN KEY([ID_Influencer])
REFERENCES [dbo].[TablaInfluencer] ([ID_Influencer])
GO
ALTER TABLE [dbo].[TablaContenido] CHECK CONSTRAINT [FK_Contenido_Influencer]
GO
