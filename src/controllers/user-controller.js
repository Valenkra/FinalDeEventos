import { Router } from "express";
const router = Router();
import StringHelper from "../helpers/string-helper.js";
const strHelp = new StringHelper();

// Login 
router.post("/login", (req, res) => {
    const response = {
        username: null,
        password: null
    }

    for (const [key, value] of Object.entries(req.query)) {
        if(response[`${key}`] !== undefined) response[`${key}`] = value;
    }
    res.status(200).send("llegue");
})

// Sign Up 
router.post("/register", (req, res) => {
    const response = {
        fist_name: null,
        last_name: null,
        username: null,
        password: null
    }

    for (const [key, value] of Object.entries(req.query)) {
        if(response[`${key}`] !== undefined) {
            if(strHelp.minChars(value) === true) {
                if(key === "username") if(strHelp.verifyEmail(value) === false){
                    res.setHeader('Content-Type', 'text/plain').status(400).send("BAD REQUEST: Username inválido por su estructura.");
                    break;
                }
                response[`${key}`] = value;
            }
            else{
                res.setHeader('Content-Type', 'text/plain').status(400).send("BAD REQUEST: Todos los parametros deben contar con un minimo de 3 caracteres.");
                break;
            }
        };
    }

    const oneIsNull = false;
    for (const [key, value] of Object.entries(response)) {
        if(typeof value === null) oneIsNull = true;
    }

    if(!oneIsNull){
        
    }

})





export default router;