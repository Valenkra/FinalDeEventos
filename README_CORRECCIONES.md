# FinalDeEventos — corrección de seguridad (parcial)

## Cómo arrancar
1. Instalar Node.js y PostgreSQL.
2. Copiar `.env.example` a `.env` y configurar DB_PASSWORD y un JWT_SECRET aleatorio de al menos 32 caracteres.
3. Ejecutar `npm install` y `npm start`.
4. Ejecutar `MIGRACION_PASSWORDS.sql` sobre una base existente.

## Cambios realizados
- Credenciales de base de datos y secreto JWT fuera del código.
- Login y registro con SQL parametrizado y contraseñas hasheadas mediante scrypt.
- JWT con id de usuario, sin contraseña en el token.
- Validación y respuestas de login/registro corregidas.
- Dependencias excluidas del ZIP y `.gitignore` añadido.
- Puerto configurable y middleware básico de errores.

## MUY IMPORTANTE: limitaciones y pendientes
Esta es una **corrección parcial**, NO una API completamente auditada ni lista para producción.
Las consultas SQL de otros repositorios todavía concatenan datos y pueden ser vulnerables a inyección SQL. También hay rutas y lógica de negocio con errores heredados. No desplegar públicamente antes de migrar todas las consultas a parámetros y ejecutar pruebas integrales.
Los filtros SQL dinámicos de UsersRepository ahora fallan explícitamente en lugar de ejecutar SQL arbitrario; ciertos endpoints de búsqueda e inscripciones pueden dejar de funcionar hasta completar esa migración.
Las cuentas anteriores con contraseña en texto plano NO pueden iniciar sesión con el nuevo sistema: hace falta restablecer contraseñas o migrarlas de forma segura. Rotar cualquier credencial real que haya sido expuesta en el repositorio original (incluyendo contraseña de PostgreSQL y clave JWT).
No se han realizado pruebas con una base de datos real.
