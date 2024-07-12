import { Router } from "express";
import EventCategoryService from "../service/event-category_service.js";
import ValidacionesHelper from "../helpers/validaciones-helper.js"
import StringHelper from "../helpers/string-helper.js";
const router = Router();
const svc = new EventCategoryService();
const validaciones = new ValidacionesHelper();
const str = new StringHelper();

// 3 Busqueda de un evento
router.get("", async (req, res) => {
    const returnArray = await svc.getAllAsync();
    res.setHeader('Content-Type', 'application/json').status(200).json(returnArray);
})

// 4 Detalle de un evento
router.get("/:id", async (req, res) => {
    const id = req.params.id;  
    const validarId = validaciones.getIntegerOrDefault(id, -1);
    if(validarId === -1 || validarId <= 0){
        return res.setHeader('Content-Type', 'text/plain').status(400).send("El id debe ser un número positivo");
    }
    
    const returnArray = await svc.getByIdAsync(id);
    if(returnArray.length != 0){
        res.setHeader('Content-Type', 'application/json').status(200).json(returnArray);
    }else{
        res.setHeader('Content-Type', 'text/plain').status(404).send("No se encontró nada. Revisá las KEY o VALUES");
    }
})

// Provincia especifica
router.post("", async (req, res) => { 
    const response = {
        name: null,
        display_order: null
    }

    const error = {
        error: null
    }

    for (const [key, value] of Object.entries(req.body)) {
        if(response[`${key}`] !== undefined) {
            if(key === "name"){
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
        const returnMsg = await svc.createAsync(response["name"], response["display_order"]);
        if(returnMsg == ""){
            res.setHeader('Content-Type', 'application/json').status(200).send(`Event Category creada con exito!`);
        }else{
            res.setHeader('Content-Type', 'text/plain').status(404).send(`${returnMsg}`);
        }
    }
})

router.put("", async (req, res) => {
    const response = {
        name: null,
        display_order: null,
        id: null
    }

    const error = {
        error: null
    }

    for (const [key, value] of Object.entries(req.body)) {
        if(response[`${key}`] !== undefined) {
            if(key === "name"){
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

    const validarId = validaciones.getIntegerOrDefault(response["id"], -1);
    if(validarId === -1 || validarId <= 0){
        return res.setHeader('Content-Type', 'text/plain').status(400).send("El id debe ser un número positivo");
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
                    if(key === "name"){
                    data.push(`${key}='${value}'`);}
                    else{
                        data.push(`${key}=${value}`)
                    }
                };
            }

            data.push(`${response["id"]}`);

            const returnMsg = await svc.updateByIdAsync(data);
            if(returnMsg == ""){
                res.setHeader('Content-Type', 'application/json').status(200).send(`Event Category actualizada con exito!`);
            }else{
                res.setHeader('Content-Type', 'text/plain').status(404).send(`${returnMsg}`);
            }
        }
    }
})


router.delete("/:id", async (req, res) => {
    const id = req.params.id;  
    const validarId = validaciones.getIntegerOrDefault(id, -1);
    if(validarId === -1 || validarId <= 0){
        return res.setHeader('Content-Type', 'text/plain').status(400).send("El id debe ser un número positivo");
    }
    
    const returnMsg = await svc.deleteByIdAsync(id);
    if(returnMsg == ""){
        res.setHeader('Content-Type', 'application/json').status(200).send(`Event Category eliminado con exito!`);
    }else{
        res.setHeader('Content-Type', 'text/plain').status(404).send(`${returnMsg}`);
    }
})


export default router