import DBConfig from "../configs/dbconfigs.js"
import pkg from "pg";
const { Client, Pool } = pkg;


export default class EventRepository {
    getAllIdsAsync = async () => {
        let returnArray = null;
        const client = new Client(DBConfig);
        try {
            await client.connect();
            let sql = `SELECT E.id FROM Events E`;
            const result = await client.query(sql);
            await client.end();
            returnArray = result.rows;
        } catch (error) {
            console.log(error);
        }
        return returnArray;
    }

    getAllAsync = async () => {
        let returnArray = null;
        const client = new Client(DBConfig);
        //const pool = new Pool(DBConfig);
        try {
            await client.connect();
            const sql = `SELECT * FROM events E
            INNER JOIN event_categories EC ON E.id_event_category = EC.id
            INNER JOIN event_tags ET ON E.id = ET.id_event
            INNER JOIN tags TT ON ET.id_tag = TT.id
            INNER JOIN event_locations EL ON EL.id = E.id_event_location
            INNER JOIN locations L ON L.id = EL.id_location
            INNER JOIN provinces PP ON PP.id = L.id_province
            INNER JOIN users U ON U.id = E.id_creator_user
			
			GROUP BY E.id, ET.id, TT.id, EL.id, L.id, PP.id, U.id, EC.id
            ORDER BY E.id ASC`;

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

    getByIdAsync = async (id) => {let returnArray = null;
        const client = new Client(DBConfig);
        try {
            await client.connect();
            let sql = `SELECT E.id, E.name, E.description, E.start_date, 
                    E.duration_in_minutes, E.price, E.enabled_for_enrollment, E.max_assistance
                    FROM events E
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
