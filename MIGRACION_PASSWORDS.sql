-- Ejecutar antes de registrar usuarios con el nuevo hash scrypt.
ALTER TABLE public.users ALTER COLUMN password TYPE varchar(255);
-- Las contraseñas antiguas en texto plano no pueden autenticarse con la nueva versión.
-- Requieren restablecimiento seguro; NO se recomienda mantener compatibilidad con texto plano.
