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
        }else{
            return res.setHeader('Content-Type', 'text/plain').status(401).send("Falta de token válido. Por favor, ingresá un token en el área de 'Authorization>Bearer Token'");
        }
    } 
    else{
        return res.setHeader('Content-Type', 'text/plain').status(401).send("Falta de token válido. Por favor, ingresá un token en el área de 'Authorization>Bearer Token'");
    }
    
})

// 4 Detalle de un evento
router.get("/:id", async (req, res) => {
    const id = req.params.id;  
    const validarId = validaciones.getIntegerOrDefault(id, -1);
    if(validarId === -1 || validarId <= 0){
        return res.setHeader('Content-Type', 'text/plain').status(400).send("El id debe ser un número positivo");
    }
    
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
        }else{
            return res.setHeader('Content-Type', 'text/plain').status(401).send("Falta de token válido. Por favor, ingresá un token en el área de 'Authorization>Bearer Token'");
        }
    } 
    else{
        return res.setHeader('Content-Type', 'text/plain').status(401).send("Falta de token válido. Por favor, ingresá un token en el área de 'Authorization>Bearer Token'");
    }
})

router.post("", async (req, res) => {
    let token = tokenHelper.extractToken(req.headers.authorization);
    if(token !== false){
        let payload = await tokenHelper.autenticarUsuario(token);
        if(payload["error"] === undefined){
            const response = {
                name: null,
                full_address: null,
                max_capacity: null,
                latitude: null,
                longitude: null,
                id_creator_user: payload["id"],
                id_location: null
            }
            
            const error = {
                error: null
            }        

            for (const [key, value] of Object.entries(req.body)) {
                if (key !== "id_creator_user") {
                    if(response[`${key}`] !== undefined){            
                        if(key === "full_address" || key === "name"){
                            if(str.minChars(value) === true && str.maxChars(value) === true) response[`${key}`] = value;
                            else{
                                error["error"] = `${key} debe tener entre 3 y 100 letras`;
                                return res.setHeader('Content-Type', 'application/json').status(400).json(error);
                            }
                        }else{
                            if((validaciones.getIntegerOrDefault(value, -1) === -1)){
                                error["error"] = `${key} debe ser un numero positivo.`;
                                return res.setHeader('Content-Type', 'application/json').status(400).json(error);
                            }else{
                                    response[`${key}`] = value;
                            }
                        }
                    }
                }
            }
                
            let oneIsNull = false;
            for (const [key, value] of Object.entries(response)) {
                if(value === null && key != "id") oneIsNull = true;
            }
            if(oneIsNull) {
                error["error"] = "Faltan parámetros. Revise el nombre de las KEYs";
                return res.setHeader('Content-Type', 'application/json').status(400).json(error);
            }else{
                    const returnMsg = await svc.createAsync(response);
                    if(returnMsg == ""){
                        return res.setHeader('Content-Type', 'application/json').status(200).send(`Evento creado con exito!`);
                    }else{
                        return res.setHeader('Content-Type', 'text/plain').status(404).send(`${returnMsg}`);
                    }
                }
            }else {
                return res.setHeader('Content-Type', 'text/plain').status(401).send("Falta de token válido. Por favor, ingresá un token en el área de 'Authorization>Bearer Token'");
            }
        } else{
            return res.setHeader('Content-Type', 'text/plain').status(401).send("Falta de token válido. Por favor, ingresá un token en el área de 'Authorization>Bearer Token'");
        }
})

