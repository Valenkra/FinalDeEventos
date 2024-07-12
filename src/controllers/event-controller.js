import { Router } from "express";
import EventService from "../service/event_service.js";
import EventEnrollmentService from "../service/event-enrollment_service.js";
import TokenHelper from "../helpers/token-helper.js";
import StringHelper from "../helpers/string-helper.js";
import ValidacionesHelper from "../helpers/validaciones-helper.js";
const router = Router();
const svc = new EventService();
const enrollment_svc = new EventEnrollmentService();
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

    const error = {
        error: null
    };

    for (const [key, value] of Object.entries(req.query)) {
        if(response[`${key}`] !== undefined){  
            if(key === "name" || key === "category" || key === "tag"){
                if(str.minChars(value) === true && str.maxChars(value) === true) response[`${key}`] = value;
                else{
                    return res.setHeader('Content-Type', 'text/plain').status(404).send(`${key} debe tener entre 3 y 100 letras`);
                }
            }else{
                if(key === "startdate" && str.verifyDate(value) === true) response[`${key}`] = value;
                else{
                    return res.setHeader('Content-Type', 'text/plain').status(404).send("La fecha debe estar en formato 'YYYY/MM/DD'");
                }
            }
        }
    }

    let oneIsTrue = false;
    for (const [key, value] of Object.entries(response)) {
        if(value !== null) oneIsTrue = true;
    }
    
    let querys = [];
    if(oneIsTrue){
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
            if(returnArray.length !== 0) return res.setHeader('Content-Type', 'application/json').status(200).json(returnArray);
            else return res.setHeader('Content-Type', 'text/plain').status(404).send("No se encontró nada. Revisá las KEY o VALUES");
        } else{
            return res.setHeader('Content-Type', 'text/plain').status(404).send("No se encontró nada. Revisá las KEY o VALUES");
        }   
    }else{
        const returnArray = await svc.getAllAsync();
        if(typeof returnArray !== null && returnArray.length != 0){
            return res.setHeader('Content-Type', 'application/json').status(200).json(returnArray);
        } else{
            return res.setHeader('Content-Type', 'text/plain').status(404).send("No se encontró nada. Revisá las KEY o VALUES");
        }  
    }
});

// 4 Detalle de un evento
router.get("/:id", async (req, res) => {
    const id = req.params.id;  
    const validarId = validaciones.getIntegerOrDefault(id, -1);
    if(validarId === -1 || validarId <= 0){
        return res.setHeader('Content-Type', 'text/plain').status(400).send("El id debe ser un número positivo");
    }
    
    const returnArray = await svc.getByIdAsync(id);
    if(returnArray !== null && returnArray.length != 0){
        res.setHeader('Content-Type', 'application/json').status(200).json(returnArray);
    } else{
        res.setHeader('Content-Type', 'text/plain').status(404).send("BAD REQUEST: El ID no existe.");
    }
});

// 5 Listado de participantes
router.get("/:id/enrollment", async (req, res) => {
    const id = req.params.id;  
    const validarId = validaciones.getIntegerOrDefault(id, -1);
    if(validarId === -1 || validarId <= 0){
        return res.setHeader('Content-Type', 'text/plain').status(400).send("El id debe ser un número positivo");
    }
    

    const response = {
        first_name: null,
        last_name: null,
        username: null,
        attended: null,
        rating: null
    }

    for (const [key, value] of Object.entries(req.query)) {
        if(response[`${key}`] !== undefined){ 
            if(key === "username"){ 
                if(str.verifyEmail(value) === false){
                    return res.setHeader('Content-Type', 'text/plain').status(404).send("El username ó email es invalido por su estructura.");
                }else {response[`${key}`] = value}
            } else {     
                if(key === "first_name" || key === "last_name"){
                    if(str.minChars(value) === true && str.maxChars(value) === true) response[`${key}`] = value;
                    else{
                        error["error"] = `${key} debe tener entre 3 y 100 letras`;
                        return res.setHeader('Content-Type', 'application/json').status(400).json(error);
                    }
                }else{
                    if((validaciones.getIntegerOrDefault(value, -1) === -1 || validaciones.getIntegerOrDefault(value, -1) <= 0) && key !== "attended"){
                        error["error"] = `${key} debe ser un numero positivo.`;
                        return res.setHeader('Content-Type', 'application/json').status(400).json(error);
                    }else{
                        if(value != "true" && value != "false" && key === "attended"){
                            error["error"] = `${key} debe ser un booleano.`;
                            return res.setHeader('Content-Type', 'application/json').status(400).json(error);
                        }else{
                            response[`${key}`] = value;
                        }
                    }
                }
            }
            
        }
    }

    let oneIsTrue = false;
    for (const [key, value] of Object.entries(response)) {
        if(value !== null) oneIsTrue = true;
    }

    
    let querys = [];
    if(oneIsTrue){
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
                        prefijo = "EE";
                        break;
                }
                if(key !== 'rating') querys.push(`${prefijo}.${key} = '${value}'`);
                else querys.push(`${prefijo}.${key} = ${value}`)
            }
        }
    }

    const returnArray = await svc.getEnrollmentDetailsAsync(id, querys);
    if(typeof returnArray !== null && returnArray.length != 0){
        res.setHeader('Content-Type', 'application/json').status(200).json(returnArray);
    } else{
        res.setHeader('Content-Type', 'text/plain').status(404).send("No se encontró ningun user.");
    }
});

