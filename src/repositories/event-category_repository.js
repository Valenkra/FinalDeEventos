import DBConfig from "../configs/dbconfigs.js"
import pkg from "pg";
const { Client, Pool } = pkg;


export default class EventCategoryRepository {
    getEventCategoryByEventId = async (id) => {
        let returnArray = null;
        const client = new Client(DBConfig);
        //const pool = new Pool(DBConfig);
        try {
            await client.connect();
            const sql = `SELECT EC.id, EC.name FROM event_categories EC
            INNER JOIN events E ON E.id_event_category = EC.id
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
