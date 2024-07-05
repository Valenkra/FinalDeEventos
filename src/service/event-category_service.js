import EventCategoryRepository from "../repositories/event-category_repository.js";

export default class EventCategoryService {
    getAllIdsAsync = async () => {
        const repo = new EventCategoryRepository();
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
        const repo = new EventCategoryRepository();

        const lReturnArray = await repo.getById(id);
        return lReturnArray;
    }
}