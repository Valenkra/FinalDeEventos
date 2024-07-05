import UsersRepository from "../repositories/users_repository.js";

export default class UserService {
    registerAsync = async (fName, lName, user, passw) => {
        const repo = new UsersRepository();
        const checkForExistance = await repo.findExistingUserAsync(user);
        let msg;
        if(checkForExistance.length === 0){
            msg = await repo.insertUserAsync(fName, lName, user, passw);
        }else{
            msg = "El usuario ya existe. Intente iniciar sesion o elegir otro usuario."
        }
        return msg;
    }

    logInAsync = async (user, passw) => {
        const repo = new UsersRepository();
        const returnArray = await repo.loginAsync(user, passw);
        return returnArray;
    }
}