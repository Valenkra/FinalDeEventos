import DBConfig from "../configs/dbconfigs.js"
import pkg from "pg";
const { Client, Pool } = pkg;


export default class UsersRepository {
    getUserByEventId = async (id) => {
        let returnArray = null;
        const client = new Client(DBConfig);
        //const pool = new Pool(DBConfig);
        try {
            await client.connect();
            const sql = `SELECT U.id, U.username, U.first_name, U.last_name FROM users U
            INNER JOIN events E ON U.id = E.id_creator_user
            WHERE E.id = ${id}`;

            const result = await client.query(sql);
            await client.end();
            returnArray = result.rows;
        } catch (error) {
            console.log(error);
        }
        return returnArray;
    }
}
