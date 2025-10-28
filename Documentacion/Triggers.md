# Trigger: [aviso_influencer_extraño]

Este trigger funciona como un sistema de alerta en tiempo real para la calidad de los datos. Su propósito es auditar cada nueva fila insertada en la tabla `TablaMetricas` para identificar perfiles de influencers que presenten patrones anómalos, específicamente aquellos con una gran cantidad de seguidores pero una interacción desproporcionadamente baja. Al detectar un caso, imprime una advertencia para que los analistas puedan revisar el perfil manualmente.

## Configuración
- **Tabla asociada:** `TablaMetricas`
- **Evento(s):** `INSERT`
- **Momento:** `AFTER`

## Tablas virtuales
Utiliza la tabla virtual `inserted` para acceder a los datos de la fila que acaba de ser insertada en `TablaMetricas`.

## Lógica
1.  El trigger se activa inmediatamente después de que se completa una operación `INSERT` en `TablaMetricas`.
2.  Captura los valores de `ID_Influencer`, `seguidores`, `likes_Promedio` y `comentarios_Promedio` de la fila recién insertada desde la tabla `inserted`.
3.  Evalúa una condición: si el número de seguidores es mayor a 20 millones **Y** el promedio de likes es menor a 5 millones **O** el promedio de comentarios es menor a 50,000.
4.  Si la condición es verdadera, imprime un mensaje de advertencia en la consola de SQL Server, incluyendo el `ID_Influencer` para su fácil identificación.

## Impacto y consideraciones
*   **Rendimiento:** El impacto en el rendimiento es mínimo, ya que la lógica es simple y solo se ejecuta en operaciones `INSERT`. Sin embargo, el uso de `PRINT` puede no ser visible en todas las aplicaciones cliente.
*   **Limitación:** El diseño actual solo maneja inserciones de una sola fila a la vez. Si se realiza una inserción masiva (`INSERT INTO ... SELECT ...`), el trigger solo evaluará una de las filas insertadas, lo cual es un riesgo importante.
*   **Efectos colaterales:** No modifica datos, solo produce una salida de texto. No hay riesgo de recursividad.
*   **Deshabilitación:** Puede ser deshabilitado temporalmente con el comando `DISABLE TRIGGER aviso_influencer_extraño ON TablaMetricas;`.

## Seguridad
*   **Permisos:** Para crear o modificar el trigger se requieren permisos de `ALTER` sobre la tabla `TablaMetricas`. El usuario que realiza el `INSERT` no necesita permisos especiales sobre el trigger.
*   **Auditoría:** El trigger en sí mismo es una herramienta de auditoría. Su definición está almacenada en los metadatos de la base de datos.