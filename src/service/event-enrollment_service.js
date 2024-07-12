import EventEnrollmentsRepository from "../repositories/event-enrollment_repository.js";
import EventRepository from "../repositories/event_repository.js";
import EventService from "./event_service.js";
import { response } from "express";

export default class EventEnrollmentService {
    updateRating = async (data) => {
        const repo = new EventEnrollmentsRepository();
        const eRepo = new EventRepository();
        const eSvc = new EventService();
        const eventInfo = await eRepo.getByIdAsync(data[0]);
        const enrollmentInfo = await repo.obtenerCantInscriptosAsync(data[0]);
        let response;
        
        if(eventInfo !== null && enrollmentInfo !== null){
            let querys = [`U.username = '${data[1]["username"]}'`,
                `U.password = '${data[1]["password"]}'`]
            const checkAssistance = await eSvc.getEnrollmentDetailsAsync(data[0], querys);
            if(checkAssistance !== null && checkAssistance.length != 0){
                if(new Date() > eventInfo[0]["start_date"]){
                    response = await repo.updateEventRating(data);
                }else{
                    response = "BAD REQUEST: El evento todavía no ha terminado";
                }
            }else{
                response = "BAD REQUEST: No te encuentas registrado al evento";
            }
        }else{
            response = "BAD REQUEST: ID inexistente";
        }
        return response;
    }

}