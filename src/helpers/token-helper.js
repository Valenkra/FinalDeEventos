import LogInHelper from "./login-helper.js";
import UserService from "../service/user_service.js";
const LH = new LogInHelper();
const svc = new UserService();

export default class TokenHelper {
    extractToken = (req) => {
        if (req && req.split(' ')[0] === 'Bearer') {
            return req.split(' ')[1];
        }else{return false}
    }

    autenticarUsuario = async (token) => {
        let payload = await LH.desencriptarToken(token);
        if(payload['error'] === undefined){
            let userID = await svc.getIdAsync(payload["user"], payload["passw"]);
            let data = {
                username: payload["user"],
                password: payload["passw"],
                id: userID[0]["id"]
            }
            return data;
        }else{
            return payload;
        }
    } 
}
