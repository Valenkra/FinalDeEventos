import LogInHelper from './login-helper.js';
const helper = new LogInHelper();
export default class TokenHelper {
  extractToken = (header) => {
    if (typeof header !== 'string') return false;
    const match = /^Bearer\s+(\S+)$/i.exec(header.trim());
    return match ? match[1] : false;
  };
  autenticarUsuario = async (token) => {
    const payload = await helper.desencriptarToken(token);
    if (payload.error) return payload;
    const id = Number(payload.sub);
    if (!Number.isSafeInteger(id) || id < 1) return { error: 'Token inválido' };
    return { username: payload.username, id };
  };
}
