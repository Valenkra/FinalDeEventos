import { Router } from "express";
const router = Router();

// Login 
router.post("/login", (req, res) => {
    const response = {
        username: null,
        password: null
    }

    for (const [key, value] of Object.entries(req.query)) {
        if(response[`${key}`] !== undefined) response[`${key}`] = value;
    }
    res.status(200).send("llegue");
})

// Sign Up 
router.post("/register", (req, res) => {
    const response = {
        fist_name: null,
        last_name: null,
        username: null,
        password: null
    }

    for (const [key, value] of Object.entries(req.query)) {
        if(response[`${key}`] !== undefined) response[`${key}`] = value;
    }
    res.status(200).send("llegue");
})


export default router;