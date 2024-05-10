import { Router } from "express";
const router = Router();

// 3 Busqueda de un evento
router.get("", (req, res) => {
    res.status(200).send(res);
})

// 4 Detalle de un evento
router.get(":id", (req, res) => {
    const id = req.params.id;
    res.status(200).send(res);
})

// 5 Listado de participantes
router.get("/location/:id", (req, res) => {
    const id = req.params.id;

    res.status(200).send(res);
})


export default router;