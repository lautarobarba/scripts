# Diseño: listado resumido de contenedores Docker

## Objetivo

Crear `docker_container_ls.sh` para presentar todos los contenedores Docker con
las columnas `NAME`, `IMAGE`, `CREATED`, `STATUS` y `PORTS`, omitiendo el ID y
el comando.

## Comportamiento

- Ejecuta `docker container ls -a` para incluir contenedores detenidos.
- Usa el formato estructurado de Docker, no el texto de salida por defecto.
- Conserva el nombre, imagen, antigüedad de creación y estado proporcionados
  por Docker.
- Normaliza los puertos:
  - Un puerto publicado se expresa como `host->contenedor` (por ejemplo,
    `8000->8080`).
  - Un puerto expuesto sin publicación en el host se expresa como
    `X->contenedor` (por ejemplo, `X->80`).
  - Varios puertos se separan con `, `.
  - Sin puertos se muestra `X`.

## Errores y compatibilidad

- Requiere el cliente de Docker, el comando `column` y acceso al daemon
  configurado en el entorno.
- Si Docker devuelve un error, el script conserva ese error y finaliza con un
  código distinto de cero.

## Pruebas

- Pruebas de formato con salida simulada de Docker: puerto publicado, puerto
  sólo expuesto, combinación de ambos y ausencia de puertos.
- Prueba de integración opcional cuando Docker esté disponible.
