import { Router } from "express";
const router = Router();

// Login 
router.post("", (req, res) => {
    res.status(200).send("llegue");
})

// Sign Up 
router.post(":id", (req, res) => {
    const id = req.params.id;
    const response = {
        id: null
    }

    for (const [key, value] of Object.entries(req.query)) {
        if(response[`${key}`] !== undefined) response[`${key}`] = value;
    }
    res.status(200).send("llegue");
})


export default router;