import { Router } from "express";
import EventService from "../service/event_service.js";
const router = Router();
const svc = new EventService();


// 3 Busqueda de un evento
router.get("", async (req, res) => {
    const response = {
        name: null,
        category: null,
        stardate: null,
        tag: null
    }

    let temp = 0;

    for (const [key, value] of Object.entries(req.query)) {
        if(response[`${key}`] !== undefined) response[`${key}`] = value;
        else temp++;
    }

    if(temp === Object.keys(req.query).length || Object.keys(req.query).length === 0){
        const returnArray = await svc.getAllAsync();
        return res.setHeader('Content-Type', 'application/json').status(200).json(returnArray);
    }else{
        let querys = [];
        for (const [key, value] of Object.entries(response)) {
            let prefijo = "";
            let myKey;
            if(value !== null) {
                switch(key){
                    case 'name':
                        prefijo = "E";
                        break;
                    case 'category':
                        prefijo = "EC";
                        break;
                    case 'startdate':
                        prefijo = "E";
                        break;
                    case 'tag':
                        prefijo = "TT";
                        break;
                }
                myKey = (key === "category" || key === "tag") ? "name" : key;
                myKey = (key === "startdate") ? "start_date": myKey;
                querys.push(`${prefijo}.${myKey} = '${value}'`);
            }
        }
        const returnArray = await svc.getWithConditionAsync(querys);
        if(returnArray.length !== 0){
            res.setHeader('Content-Type', 'application/json').status(200).json(returnArray);
        } else{
            res.setHeader('Content-Type', 'text/plain').status(404).send("No se encontró nada. Revisá las KEY o VALUES");
        }
    }
});

// 4 Detalle de un evento
router.get("/:id", async (req, res) => {
    console.log("llegue");
    const id = req.params.id;
    console.log(id);
    const returnArray = await svc.getWithConditionAsync(id);
    if(returnArray.length !== 0){
        res.setHeader('Content-Type', 'application/json').status(200).json(returnArray);
    } else{
        res.setHeader('Content-Type', 'text/plain').status(404).send("No se encontró nada. Revisá las KEY o VALUES");
    }
});

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