import LocationsRepository from "../repositories/location_repository.js";
import ProvinceRepository from "../repositories/province_repository.js";
import EventLocationRepository from "../repositories/event-location_repository.js";
import UsersRepository from "../repositories/users_repository.js";

export default class EventLocationService {
    getAllIdsAsync = async () => {
        const repo = new EventLocationRepository();
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

    getByIdAsync = async (id) => {
        const eRepo = new EventLocationRepository();
        const lRepo = new LocationsRepository();
        const pRepo = new ProvinceRepository();

        const eReturnArray = await eRepo.getByIdAsync(id);
        const lReturnArray = await lRepo.getLocationByEvenLocationId(id);
        const pReturnArray = await pRepo.getProvinceByEventLocationId(id);

        if(eReturnArray !== null){
            eReturnArray[0]["location"] = lReturnArray[0];
            eReturnArray[0]["location"]["province"] = pReturnArray[0];
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
        const lRepo = new LocationsRepository();
        const checkExistance = await lRepo.getById(data["id_location"]);
        let response;
        if(checkExistance !== null && checkExistance.length!= 0){
            if(data["max_capacity"]>0){
                const repo = new EventLocationRepository();
                response = await repo.insertAsync(data);
            }else{
                response = "BAD REQUEST: Max Assistance no puede ser menor o igual a 0";
            }
        }else{
            response = "BAD REQUEST: ID_location inexistente";
        }
        return response;
    }

    updateAsync = async (data, payload) => {
        const lRepo = new LocationsRepository();
        const uRepo = new UsersRepository();
        const checkForIdExistance = await lRepo.getById(data[data.length-1]);
        let payloadOwner = await uRepo.checkForOwnerByEventLocationId(data[data.length-1]);
        const checkExistance = await lRepo.getById(data[data.length-2].split("=")[1]);

        let response;
        if((payloadOwner !== null && payloadOwner.length != 0) && payload["username"] == payloadOwner[0]["username"] && payload["id"] == payloadOwner[0]["id"]){
            if(checkForIdExistance !== null && checkForIdExistance.length!= 0){
                if(checkExistance !== null && checkExistance.length!= 0){
                    const repo = new EventLocationRepository();
                    response = await repo.updateByIdAsync(data);
                }else{
                    response = "BAD REQUEST: ID_location inexistente";
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
        const repo = new EventLocationRepository();

        const checkForIdExistance = await repo.getByIdAsync(id);

        let response;
        if(checkForIdExistance !== null && checkForIdExistance.length != 0){
            let payloadOwner = await uRepo.checkForOwnerByEventLocationId(id);
            if(payloadOwner !== null && payload["username"] == payloadOwner[0]["username"] && payload["id"] == payloadOwner[0]["id"]){
                response = await repo.deleteByIdAsync(id);
            }else{
                response = "BAD REQUEST: No esta autorizado porque no es dueño del evento";
            }
        }else{
            response = "BAD REQUEST: ID inexistente";
        }
        return response;
    }
}