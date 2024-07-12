import EventRepository from "../repositories/event_repository.js";
import LocationsRepository from "../repositories/location_repository.js";
import EventCategoryRepository from "../repositories/event-category_repository.js";
import EventLocationRepository from "../repositories/event-location_repository.js";
import ProvinceRepository from "../repositories/province_repository.js";
import TagsRepository from "../repositories/tags_repository.js";
import EventEnrollmentsRepository from "../repositories/event-enrollment_repository.js";
import UsersRepository from "../repositories/users_repository.js";
import { response } from "express";

export default class EventService {
    getAllIdsAsync = async () => {
        const repo = new EventRepository();
        const returnArray = await repo.getAllIdsAsync();
        return returnArray;
    }

    getAllAsync = async () => {
        let IDs = await this.getAllIdsAsync();
        const returnArray = [];

        for (let i = 0; i < IDs.length; i++) {
            for (const [key, value] of Object.entries(IDs[i])) {
                const myList = await this.getByIdAsync(value);
                returnArray.push(myList[0]);
            }
        }

        return returnArray;
    }

    getWithConditionAsync = async (querys) => {
        const eRepo = new EventRepository();
        const uRepo = new UsersRepository();
        const ecRepo = new EventCategoryRepository();
        const elRepo = new EventLocationRepository();
        const lRepo = new LocationsRepository();
        const pRepo = new ProvinceRepository();
        const tRepo = new TagsRepository();

        const eReturnArray = await eRepo.getWithConditionAsync(querys);
        const uReturnArray = await uRepo.getWithConditionAsync(querys);
        const ecReturnArray = await ecRepo.getWithConditionAsync(querys);
        const elReturnArray = await elRepo.getWithConditionAsync(querys);
        const lReturnArray = await lRepo.getWithConditionAsync(querys);
        const pReturnArray = await pRepo.getWithConditionAsync(querys);
        const tReturnArray = await tRepo.getWithConditionAsync(querys);

        if(eReturnArray !== null && eReturnArray.length != 0){
            for (let i = 0; i < eReturnArray.length; i++) {
                eReturnArray[i]["event_location"] = elReturnArray[i];
                eReturnArray[i]["event_location"]["location"] = lReturnArray[i];
                eReturnArray[i]["event_location"]["location"]["province"] = pReturnArray[i];
                eReturnArray[i]["event_category"] = ecReturnArray[i];
                eReturnArray[i]["creator_user"] = uReturnArray[i];
                eReturnArray[i]["tags"] = tReturnArray;
            }   
        }
        
        return eReturnArray;
    }

    getByIdAsync = async (id) => {
        const eRepo = new EventRepository();
        const uRepo = new UsersRepository();
        const ecRepo = new EventCategoryRepository();
        const elRepo = new EventLocationRepository();
        const lRepo = new LocationsRepository();
        const pRepo = new ProvinceRepository();
        const tRepo = new TagsRepository();

        const eReturnArray = await eRepo.getByIdAsync(id);
        const uReturnArray = await uRepo.getUserByEventId(id);
        const ecReturnArray = await ecRepo.getEventCategoryByEventId(id);
        const elReturnArray = await elRepo.getEventLocationByEventId(id);
        const lReturnArray = await lRepo.getLocationByEventId(id);
        const pReturnArray = await pRepo.getProvinceByEventId(id);
        const tReturnArray = await tRepo.getTagsByEventId(id);

        if(eReturnArray !== null && eReturnArray.length != 0){
            eReturnArray[0]["event_location"] = elReturnArray[0];
            eReturnArray[0]["event_location"]["location"] = lReturnArray[0];
            eReturnArray[0]["event_location"]["location"]["province"] = pReturnArray[0];
            eReturnArray[0]["event_category"] = ecReturnArray[0];
            eReturnArray[0]["creator_user"] = uReturnArray[0];
            eReturnArray[0]["tags"] = tReturnArray;
        }
        return eReturnArray;
    }

    getEnrollmentDetailsAsync = async (id, querys) => {
        const uRepo = new UsersRepository();
        const eeRepo = new EventEnrollmentsRepository();
        const uReturnArray = await uRepo.getUserEnrollmentDetailsByQuerysAsync(id, querys);
        const eeReturnArray = await eeRepo.getUserEnrollmentDetailsByQuerysAsync(id, querys);

        for (let i = 0; i < eeReturnArray.length; i++) {
            eeReturnArray[i]["user"] = uReturnArray[i];
        }
        return eeReturnArray;
    }

    createAsync = async (data) => {
        const lRepo = new EventLocationRepository();
        const checkExistance = await lRepo.getByIdAsync(data["id_event_location"]);
        let response;
        if(checkExistance !== null){
            if(checkExistance[0]["max_capacity"] >= data["max_assistance"]){
                const repo = new EventRepository();
                response = await repo.insertAsync(data);
            }else{
                response = "BAD REQUEST: Max Assistance no puede ser mayor a Max_Capacity de la locación";
            }
        }else{
            response = "BAD REQUEST: ID inexistente";
        }
        return response;
    }

