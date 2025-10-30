#           Instalación de la base de datos INSTAGRAM_2022            #
#    ** ------------------------------------------------------ **     #
El siguiente procedimiento describe de forma técnica los pasos realizados para crear e importar las tablas de la base de datos **INSTAGRAM_2022** utilizando `SQL Server Management Studio 2020`. El proceso se enfocó en la creación de la base, importación de archivos planos y configuración de sus llaves primarias.

## 1. Acceso al entorno de trabajo

Se ingresó al software `SQL Server Management Studio 2020`, desde donde se gestionó todo el proceso de instalación y carga de datos.

## 2. Creación de la base de datos

Dentro del entorno, se creó una nueva base de datos denominada `INSTAGRAM_2022`, la cual serviría como contenedor principal para las tablas importadas.

## 3. Importación de archivos planos

Se utilizó la herramienta Import Flat File (clic derecho sobre la base de datos → Tasks → Import Flat File).
En cada ejecución del asistente:

-Se especificó la `ubicación del archivo plano` a importar.

-Se permitió la existencia de `valores nulos`, debido a la presencia de campos vacíos.

-Se revisó la estructura de las `columnas` y tipos de datos generados `automáticamente`.

Este procedimiento se repitió `cuatro veces`, una por cada archivo, para importar las `cuatro tablas correspondientes`.

## 4. Definición de llaves primarias

Una vez importadas las tablas, se asignaron las `llaves primarias` en los campos correspondientes, garantizando la integridad y unicidad de los registros.

## 5. Finalización del proceso

Tras verificar la correcta creación y estructura de las tablas, se completó la importación.
La base de datos `INSTAGRAM_2022` quedó lista para su uso, con las cuatro `tablas` correctamente cargadas, admitiendo valores nulos y con sus llaves primarias configuradas.