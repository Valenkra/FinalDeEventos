import { Router } from 'express';
import LogInHelper from '../helpers/login-helper.js';
import UserService from '../service/user_service.js';
const router = Router();
const svc = new UserService();
const auth = new LogInHelper();
router.post('/register', async (req,res,next) => {
  try {
    const {first_name,last_name,username,password} = req.body || {};
    if (![first_name,last_name,username,password].every(v => typeof v === 'string' && v.trim().length >= 3 && v.length <= 100)) return res.status(400).json({success:false,message:'Datos incompletos o inválidos'});
    if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(username)) return res.status(400).json({success:false,message:'Email inválido'});
    const result = await svc.registerAsync(first_name.trim(),last_name.trim(),username.trim().toLowerCase(),password);
    if (typeof result === 'string') return res.status(409).json({success:false,message:result});
    return res.status(201).json({success:true,message:'Usuario registrado'});
  } catch(e) { next(e); }
});
router.post('/login', async (req,res,next) => {
  try {
    const {username,password} = req.body || {};
    if (typeof username !== 'string' || typeof password !== 'string' || !username || !password) return res.status(400).json({success:false,message:'Faltan parámetros'});
    const users = await svc.logInAsync(username.trim().toLowerCase(),password);
    if (!users.length) return res.status(401).json({success:false,message:'Usuario o clave inválida'});
    const token = await auth.generarToken(users[0].id,users[0].username);
    return res.status(200).json({success:true,token});
  } catch(e) { next(e); }
});
export default router;
