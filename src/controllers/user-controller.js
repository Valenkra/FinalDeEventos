import { Router } from "express";
import StringHelper from "../helpers/string-helper.js";
import LogInHelper from "../helpers/login-helper.js";
import UserService from "../service/user_service.js";
import { MAXCHARS } from "../helpers/string-helper.js";
const router = Router();
const strHelp = new StringHelper();
const loginHelp = new LogInHelper();
const svc = new UserService();

// Login 
router.post("/login", async (req, res) => {
    res.setHeader('Content-Type', 'application/json');
    let STATUS = 400;

    const response = {
        username: null,
        password: null
    }

    let exitMsg = {
        success: null,
        message: null, 
        token: ""
    }

    for (const [key, value] of Object.entries(req.body)) {
        if(response[`${key}`] !== undefined){ 
            if(key === "username"){ if(strHelp.verifyEmail(value) === false){
                exitMsg["success"] = false;
                exitMsg["message"] = "El username ó email es invalido por su estructura.";
                res.status(400).json(exitMsg);
                break;
            } else response[`${key}`] = value}
            else response[`${key}`] = value};
    }


    let oneIsNull = false;
    for (const [key, value] of Object.entries(response)) {
        if(value === null) oneIsNull = true;
    }

    if(oneIsNull === false){
        const returnArray = await svc.logInAsync(strHelp.toLower(response["username"]), strHelp.toLower(response["password"]));
        if(returnArray.length !== 0){
            const token = await loginHelp.generarToken(strHelp.toLower(response["username"]), strHelp.toLower(response["password"]));
            exitMsg["success"] = true;
            exitMsg["token"] = `${token}`;
            STATUS = 200;
        }else{
            exitMsg["success"] = false;
            exitMsg["message"] = "Usuario o clave inválida.";
            STATUS = 401;
        }
    }else{
        exitMsg["success"] = false;
        exitMsg["message"] = "Faltan parametros.";
        STATUS = 400;
    }

    res.status(`${STATUS}`).json(exitMsg);
})

// Sign Up 
router.post("/register", async (req, res) => {
    const response = {
        first_name: null,
        last_name: null,
        username: null,
        password: null
    }

    for (const [key, value] of Object.entries(req.body)) {
        if(response[`${key}`] !== undefined) {
            if(strHelp.minChars(value) === true) {
                if(key === "username") if(strHelp.verifyEmail(value) === false){
                    res.setHeader('Content-Type', 'text/plain').status(400).send("BAD REQUEST: Username inválido por su estructura.");
                    break;
                }
                if(strHelp.maxChars(value) === true) {response[`${key}`] = value}
                else{
                    res.setHeader('Content-Type', 'text/plain').status(400).send(`BAD REQUEST: Todos los parametros pueden tener hasta ${MAXCHARS} caracteres.`);
                    break;
                }
            }
            else{
                res.setHeader('Content-Type', 'text/plain').status(400).send(`BAD REQUEST: ${key} debe contar con un minimo de 3 caracteres.`);
                break;
            }
        };
    }

    let oneIsNull = false;
    for (const [key, value] of Object.entries(response)) {
        if(value === null) oneIsNull = true;
    }

    if(!oneIsNull){
        let msg = await svc.registerAsync(
            strHelp.toLower(response["fist_name"]),
            strHelp.toLower(response["last_name"]),
            strHelp.toLower(response["username"]),
            strHelp.toLower(response["password"]));
        if(msg.length === 0) {res.setHeader('Content-Type', 'text/plain').status(201).send(`El usuario ha sido registrado con exito!`)}
        else {res.setHeader('Content-Type', 'text/plain').status(201).send(`${msg}`);}
    }else{
        res.setHeader('Content-Type', 'text/plain').status(400).send(`BAD REQUEST: Deben estar todos los parametros`);
    }
})

export default router;