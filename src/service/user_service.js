import UsersRepository from '../repositories/users_repository.js';
import { scrypt as scryptCallback, randomBytes, timingSafeEqual } from 'node:crypto';
import { promisify } from 'node:util';
const scrypt = promisify(scryptCallback);
async function hashPassword(password) {
  const salt = randomBytes(16).toString('hex');
  const hash = await scrypt(password, salt, 64);
  return `scrypt:${salt}:${hash.toString('hex')}`;
}
async function verifyPassword(password, stored) {
  if (typeof stored !== 'string' || !stored.startsWith('scrypt:')) return false;
  const [,salt,hex] = stored.split(':');
  if (!salt || !hex || !/^[a-f0-9]+$/i.test(hex)) return false;
  const original = Buffer.from(hex,'hex');
  const candidate = await scrypt(password,salt,original.length);
  return original.length === candidate.length && timingSafeEqual(original,candidate);
}
export default class UserService {
  registerAsync = async (firstName,lastName,username,password) => {
    const repo = new UsersRepository();
    if ((await repo.findExistingUserAsync(username)).length) return 'El usuario ya existe.';
    await repo.insertUserAsync(firstName,lastName,username,await hashPassword(password));
    return [];
  };
  logInAsync = async (username,password) => {
    const repo = new UsersRepository();
    const users = await repo.loginAsync(username);
    if (!users.length || !(await verifyPassword(password,users[0].password))) return [];
    return [{id:users[0].id,username:users[0].username}];
  };
  getIdAsync = async (username) => new UsersRepository().getUserIdByUsernameAndPasswordAsync(username);
}
