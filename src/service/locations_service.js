import EventLocationRepository from "../repositories/event-location_repository.js";
import LocationsRepository from "../repositories/location_repository.js";
import ProvinceRepository from "../repositories/province_repository.js";

export default class LocationsService {
    getAllIdsAsync = async () => {
        const repo = new LocationsRepository();
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
        const lRepo = new LocationsRepository();
        const pRepo = new ProvinceRepository();

        const lReturnArray = await lRepo.getById(id);
        const pReturnArray = await pRepo.getProvinceByLocationId(id);
        if(lReturnArray !== null && lReturnArray.length != 0) lReturnArray[0]["province"] = pReturnArray[0];
        return lReturnArray;
    }

    getEventLocationByLocationId = async (id) => {
        const repo = new EventLocationRepository();
        const checkExistency = this.getAllIdsAsync(id);
        if(checkExistency){
            const returnArray = await repo.getEventLocationByLocationId(id);
            return returnArray;
        }else{
            return false;
        }
    }

}