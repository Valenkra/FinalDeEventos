import { Router } from "express";
import EventService from "../service/event_service.js";
import TokenHelper from "../helpers/token-helper.js";
import StringHelper from "../helpers/string-helper.js";
import ValidacionesHelper from "../helpers/validaciones-helper.js";
const router = Router();
const svc = new EventService();
const tokenHelper = new TokenHelper();
const str = new StringHelper();
const validaciones = new ValidacionesHelper();

// 3 Busqueda de un evento
router.get("", async (req, res) => {
    const response = {
        name: null,
        category: null,
        stardate: null,
        tag: null
    }

    let temp = 0;

    for (const [key, value] of Object.entries(req.query)) {
        if(response[`${key}`] !== undefined) response[`${key}`] = value;
        else temp++;
    }

    if(temp === Object.keys(req.query).length || Object.keys(req.query).length === 0){
        const returnArray = await svc.getAllAsync();
        return res.setHeader('Content-Type', 'application/json').status(200).json(returnArray);
    }else{
        let querys = [];
        for (const [key, value] of Object.entries(response)) {
            let prefijo = "";
            let myKey;
            if(value !== null) {
                switch(key){
                    case 'name':
                        prefijo = "E";
                        break;
                    case 'category':
                        prefijo = "EC";
                        break;
                    case 'startdate':
                        prefijo = "E";
                        break;
                    case 'tag':
                        prefijo = "TT";
                        break;
                }
                myKey = (key === "category" || key === "tag") ? "name" : key;
                myKey = (key === "startdate") ? "start_date": myKey;
                querys.push(`${prefijo}.${myKey} = '${value}'`);
            }
        }
        const returnArray = await svc.getWithConditionAsync(querys);
        if(typeof returnArray !== null){
            if(returnArray.length !== 0) res.setHeader('Content-Type', 'application/json').status(200).json(returnArray);
            else res.setHeader('Content-Type', 'text/plain').status(404).send("No se encontró nada. Revisá las KEY o VALUES");
        } else{
            res.setHeader('Content-Type', 'text/plain').status(404).send("No se encontró nada. Revisá las KEY o VALUES");
        }
    }
});

// 4 Detalle de un evento
router.get("/:id", async (req, res) => {
    const id = req.params.id;
    const returnArray = await svc.getByIdAsync(id);
    if(returnArray !== null){
        res.setHeader('Content-Type', 'application/json').status(200).json(returnArray);
    } else{
        res.setHeader('Content-Type', 'text/plain').status(404).send("No se encontró nada. Revisá las KEY o VALUES");
    }
});

// 5 Listado de participantes
router.get("/:id/enrollment", async (req, res) => {
    const id = req.params.id;

    const response = {
        first_name: null,
        last_name: null,
        username: null,
        attended: null,
        rating: null
    }

    let temp = 0;

    for (const [key, value] of Object.entries(req.query)) {
        if(response[`${key}`] !== undefined) response[`${key}`] = value;
        else temp++;
    }

    if(temp === Object.keys(req.query).length || Object.keys(req.query).length === 0){
        const returnArray = await svc.getAllAsync();
        return res.setHeader('Content-Type', 'application/json').status(200).json(returnArray);
    }else{
        let querys = [];
        for (const [key, value] of Object.entries(response)) {
            let prefijo = "";
            if(value !== null) {
                switch(key){
                    case 'first_name':
                        prefijo = "U";
                        break;
                    case 'last_name':
                        prefijo = "U";
                        break;
                    case 'username':
                        prefijo = "U";
                        break;
                    case 'attended':
                        prefijo = "EE";
                        break;
                    case 'rating':
                        rating = "EE";
                        break;
                }
                if(key !== 'rating') querys.push(`${prefijo}.${key} = '${value}'`);
                else querys.push(`${prefijo}.${key} = ${value}`)
            }
        }
        const returnArray = await svc.getEnrollmentDetailsAsync(id, querys);
        if(typeof returnArray !== null){
            res.setHeader('Content-Type', 'application/json').status(200).json(returnArray);
        } else{
            res.setHeader('Content-Type', 'text/plain').status(404).send("No se encontró nada. Revisá las KEY o VALUES");
        }
    }
});

