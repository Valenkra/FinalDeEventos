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

    getWithConditionAsync = async (querys) => {
        let returnArray = null;
        const client = new Client(DBConfig);
        try {
            await client.connect();
            let sql = `SELECT * FROM events E
            INNER JOIN event_categories EC ON E.id_event_category = EC.id
            INNER JOIN event_tags ET ON E.id = ET.id_event
            INNER JOIN tags TT ON ET.id_tag = TT.id
            WHERE `;

            for(let i = 0; i < querys.length; i++) {
                sql += querys[i];
                if(i != querys.length - 1){
                    sql += " and "
                }
            }
            const result = await client.query(sql);
            await client.end();
            returnArray = result.rows;
        } catch (error) {
            console.log(error);
        }
        return returnArray;
    }
}
