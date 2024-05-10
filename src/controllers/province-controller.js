import { Router } from "express";
const router = Router();

// Listar provincias 
router.get("", (req, res) => {
    res.status(200).send("llegue");
})

// Provincia especifica
router.get(":id", (req, res) => {
    const id  = req.params.id;
    res.status(200).send("llegue");
})

// Provincia especifica
router.post("", (req, res) => { 
    const response = {
        id: null,
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


export default router;