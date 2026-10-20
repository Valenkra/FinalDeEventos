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