    updateAsync = async (data, payload) => {
        const lRepo = new EventLocationRepository();
        const uRepo = new UsersRepository();
        const checkForIdExistance = await lRepo.getByIdAsync(data[data.length-1]);
        let payloadOwner = await uRepo.checkForOwnerByEventId(data[data.length-1]);
        const checkExistance = await lRepo.getByIdAsync(data[data.length-2].split("=")[1]);
        let response;
        if(payloadOwner !== null && payload["username"] == payloadOwner[0]["username"] && payload["id"] == payloadOwner[0]["id"]){
            if(checkForIdExistance !== null){
                if(checkExistance !== null){
                    if(checkExistance[0]["max_capacity"] >= data[8].split("=")[1]){
                    const repo = new EventRepository();
                    response = await repo.updateByIdAsync(data);
                    }else{
                        response = "BAD REQUEST: Max Assistance no puede ser mayor a Max_Capacity de la locación";
                    }
                }else{
                    response = "BAD REQUEST: ID Event Location inexistente";
                }                                       
            }else{
                response = "BAD REQUEST: ID inexistente";
            }
        }else{
            response = "BAD REQUEST: No esta autorizado porque no es dueño del evento";
        }
        return response;
    }

    deleteAsync = async (id, payload) => {
        const uRepo = new UsersRepository();
        const repo = new EventRepository();
        const eeRepo = new EventEnrollmentsRepository();

        const checkForIdExistance = await repo.getByIdAsync(id);
        let response;

        if(checkForIdExistance !== null && checkForIdExistance.length != 0){
            let payloadOwner = await uRepo.checkForOwnerByEventId(id);
            if(payloadOwner !== null && payload["username"] == payloadOwner[0]["username"] && payload["id"] == payloadOwner[0]["id"]){
                const inscripciones = await eeRepo.checkForUsersEnrolled(id, payload["username"]);
                console.log(inscripciones)
                if(inscripciones === null || inscripciones.length== 0){
                    response = await repo.deleteByIdAsync(id);
                }else{
                    response = "BAD REQUEST: Ya hay usuarios registrados al evento y no sos vos";
                }
            }else{
                response = "BAD REQUEST: No esta autorizado porque no es dueño del evento";
            }
        }else{
            response = "BAD REQUEST: ID inexistente";
        }
        
        return response;
    }

    inscribirUsuario = async (id, payload) => {
        const enrollmentRepo = new EventEnrollmentsRepository();
        const eventInfo = await this.getByIdAsync(id);
        const enrollmentInfo = await enrollmentRepo.obtenerCantInscriptosAsync(id);
        let response;
        
        if(eventInfo !== null && eventInfo.length != 0 && enrollmentInfo !== null && enrollmentInfo.length != 0){
            if(enrollmentInfo[0]["count"] + 1 <= eventInfo[0]["max_assistance"]){
                if(eventInfo[0]["enabled_for_enrollment"] == true){
                    let querys = [`U.username = '${payload["username"]}'`,
                        `U.password = '${payload["password"]}'`]
                    const checkAssistance = await this.getEnrollmentDetailsAsync(id, querys);
                    if(checkAssistance === null || checkAssistance.length == 0){
                        if(new Date() < eventInfo[0]["start_date"]){
                            const data = [`${payload["id"]}`,"''",
                            `'${new Date().toISOString()}'`, false, "''", 0, id];
                            
                            response = await enrollmentRepo.insertAsync(data);
                        }else{
                            response = "BAD REQUEST: El evento ya terminó, por lo que no podes inscribirte";
                        }
                    }else{
                        response = "BAD REQUEST: Ya esta registrado al evento";
                    }
                }else{
                    response = "BAD REQUEST: El evento no permite mas inscripciones";
                }
            }else{
                response = "BAD REQUEST: Ya no entra mas gente al eventos";
            }
        }else{
            response = "BAD REQUEST: ID inexistente";
        }
    return response;
    }

    eliminarUsuario = async (id, payload) => {
        const enrollmentRepo = new EventEnrollmentsRepository();
        const eventInfo = await this.getByIdAsync(id);
        const enrollmentInfo = await enrollmentRepo.obtenerCantInscriptosAsync(id);
        let response;
        
        if(eventInfo !== null && enrollmentInfo !== null){
            let querys = [`U.username = '${payload["username"]}'`,
                `U.password = '${payload["password"]}'`]
            const checkAssistance = await this.getEnrollmentDetailsAsync(id, querys);
            if(checkAssistance !== null && checkAssistance.length != 0){
                if(new Date() < eventInfo[0]["start_date"]){
                    response = await enrollmentRepo.deleteUser(id, payload["id"]);
                }else{
                    response = "BAD REQUEST: El evento ya terminó";
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