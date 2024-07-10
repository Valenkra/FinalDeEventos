import LocationsRepository from "../repositories/location_repository.js";
import ProvinceRepository from "../repositories/province_repository.js";
import EventLocationRepository from "../repositories/event-location_repository.js";

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

        if(eReturnArray.length > 0){
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
}