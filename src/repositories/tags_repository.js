import DBConfig from "../configs/dbconfigs.js"
import pkg from "pg";
const { Client, Pool } = pkg;


export default class TagsRepository {
    getTagsByEventId = async (id) => {
        let returnArray = null;
        const client = new Client(DBConfig);
        try {
            await client.connect();
            const sql = `SELECT TT.id, TT.name FROM tags TT
            INNER JOIN event_tags ET ON ET.id_tag = TT.id
            INNER JOIN events E ON E.id = ET.id_event
            WHERE E.id = ${id}`;

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
            let sql = `SELECT TT.id, TT.name FROM events E
                INNER JOIN event_tags ET ON E.id = ET.id_event
                INNER JOIN tags TT ON ET.id_tag = TT.id
                INNER JOIN event_categories EC ON E.id_event_category = EC.id
                INNER JOIN event_locations EL ON E.id_event_location = EL.id
                INNER JOIN locations L ON EL.id_location = L.id
                INNER JOIN users U ON U.id = E.id_creator_user
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
