import EventRepository from "../repositories/event_repository.js";
import UsersRepository from "../repositories/users_repository.js";
import EventCategoryRepository from "../repositories/event-category_repository.js"

export default class EventService {
    getAllAsync = async () => {
        const repo = new EventRepository();
        const returnArray = await repo.getAllAsync();
        return returnArray;
    }

    getWithConditionAsync = async (querys) => {
        const repo = new EventRepository();
        const returnArray = await repo.getWithConditionAsync(querys);
        return returnArray;
    }

    getByIdAsync = async (id) => {
        const eRepo = new EventRepository();
        const uRepo = new UsersRepository();
        const ecRepo = new EventCategoryRepository();

        const eReturnArray = await eRepo.getByIdAsync(id);
        const uReturnArray = await uRepo.getUserByEventId(id);
        const ecReturnArray = await ecRepo.getEventCategoryByEventId(id);
        eReturnArray[0]["creator_user"] = uReturnArray[0];
        eReturnArray[0]["event_category"] = ecReturnArray[0];
        return eReturnArray;
    }
}