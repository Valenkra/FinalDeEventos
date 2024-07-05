import { Router } from "express";
const router = Router();

// 3 Busqueda de un evento
router.get("", (req, res) => {
    res.status(200).send(res);
})

// 4 Detalle de un evento
router.get("/:id", async (req, res) => {
    const id = req.params.id;
    res.status(200).send(res);
})

router.post("" , async (req, res) => {

})

router.put("", async (req, res) => {

})

router.delete("/:id", async (req, res) => {
    
})

export default router;