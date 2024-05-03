import { Router } from "express";
const router = Router();

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

export default router;