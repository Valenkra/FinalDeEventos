import { Router } from "express";
const router = Router();

router.get("", (req, res) => {
    const permitted = ["name", "category", "startdate", "tag"];
    /*const name = req.query.name;
    const category = req.query.category;
    const startdate = req.quesry.tartdate;
    const tag = req.query.tag;*/
    console.log(req.query);

    switch () {
        case 'name':
            break;
        case 'category':
            break;
    }
    res.status(400).send("alohaa");
})

export default router;