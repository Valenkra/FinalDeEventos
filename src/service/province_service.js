import ProvinceRepository from "../repositories/province_province.js";

export default class ProvinceService {
    getAllIdsAsync = async () => {
        const repo = new ProvinceRepository();
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
        const repo = new ProvinceRepository();
        const lReturnArray = await repo.getById(id);
        return lReturnArray;
    }

    deleteByIdAsync = async (id) => {
        const repo = new ProvinceRepository();
        const checkExistance = await repo.getById(id);
        let response;
        if(checkExistance.length !== 0){
            response = await repo.deleteByIdAsync(id);
        }else{
            response = "BAD REQUEST: ID inexistente";
        }
        return response;
    }
}