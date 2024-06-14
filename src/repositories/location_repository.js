import DBConfig from "../configs/dbconfigs.js"
import pkg from "pg";
const { Client, Pool } = pkg;


export default class LocationsRepository {
    getLocationByEventId = async (id) => {
        let returnArray = null;
        const client = new Client(DBConfig);
        try {
            await client.connect();
            const sql = `SELECT L.id, L.name, L.latitude, L.longitude, EL.max_capacity FROM locations L
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
