import { Router } from "express";
import LocationService from "../service/locations_service.js";
import TokenHelper from "../helpers/token-helper.js";
import ValidacionesHelper from "../helpers/validaciones-helper.js";
const router = Router();
const svc = new LocationService();
const tokenHelper = new TokenHelper();
const validaciones = new ValidacionesHelper();

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

// 5 Listado de participantes
router.get("/:id/event-location", async (req, res) => {
    const id = req.params.id;  
    const validarId = validaciones.getIntegerOrDefault(id, -1);
    if(validarId === -1 || validarId <= 0){
        return res.setHeader('Content-Type', 'text/plain').status(400).send("El id debe ser un número positivo");
    }
    
    let token = tokenHelper.extractToken(req.headers.authorization);
    if(token !== false){
        let payload = await tokenHelper.autenticarUsuario(token);
        if(payload["error"] === undefined){
            const returnArray = await svc.getEventLocationByLocationId(id);
            if(returnArray !== null && returnArray.length != 0 && returnArray !== false){
                res.setHeader('Content-Type', 'application/json').status(200).json(returnArray);
            }else{
                res.setHeader('Content-Type', 'text/plain').status(404).send("Id location no existe");
            }
        } else{
            return res.setHeader('Content-Type', 'text/plain').status(401).send("Falta de token válido. Por favor, ingresá un token en el área de 'Authorization>Bearer Token'");
        }
    } else{
        return res.setHeader('Content-Type', 'text/plain').status(401).send("Falta de token válido. Por favor, ingresá un token en el área de 'Authorization>Bearer Token'");
    }

})


export default router;