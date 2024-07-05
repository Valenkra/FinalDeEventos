import { Router } from "express";
import ProvinceService from "../service/province_service.js";
const router = Router();
const svc = new ProvinceService();

// 3 Busqueda de un evento
router.get("", async (req, res) => {
    const returnArray = await svc.getAllAsync();
    res.setHeader('Content-Type', 'application/json').status(200).json(returnArray);
})

// 4 Detalle de un evento
router.get("/:id", async (req, res) => {
    const id = req.params.id;
    const returnArray = await svc.getByIdAsync(id);
    if(returnArray.length != 0){
        res.setHeader('Content-Type', 'application/json').status(200).json(returnArray);
    }else{
        res.setHeader('Content-Type', 'text/plain').status(404).send("No se encontró nada. Revisá las KEY o VALUES");
    }
})

router.get("/:id/locations", async (req, res) => {
    
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

    for (const [key, value] of Object.entries(req.query)) {
        if(response[`${key}`] !== undefined) response[`${key}`] = value;
    }
    res.status(200).send("llegue");
})

router.put("", async (req, res) => {

})


router.delete("/:id", async (req, res) => {
    
})


export default router;