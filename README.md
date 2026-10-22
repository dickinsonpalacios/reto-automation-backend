# Reto de automatización QA – Backend

Suite de pruebas de la API de usuarios de [ServeRest](https://serverest.dev/) con **Karate DSL**, **JUnit 5** y **Maven**.

## Requisitos

- Java 17 o superior (`java -version`)
- Maven 3.9+ (`mvn -version`)
- Acceso de red a ServeRest (o instancia local)

## Ejecutar

```bash
mvn clean test
```

Cambiar la URL base:

```bash
mvn test -DbaseUrl=http://localhost:3000
```

El reporte HTML queda en `target/karate-reports/karate-summary.html`. Los resultados JUnit XML quedan en `target/surefire-reports/`.

## Organización

```text
src/test/java/
  karate-config.js                 URL base y timeouts
  runner/UsuariosTest.java        Entrada a la suite
  usuarios/                       Un feature por endpoint
    01-listar.feature              GET /usuarios
    02-registrar.feature           POST /usuarios
    03-buscar-por-id.feature       GET /usuarios/{_id}
    04-actualizar.feature          PUT /usuarios/{_id}
    05-eliminar.feature            DELETE /usuarios/{_id}
  helpers/
    nuevo-usuario.js               Datos únicos por escenario
    crear-usuario.feature          Preparación reutilizable
    borrar-usuario.feature         Limpieza reutilizable
  schemas/
    usuario.js                     Esquema del objeto listado
```

## Qué se cubre

| Endpoint | Positivos | Negativos / borde |
| --- | --- | --- |
| GET /usuarios | lista y filtro por correo | lista cambiante, sin fijar número |
| POST /usuarios | alta y lectura posterior | email duplicado, formato inválido |
| GET /usuarios/{_id} | usuario recién creado | ID inexistente |
| PUT /usuarios/{_id} | modificación y persistencia | ID inexistente crea un usuario (comportamiento particular) |
| DELETE /usuarios/{_id} | borrado y ausencia posterior | segundo caso sin registro |

## Solución de problemas

- `mvn: command not found`: instalar Maven y configurarlo en PATH.
- Error de conexión: verificar `https://serverest.dev` y la red.
- HTTP inesperado: revisar el cuerpo de respuesta en el reporte antes de cambiar aserciones.