router.post("", async (req, res) => {
    console.log("hola")
    let token = tokenHelper.extractToken(req.headers.authorization);
    if(token !== false){
        console.log(token)
        let payload = await tokenHelper.autenticarUsuario(token);
        if(payload["error"] === undefined){
            const response = {
                name: null,
                description: null,
                id_event_category: null,
                start_date: null,
                duration_in_minutes: null,
                price: null,
                enabled_for_enrollment: null,
                max_assistance: null,
                id_creator_user: payload["id"], 
                id_event_location: null
            }
            
            const error = {
                error: null
            }        

            for (const [key, value] of Object.entries(req.query)) {
                if (key !== "id_creator_user") {
                    if(response[`${key}`] !== undefined){            
                        if(key === "description" || key === "name"){
                            if(str.minChars(value) === true && str.maxChars(value) === true) response[`${key}`] = value;
                            else{
                                error["error"] = `${key} debe tener entre 3 y 100 letras`;
                                return res.setHeader('Content-Type', 'application/json').status(400).json(error);
                            }
                        }else{
                            if((validaciones.getIntegerOrDefault(value, -1) === -1 || validaciones.getIntegerOrDefault(value, -1) <= 0) && key !== "enabled_for_enrollment"){
                                error["error"] = `${key} debe ser un numero positivo.`;
                                return res.setHeader('Content-Type', 'application/json').status(400).json(error);
                            }else{
                                if(value != "true" && value != "false" && key === "enabled_for_enrollment"){
                                    error["error"] = `${key} debe ser un booleano.`;
                                    return res.setHeader('Content-Type', 'application/json').status(200).json(error);
                                }else{
                                    response[`${key}`] = value;
                                }
                            }
                        }
                    }
                }
            }

            console.log("llegue");
                
            let oneIsNull = false;
            for (const [key, value] of Object.entries(response)) {
                if(value === null) oneIsNull = true;
            }

            if(oneIsNull) {
                error["error"] = "Faltan parámetros.";
                return res.setHeader('Content-Type', 'application/json').status(400).json(error);
            }else{
                    const returnMsg = await svc.createAsync(response);
                    if(returnMsg == ""){
                        return res.setHeader('Content-Type', 'application/json').status(200).send(`Provincia actualizada con exito!`);
                    }else{
                        return res.setHeader('Content-Type', 'text/plain').status(404).send(`${returnMsg}`);
                    }
                }
            }else {
                return res.setHeader('Content-Type', 'text/plain').status(404).send("Falta de token válido. Por favor, ingresá un token en el área de 'Authorization>Bearer Token'");
            }
        } else{
            return res.setHeader('Content-Type', 'text/plain').status(404).send("Falta de token válido. Por favor, ingresá un token en el área de 'Authorization>Bearer Token'");
        }
})

router.put("", async (req, res) => {
    console.log("hola")
    let token = tokenHelper.extractToken(req.headers.authorization);
    if(token !== false){
        console.log(token)
        let payload = await tokenHelper.autenticarUsuario(token);
        if(payload["error"] === undefined){
            const response = {
                name: null,
                description: null,
                id_event_category: null,
                start_date: null,
                duration_in_minutes: null,
                price: null,
                enabled_for_enrollment: null,
                max_assistance: null,
                id_creator_user: payload["id"], 
                id_event_location: null
            }
            
            const error = {
                error: null
            }        

            for (const [key, value] of Object.entries(req.query)) {
                if (key !== "id_creator_user") {
                    if(response[`${key}`] !== undefined){            
                        if(key === "description" || key === "name"){
                            if(str.minChars(value) === true && str.maxChars(value) === true) response[`${key}`] = value;
                            else{
                                error["error"] = `${key} debe tener entre 3 y 100 letras`;
                                return res.setHeader('Content-Type', 'application/json').status(400).json(error);
                            }
                        }else{
                            if((validaciones.getIntegerOrDefault(value, -1) === -1 || validaciones.getIntegerOrDefault(value, -1) <= 0) && key !== "enabled_for_enrollment"){
                                error["error"] = `${key} debe ser un numero positivo.`;
                                return res.setHeader('Content-Type', 'application/json').status(400).json(error);
                            }else{
                                if(value != "true" && value != "false" && key === "enabled_for_enrollment"){
                                    error["error"] = `${key} debe ser un booleano.`;
                                    return res.setHeader('Content-Type', 'application/json').status(200).json(error);
                                }else{
                                    response[`${key}`] = value;
                                }
                            }
                        }
                    }
                }
            }

            console.log("llegue");
                
            let oneIsNull = false;
            for (const [key, value] of Object.entries(response)) {
                if(value === null) oneIsNull = true;
            }

            if(oneIsNull) {
                error["error"] = "Faltan parámetros.";
                return res.setHeader('Content-Type', 'application/json').status(400).json(error);
            }else{
                    let data = [];
                    for (const [key, value] of Object.entries(response)) {
                        if(value !== null && key != "id"){
                            if(key === "description" || key === "name"){
                            data.push(`${key}='${value}'`);}
                            else{
                                data.push(`${key}=${value}`)
                            }
                        };
                    }
                    const returnMsg = await svc.createAsync(data)
                    if(returnMsg == ""){
                        return res.setHeader('Content-Type', 'application/json').status(200).send(`Provincia actualizada con exito!`);
                    }else{
                        return res.setHeader('Content-Type', 'text/plain').status(404).send(`${returnMsg}`);
                    }
                }
            }else {
                return res.setHeader('Content-Type', 'text/plain').status(404).send("Falta de token válido. Por favor, ingresá un token en el área de 'Authorization>Bearer Token'");
            }
        } else{
            return res.setHeader('Content-Type', 'text/plain').status(404).send("Falta de token válido. Por favor, ingresá un token en el área de 'Authorization>Bearer Token'");
        }
})

router.delete("/:id", async (req, res) => {

})

router.post("/:id/enrollment", async (req, res) => {

})

router.delete("/:id/enrollment", async (req, res) => {

})

router.patch("/:id/enrollment", async (req, res) => {
    
})

export default router;