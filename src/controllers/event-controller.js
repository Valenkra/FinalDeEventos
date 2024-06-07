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

    console.log(Object.keys(req.query).length)
    for (const [key, value] of Object.entries(req.query)) {
        if(response[`${key}`] !== undefined) response[`${key}`] = value;
        else temp++;
    }

    if(temp === Object.keys(req.query).length || Object.keys(req.query).length === 0){
        const returnArray = await svc.getAllAsync();
        res.status(200).json(returnArray);
    }else{
        let querys = [];
        for (const [key, value] of Object.entries(response)) {
            let prefijo = "";
            let myKey;
            if(response[`${value}`] !== null) {
                switch(key){
                    case 'name':
                        prefijo = "E";
                        break;
                    case 'category':
                        prefijo = "EC";
                        break;
                    case 'startdate':
                        myKey = "start_date";
                        prefijo = "E";
                        break;
                    case 'tag':
                        prefijo = "TT";
                        break;
                }
                myKey = (key === "category" || key === "tag") ? "name" : key;
                querys.push(`${prefijo}.${myKey} = '${value}'`);
            }
            
        }
    }

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