router.post("", async (req, res) => {
    let token = tokenHelper.extractToken(req.headers.authorization);
    if(token !== false){
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

            for (const [key, value] of Object.entries(req.body)) {
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
                                if(value != true && value != false && key === "enabled_for_enrollment"){
                                    error["error"] = `${key} debe ser un booleano.`;
                                    return res.setHeader('Content-Type', 'application/json').status(400).json(error);
                                }else{
                                    response[`${key}`] = value;
                                }
                            }
                        }
                    }
                }
            }

                
            let oneIsNull = false;
            for (const [key, value] of Object.entries(response)) {
                if(value === null) {oneIsNull = true; };
            }

            if(oneIsNull) {
                error["error"] = "Faltan parámetros.";
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
                description: null,
                id_event_category: null,
                start_date: null,
                duration_in_minutes: null,
                price: null,
                enabled_for_enrollment: null,
                max_assistance: null,
                id_creator_user: payload["id"], 
                id_event_location: null,
                id: null
            }
            
            const error = {
                error: null
            }        

            for (const [key, value] of Object.entries(req.body)) {
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
                                if(value != true && value != false && key === "enabled_for_enrollment"){
                                    error["error"] = `${key} debe ser un booleano.`;
                                    return res.setHeader('Content-Type', 'application/json').status(400).json(error);
                                }else{
                                    response[`${key}`] = value;
                                }
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
                                if(key === "description" || key === "name" || key === "start_date"){
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
        const validarId = validaciones.getIntegerOrDefault(id, -1);
        let payload = await tokenHelper.autenticarUsuario(token);
        if(payload["error"] === undefined){

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

router.post("/:id/enrollment", async (req, res) => {
    const id = req.params.id;
    
    const validarId = validaciones.getIntegerOrDefault(id, -1);
    if(validarId === -1 || validarId <= 0){
        return res.setHeader('Content-Type', 'text/plain').status(400).send("El id debe ser un número positivo");
    }

    let token = tokenHelper.extractToken(req.headers.authorization);
    if(token !== false){
        let payload = await tokenHelper.autenticarUsuario(token);
        if(payload["error"] === undefined){
            const returnMsg = await svc.inscribirUsuario(id, payload);
            if(returnMsg == "" || returnMsg === null){
                res.setHeader('Content-Type', 'application/json').status(200).json("¡Felicidades! Ahora estas inscripto al evento.");
            } else{
                switch(returnMsg.split(":")[1].substring(1, 3)){
                    case 'ID':
                        return res.setHeader('Content-Type', 'text/plain').status(404).send(`${returnMsg}`);
                        break;
                    default:
                        return res.setHeader('Content-Type', 'text/plain').status(400).send(`${returnMsg}`);
                        break;
                }
            }
        }else {
            return res.setHeader('Content-Type', 'text/plain').status(401).send("Falta de token válido. Por favor, ingresá un token en el área de 'Authorization>Bearer Token'");
        }
    }else {
        return res.setHeader('Content-Type', 'text/plain').status(401).send("Falta de token válido. Por favor, ingresá un token en el área de 'Authorization>Bearer Token'");
    }
        
})

router.delete("/:id/enrollment", async (req, res) => {
    const id = req.params.id;    
    const validarId = validaciones.getIntegerOrDefault(id, -1);
    if(validarId === -1 || validarId <= 0){
        return res.setHeader('Content-Type', 'text/plain').status(400).send("El id debe ser un número positivo");
    }

    let token = tokenHelper.extractToken(req.headers.authorization);
    if(token !== false){
        let payload = await tokenHelper.autenticarUsuario(token);
        if(payload["error"] === undefined){
            const returnMsg = await svc.eliminarUsuario(id, payload);
            if(returnMsg == "" || returnMsg === null){
                res.setHeader('Content-Type', 'application/json').status(200).json("Enhorabuena, te hemos sacado del evento.");
            } else{
                switch(returnMsg.split(":")[1].substring(1, 3)){
                    case 'ID':
                        return res.setHeader('Content-Type', 'text/plain').status(404).send(`${returnMsg}`);
                        break;
                    default:
                        return res.setHeader('Content-Type', 'text/plain').status(400).send(`${returnMsg}`);
                        break;
                }
            }
        }else {
            return res.setHeader('Content-Type', 'text/plain').status(401).send("Falta de token válido. Por favor, ingresá un token en el área de 'Authorization>Bearer Token'");
        }
    }else {
        return res.setHeader('Content-Type', 'text/plain').status(401).send("Falta de token válido. Por favor, ingresá un token en el área de 'Authorization>Bearer Token'");
    }
})

router.patch("/:id/enrollment/:rating", async (req, res) => {
    const id = req.params.id;
    const rating = req.params.id;   
    const validarId = validaciones.getIntegerOrDefault(id, -1);
    if(validarId === -1 || validarId <= 0){
        return res.setHeader('Content-Type', 'text/plain').status(400).send("El id debe ser un número positivo");
    }
    
    const validarRating = validaciones.getIntegerOrDefault(rating, -1);
    if(validarRating === -1 || validarRating <= 0 || validarRating > 10){
        return res.setHeader('Content-Type', 'text/plain').status(400).send("El rating debe ser un número entre 1 y 10");
    }

    let token = tokenHelper.extractToken(req.headers.authorization);
    if(token !== false){
        let payload = await tokenHelper.autenticarUsuario(token);
        if(payload["error"] === undefined){
            const response = {
                observations: null
            }
            
            const error = {
                error: null
            }        

            for (const [key, value] of Object.entries(req.body)) {
                if(response[`${key}`] !== undefined){            
                    if(str.minChars(value) === true && str.maxChars(value) === true) response[`${key}`] = value;
                    else{
                        error["error"] = `${key} debe tener entre 3 y 100 letras`;
                        return res.setHeader('Content-Type', 'application/json').status(400).json(error);
                    }   
                }
            }

            if(validaciones.getIntegerOrDefault(rating, -1) <= 0 &&
            validaciones.getIntegerOrDefault(rating, -1) > 10){
                error["error"] = `El rating debe ser un número del 1 al 10`;
                return res.setHeader('Content-Type', 'application/json').status(400).json(error);
            }

            let oneIsNull = false;
            for (const [key, value] of Object.entries(response)) {
                if(value === null && key != "id") oneIsNull = true;
            }

            const data = [id, payload, rating, `, observations= ${response["observations"]}`, oneIsNull];

            const returnMsg = await enrollment_svc.updateRating(data);
            if(returnMsg == "" || returnMsg === null){
                res.setHeader('Content-Type', 'application/json').status(200).json("Enhorabuena, hemos actualizado del evento.");
            } else{
                switch(returnMsg.split(":")[1].substring(1, 3)){
                    case 'ID':
                        return res.setHeader('Content-Type', 'text/plain').status(404).send(`${returnMsg}`);
                        break;
                    default:
                        return res.setHeader('Content-Type', 'text/plain').status(400).send(`${returnMsg}`);
                        break;
                }
            }

        }else {
            return res.setHeader('Content-Type', 'text/plain').status(401).send("Falta de token válido. Por favor, ingresá un token en el área de 'Authorization>Bearer Token'");
        }
    }else {
        return res.setHeader('Content-Type', 'text/plain').status(401).send("Falta de token válido. Por favor, ingresá un token en el área de 'Authorization>Bearer Token'");
    }
})

export default router;