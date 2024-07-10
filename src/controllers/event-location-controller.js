import { Router } from "express";
import EventLocationsService from "../service/event-location_service.js";
import ValidacionesHelper from "../helpers/validaciones-helper.js"
import StringHelper from "../helpers/string-helper.js";
import TokenHelper from "../helpers/token-helper.js";
const router = Router();
const svc = new EventLocationsService();
const validaciones = new ValidacionesHelper();
const tokenHelper = new TokenHelper();
const str = new StringHelper();

// 3 Busqueda de un evento
router.get("", async (req, res) => {
    let token = tokenHelper.extractToken(req.headers.authorization);
    if(token !== false){
        let payload = await tokenHelper.autenticarUsuario(token);
        if(payload["error"] === undefined){
            const returnArray = await svc.getAllAsync();
            return res.setHeader('Content-Type', 'application/json').status(200).json(returnArray);
        }
    } 
    else{
        return res.setHeader('Content-Type', 'text/plain').status(404).send("Falta de token válido. Por favor, ingresá un token en el área de 'Authorization>Bearer Token'");
    }
    
})



// 4 Detalle de un evento
router.get("/:id", async (req, res) => {
    const id = req.params.id;
    let token = tokenHelper.extractToken(req.headers.authorization);
    if(token !== false){
        let payload = await tokenHelper.autenticarUsuario(token);
        if(payload["error"] === undefined){
            const returnArray = await svc.getByIdAsync(id);
            if(returnArray.length != 0){
                return res.setHeader('Content-Type', 'application/json').status(200).json(returnArray);
            }else{
                return res.setHeader('Content-Type', 'text/plain').status(404).send("No se encontró nada. Revisá las KEY o VALUES");
            }
        }
    } 
    else{
        return res.setHeader('Content-Type', 'text/plain').status(404).send("Falta de token válido. Por favor, ingresá un token en el área de 'Authorization>Bearer Token'");
    }
})


// Provincia especifica
router.post("", async (req, res) => { 
    const response = {
        name: null,
        full_name: null,
        latitude: null,
        longitude: null,
        display_order: null
    }

    const error = {
        error: null
    }

    for (const [key, value] of Object.entries(req.query)) {
        if(response[`${key}`] !== undefined) {
            if(key === "full_name" || key === "name"){
                if(str.minChars(value) === true && str.maxChars(value) === true) response[`${key}`] = value;
                else{
                    error["error"] = `${key} debe tener entre 3 y 100 letras`;
                    return res.setHeader('Content-Type', 'application/json').status(400).json(error);
                }
            }else{
                if(validaciones.getIntegerOrDefault(value, -1) === -1){
                    error["error"] = `${key} debe ser un numero.`;
                    return res.setHeader('Content-Type', 'application/json').status(400).json(error);
                }else{
                    response[`${key}`] = value;
                }
            }
        }
    }

    let oneIsNull = false;
    for (const [key, value] of Object.entries(response)) {
        if(value === null) oneIsNull = true;
    }

    if(oneIsNull) {
        error["error"] = "Faltan parámetros.";
        return res.setHeader('Content-Type', 'application/json').status(400).json(error);
    }else{
        const returnMsg = await svc.createAsync(response["name"], response["full_name"], response["latitude"], response["longitude"], response["display_order"]);
        if(returnMsg == ""){
            res.setHeader('Content-Type', 'application/json').status(200).send(`Event Location creada con exito!`);
        }else{
            res.setHeader('Content-Type', 'text/plain').status(404).send(`${returnMsg}`);
        }
    }
})

router.put("", async (req, res) => {
    const response = {
        name: null,
        full_name: null,
        latitude: null,
        longitude: null,
        display_order: null,
        id: null
    }

    const error = {
        error: null
    }

    for (const [key, value] of Object.entries(req.query)) {
        if(response[`${key}`] !== undefined) {
            if(key === "full_name" || key === "name"){
                if(str.minChars(value) === true && str.maxChars(value) === true) response[`${key}`] = value;
                else{
                    error["error"] = "Los strings deben tener entre 3 y 100 letras";
                    return res.setHeader('Content-Type', 'application/json').status(400).json(error);
                }
            }else{
                if(validaciones.getIntegerOrDefault(value, -1) === -1){
                    error["error"] = `${key} debe ser un numero.`;
                    return res.setHeader('Content-Type', 'application/json').status(400).json(error);
                }else{
                    response[`${key}`] = value;
                }
            }
        }
    }

    let oneIsTrue = false;
    for (const [key, value] of Object.entries(response)) {
        if(value !== null && key != "id") oneIsTrue = true;
    }

    if(response["id"] === null){
        error["error"] = "Falta un ID válido.";
        return res.setHeader('Content-Type', 'application/json').status(400).json(error);
    }else{
        if(!oneIsTrue) {
            error["error"] = "Faltan parámetros.";
            return res.setHeader('Content-Type', 'application/json').status(400).json(error);
        }else{
            let data = [];
            for (const [key, value] of Object.entries(response)) {
                if(value !== null && key != "id"){
                    if(key === "full_name" || key === "name"){
                    data.push(`${key}='${value}'`);}
                    else{
                        data.push(`${key}=${value}`)
                    }
                };
            }

            data.push(`${response["id"]}`);

            const returnMsg = await svc.updateByIdAsync(data);
            if(returnMsg == ""){
                res.setHeader('Content-Type', 'application/json').status(200).send(`Event Location actualizada con exito!`);
            }else{
                res.setHeader('Content-Type', 'text/plain').status(404).send(`${returnMsg}`);
            }
        }
    }
})


router.delete("/:id", async (req, res) => {
    const id = req.params.id;
    const returnMsg = await svc.deleteByIdAsync(id);
    if(returnMsg == ""){
        res.setHeader('Content-Type', 'application/json').status(200).send(`Event Location eliminada con exito!`);
    }else{
        res.setHeader('Content-Type', 'text/plain').status(404).send(`${returnMsg}`);
    }
})


export default router;