import EventCategoryRepository from "../repositories/event-category_repository.js";

export default class EventCategoryService {
    getAllAsync = async () => {
        const repo = new EventCategoryRepository();
        const returnArray = await repo.getAllAsync();
        return returnArray;
    }

    getByIdAsync = async (id) => {
        const repo = new EventCategoryRepository();
        const lReturnArray = await repo.getById(id);
        return lReturnArray;
    }

    deleteByIdAsync = async (id) => {
        const repo = new EventCategoryRepository();
        const checkExistance = await repo.getById(id);
        let response;
        if(checkExistance.length !== 0){
            response = await repo.deleteByIdAsync(id);
        }else{
            response = "BAD REQUEST: ID inexistente";
        }
        return response;
    }

    updateByIdAsync = async(data) => {
        const repo = new EventCategoryRepository();
        const checkExistance = await repo.getById(data[data.length-1]);
        let response;
        if(checkExistance !== null){
            response = await repo.updateByIdAsync(data);
        }else{
            response = "BAD REQUEST: ID inexistente";
        }
        return response;
    }

    createAsync = async(name, dOrder) => {
        const repo = new EventCategoryRepository();
        const lReturnArray = await repo.insertAsync(name, dOrder);
        return lReturnArray;
    }
}