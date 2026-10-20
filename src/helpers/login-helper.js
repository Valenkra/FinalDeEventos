import jwt from 'jsonwebtoken';
import 'dotenv/config';

function secret() {
  const value = process.env.JWT_SECRET;
  if (!value || value.length < 32) throw new Error('JWT_SECRET debe tener al menos 32 caracteres');
  return value;
}
export default class LogInHelper {
  generarToken = async (userId, username) => jwt.sign(
    { sub: String(userId), username }, secret(), { expiresIn: '2h', issuer: 'FinalDeEventos' }
  );
  desencriptarToken = async (token) => {
    try { return jwt.verify(token, secret(), { issuer: 'FinalDeEventos' }); }
    catch { return { error: 'Token inválido o vencido' }; }
  };
}
