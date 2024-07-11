import jwt from 'jsonwebtoken';
const SECRETKEY = 'v4l3?nc=H43!Sl4m4@Sc4p#AaYn0t//13nEm$A5cOt4%';

export default class LogInHelper {
    setPayload = (user, passw) => {
        const payload = {
            user: `${user}`,
            passw: `${passw}`
        }
        return payload;
    }

    generarToken = async (user, passw) => {
        const payload = this.setPayload(user,passw);
        const options = {
            expiresIn: '2h',
            issuer: 'valenYnaccache'
        }
        const token = await jwt.sign(payload, SECRETKEY, options);
        return token;
    }

    desencriptarToken = async (token) => {
        let payload = null;
        try {
            payload = await jwt.verify(token, SECRETKEY);
        }catch (e) {
            const error = {
                error: `${e}`
            }
            return error;
        }
        return payload;
    }
}