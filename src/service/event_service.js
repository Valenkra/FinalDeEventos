import EventRepository from "../repositories/event_repository.js";
import UsersRepository from "../repositories/users_repository.js";
import LocationsRepository from "../repositories/location_repository.js";
import EventCategoryRepository from "../repositories/event-category_repository.js";
import EventLocationRepository from "../repositories/event-location_repository.js";
import ProvinceRepository from "../repositories/province_repository.js";
import TagsRepository from "../repositories/tags_repository.js";
import EventEnrollmentsRepository from "../repositories/event-enrollment_repository.js";

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

        for (let i = 0; i < eReturnArray.length; i++) {
            eReturnArray[i]["event_location"] = elReturnArray[i];
            eReturnArray[i]["event_location"]["location"] = lReturnArray[i];
            eReturnArray[i]["event_location"]["location"]["province"] = pReturnArray[i];
            eReturnArray[i]["event_category"] = ecReturnArray[i];
            eReturnArray[i]["creator_user"] = uReturnArray[i];
            eReturnArray[i]["tags"] = tReturnArray;
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

        eReturnArray[0]["event_location"] = elReturnArray[0];
        eReturnArray[0]["event_location"]["location"] = lReturnArray[0];
        eReturnArray[0]["event_location"]["location"]["province"] = pReturnArray[0];
        eReturnArray[0]["event_category"] = ecReturnArray[0];
        eReturnArray[0]["creator_user"] = uReturnArray[0];
        eReturnArray[0]["tags"] = tReturnArray;
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