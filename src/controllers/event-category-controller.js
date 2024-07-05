import { Router } from "express";
import EventCategoryService from "../service/event-category_service.js";
const router = Router();
const svc = new EventCategoryService();

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
// 5 Listado de participantes
router.post("", (req, res) => {
    res.status(200).send(res);
})

router.put("", (req, res) => {
    res.status(200).send(res);
})

router.delete("/:id", (req, res) => {
    res.status(200).send(res);
})



export default router;