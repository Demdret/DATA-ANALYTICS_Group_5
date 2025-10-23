USE INSTAGRAM_2022;

--Consultas utilizadas para añadir valores a los campos nulos de la columna audiencia_Autentica
--Selects para encontrar los valores más altos y bajos de la columna audiencia_Autentica
SELECT * FROM TablaMetricas;

SELECT TOP(5) * 
FROM TablaMetricas
ORDER BY audiencia_Autentica DESC;

SELECT TOP(25) *
FROM TablaMetricas
WHERE audiencia_Autentica IS NOT NULL
ORDER BY audiencia_Autentica ASC;

/*Funcion que arroja un número entre los valores más altos y bajos con el objetivo de rellenar campos
nulos con valores "realistas"*/
;WITH RandomValues AS (
    SELECT 
        TOP (1022)
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS ID,
        CAST(42000 + (RAND(CHECKSUM(NEWID())) * (178000000 - 42000)) AS INT) AS valor
    FROM sys.all_objects
)
UPDATE T
SET T.audiencia_Autentica = R.valor
FROM TablaMetricas AS T
INNER JOIN RandomValues AS R
    ON T.ID_Metricas = R.ID;

--Consultas utilizadas para añadir valores a los campos nulos de la columna interaccion_Promedio
SELECT * FROM TablaMetricas;

SELECT TOP(5) * 
FROM TablaMetricas
ORDER BY interaccion_Promedio DESC;

SELECT TOP(25) *
FROM TablaMetricas
WHERE interaccion_Promedio IS NOT NULL
ORDER BY interaccion_Promedio ASC;
/*Funcion que arroja un número entre los valores más altos y bajos con el objetivo de rellenar campos
nulos con valores "realistas"*/
;WITH RandomValues AS (
    SELECT 
        TOP (1022)
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS ID,
        CAST(73000 + (RAND(CHECKSUM(NEWID())) * (234000000 - 73000)) AS INT) AS valor
    FROM sys.all_objects
)
UPDATE T
SET T.interaccion_Promedio = R.valor
FROM TablaMetricas AS T
INNER JOIN RandomValues AS R
    ON T.ID_Metricas = R.ID;

--Consultas utilizadas para añadir valores a los campos nulos de la columna likes_Promedio
SELECT * FROM TablaMetricas;

SELECT TOP(5) * 
FROM TablaMetricas
ORDER BY likes_Promedio DESC;

SELECT TOP(25) *
FROM TablaMetricas
WHERE likes_Promedio IS NOT NULL
ORDER BY likes_Promedio ASC;
/*Funcion que arroja un número entre los valores más altos y bajos con el objetivo de rellenar campos
nulos con valores "realistas", uso de una base distinta ya que la anterior no tenía los valores suficientes*/
;WITH Numbers AS (
    SELECT TOP (3050)
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) + 1022 AS ID
    FROM master.dbo.spt_values a
    CROSS JOIN master.dbo.spt_values b
),
RandomValues AS (
    SELECT 
        ID,
        CAST(52000 + (RAND(CHECKSUM(NEWID())) * (132000000 - 52000)) AS INT) AS valor
    FROM Numbers
)
UPDATE T
SET T.likes_Promedio = R.valor
FROM TablaMetricas AS T
INNER JOIN RandomValues AS R
    ON T.ID_Metricas = R.ID;

--Consultas utilizadas para añadir valores a los campos nulos de la columna comentarios_Promedio
SELECT * FROM TablaMetricas;

SELECT TOP(5) * 
FROM TablaMetricas
ORDER BY comentarios_Promedio DESC;

SELECT TOP(25) *
FROM TablaMetricas
WHERE comentarios_Promedio IS NOT NULL
ORDER BY comentarios_Promedio ASC;
/*Funcion que arroja un número entre los valores más altos y bajos con el objetivo de rellenar campos
nulos con valores "realistas", uso de una base distinta ya que la anterior no tenía los valores suficientes*/
;WITH Numbers AS (
    SELECT TOP (3050)
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) + 1022 AS ID
    FROM master.dbo.spt_values a
    CROSS JOIN master.dbo.spt_values b
),
RandomValues AS (
    SELECT 
        ID,
        CAST(69000 + (RAND(CHECKSUM(NEWID())) * (132000000 - 69000)) AS INT) AS valor
    FROM Numbers
)
UPDATE T
SET T.comentarios_Promedio = R.valor
FROM TablaMetricas AS T
INNER JOIN RandomValues AS R
    ON T.ID_Metricas = R.ID;

--Consulta para cambiar aquellos paises que tienen numeros en el nombre
SELECT ID_Metricas, pais_Audiencia
FROM TablaMetricas
WHERE pais_Audiencia LIKE '%[0-9]%';

UPDATE TablaMetricas
SET pais_Audiencia = 'United State'
WHERE pais_Audiencia LIKE '%[0-9]%';

