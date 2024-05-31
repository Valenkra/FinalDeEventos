import DBConfig from "../configs/dbconfigs.js"
import pkg from "pg";
const { Client, Pool } = pkg;


export default class EventRepository {
    getAllAsync = async () => {
        let returnArray = null;
        const client = new Client(DBConfig);
        //const pool = new Pool(DBConfig);
        try {
            await client.connect();
            const sql = "SELECT * FROM events";
            const result = await client.query(sql);
            await client.end();
            returnArray = result.rows;
        } catch (error) {
            console.log(error);
        }
        return returnArray;
    }
}
