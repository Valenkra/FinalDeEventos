import DBConfig from "../configs/dbconfigs.js"
import pkg from "pg";
const { Client, Pool } = pkg;


export default class ProvinceRepository {
    getProvinceByEventId = async (id) => {
        let returnArray = null;
        const client = new Client(DBConfig);
        try {
            await client.connect();
            const sql = `SELECT PP.id, PP.name, PP.full_name, PP.latitude, PP.longitude, PP.display_order FROM provinces PP
			INNER JOIN locations L ON L.id_province = PP.id
			INNER JOIN event_locations EL ON EL.id_location = L.id
            INNER JOIN events E ON E.id_event_category = EL.id
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
