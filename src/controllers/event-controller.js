import { Router } from "express";
const router = Router();

// 2
/*
router.get("", (req, res) => {
    res.status(200).send("llegue");
})*/

// 3 Busqueda de un evento
router.get("", (req, res) => {
    const response = {
        name: null,
        category: null,
        stardate: null,
        tag: null
    }

    for (const [key, value] of Object.entries(req.query)) {
        if(response[`${key}`] !== undefined) response[`${key}`] = value;
    }

    res.status(200).send(response);
})

// 4 Detalle de un evento
router.get(":id", (req, res) => {
    const id = req.params.id;
    res.status(200).send(response);
})

// 5 Listado de participantes
router.get(":id/enrollment", (req, res) => {
    const id = req.params.id;
    const response = {
        first_name: null,
        last_name: null,
        username: null,
        attended: null,
        rating: null
    }

    for (const [key, value] of Object.entries(req.query)) {
        if(response[`${key}`] !== undefined) response[`${key}`] = value;
    }

    res.status(200).send(response);
})


export default router;