router.put("", async (req, res) => {
    let token = tokenHelper.extractToken(req.headers.authorization);
    if(token !== false){
        let payload = await tokenHelper.autenticarUsuario(token);
        if(payload["error"] === undefined){
            const response = {
                name: null,
                full_address: null,
                max_capacity: null,
                latitude: null,
                longitude: null,
                id_creator_user: payload["id"],
                id_location: null,
                id: null
            }
            
            const error = {
                error: null
            }        

            for (const [key, value] of Object.entries(req.body)) {
                if (key !== "id_creator_user") {
                    if(response[`${key}`] !== undefined){            
                        if(key === "full_address" || key === "name"){
                            if(str.minChars(value) === true && str.maxChars(value) === true) response[`${key}`] = value;
                            else{
                                error["error"] = `${key} debe tener entre 3 y 100 letras`;
                                return res.setHeader('Content-Type', 'application/json').status(400).json(error);
                            }
                        }else{
                            if((validaciones.getIntegerOrDefault(value, -1) === -1)){
                                error["error"] = `${key} debe ser un numero positivo.`;
                                return res.setHeader('Content-Type', 'application/json').status(400).json(error);
                            }else{
                                    response[`${key}`] = value;
                            }
                        }
                    }
                }
            }
                
            let oneIsNull = false;
            for (const [key, value] of Object.entries(response)) {
                if(value === null && key != "id") oneIsNull = true;
            }

            const validarId = validaciones.getIntegerOrDefault(response["id"], -1);
            if(validarId === -1 || validarId <= 0){
                return res.setHeader('Content-Type', 'text/plain').status(400).send("El id debe ser un número positivo");
            }

            if(response["id"] === null){
                error["error"] = "Falta un ID válido.";
                return res.setHeader('Content-Type', 'application/json').status(400).json(error);
            }else{
                if(oneIsNull) {
                    error["error"] = "Faltan parámetros.";
                    return res.setHeader('Content-Type', 'application/json').status(400).json(error);
                }else{
                        let data = [];
                        for (const [key, value] of Object.entries(response)) {
                            if(value !== null && key != "id"){
                                if(key === "full_address" || key === "name"){
                                data.push(`${key}='${value}'`);}
                                else{
                                    data.push(`${key}=${value}`)
                                }
                            };
                        }
                        
                        data.push(`${response["id"]}`);

                        const returnMsg = await svc.updateAsync(data, payload);
                        if(returnMsg == ""){
                            return res.setHeader('Content-Type', 'application/json').status(200).send(`Evento actualizado con exito!`);
                        }else{
                            switch(returnMsg.split(":")[1].substring(1, 3)){
                                case 'ID':
                                    return res.setHeader('Content-Type', 'text/plain').status(404).send(`${returnMsg}`);
                                    break;
                                case 'No':
                                    return res.setHeader('Content-Type', 'text/plain').status(401).send(`${returnMsg}`);
                                    break;
                                default:
                                    return res.setHeader('Content-Type', 'text/plain').status(400).send(`${returnMsg}`);
                                    break;
                            }
                        }
                    }
                }
            }else {
                return res.setHeader('Content-Type', 'text/plain').status(401).send("Falta de token válido. Por favor, ingresá un token en el área de 'Authorization>Bearer Token'");
            }
        } else{
            return res.setHeader('Content-Type', 'text/plain').status(401).send("Falta de token válido. Por favor, ingresá un token en el área de 'Authorization>Bearer Token'");
        }
})

router.delete("/:id", async (req, res) => {
    const id = req.params.id;
    let token = tokenHelper.extractToken(req.headers.authorization);
    if(token !== false){
        let payload = await tokenHelper.autenticarUsuario(token);
        if(payload["error"] === undefined){
            const validarId = validaciones.getIntegerOrDefault(id, -1);
            if(validarId === -1 || validarId <= 0){
                return res.setHeader('Content-Type', 'text/plain').status(400).send("El id debe ser un número positivo");
            }

            const returnArray = await svc.deleteAsync(id, payload);
            if(returnArray == ""){
                res.setHeader('Content-Type', 'application/json').status(200).json("Se ha eliminado el evento con éxito");
            } else{
                switch(returnArray.split(":")[1].substring(1, 3)){
                    case 'ID':
                        return res.setHeader('Content-Type', 'text/plain').status(404).send(`${returnArray}`);
                        break;
                    case 'No':
                        return res.setHeader('Content-Type', 'text/plain').status(401).send(`${returnArray}`);
                        break;
                    default:
                        return res.setHeader('Content-Type', 'text/plain').status(400).send(`${returnArray}`);
                        break;
                }
            }
        }else {
            return res.setHeader('Content-Type', 'text/plain').status(401).send("Falta de token válido. Por favor, ingresá un token en el área de 'Authorization>Bearer Token'");
        }
    } else{
        return res.setHeader('Content-Type', 'text/plain').status(401).send("Falta de token válido. Por favor, ingresá un token en el área de 'Authorization>Bearer Token'");
    }
})


export default router;