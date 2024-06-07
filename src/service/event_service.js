import EventRepository from "../repositories/event_repository.js";

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
        const repo = new EventRepository();
        const returnArray = await repo.getByIdAsync(id);
        return returnArray;
    }
}