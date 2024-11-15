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

    getWithConditionAsync = async (querys) => {
        let returnArray = null;
        const client = new Client(DBConfig);
        try {
            await client.connect();
            let sql = `SELECT PP.id, PP.name, PP.full_name, PP.latitude, PP.longitude, PP.display_order FROM events E
                INNER JOIN event_tags ET ON E.id = ET.id_event
                INNER JOIN tags TT ON ET.id_tag = TT.id
                INNER JOIN event_categories EC ON E.id_event_category = EC.id
                INNER JOIN event_locations EL ON E.id_event_location = EL.id
                INNER JOIN locations L ON EL.id_location = L.id
                INNER JOIN users U ON U.id = E.id_creator_user
                INNER JOIN provinces PP ON PP.id = L.id_province
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

    getProvinceByLocationId = async (id) => {
        let returnArray = null;
        const client = new Client(DBConfig);
        try {
            await client.connect();
            const sql = `SELECT PP.id, PP.name, PP.full_name, PP.latitude, PP.longitude, PP.display_order FROM provinces PP
			INNER JOIN locations L ON L.id_province = PP.id
            WHERE L.id = ${id}`;

            const result = await client.query(sql);
            await client.end();
            returnArray = result.rows;
        } catch (error) {
            console.log(error);
        }
        return returnArray;
    }

    getProvinceByEventLocationId = async (id) => {
        let returnArray = null;
        const client = new Client(DBConfig);
        try {
            await client.connect();
            const sql = `SELECT PP.id, PP.name, PP.full_name, PP.latitude, PP.longitude, PP.display_order
            FROM event_locations EL
            INNER JOIN locations L ON EL.id_location = L.id
            INNER JOIN provinces PP ON PP.id = L.id_province
            WHERE EL.id = ${id}`;

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
        try {
            await client.connect();
            let sql = `SELECT * FROM Provinces PP
                        ORDER BY id ASC`;
            const result = await client.query(sql);
            await client.end();
            returnArray = result.rows;
        } catch (error) {
            console.log(error);
        }
        return returnArray;
    }

    getById = async (id) => {
        let returnArray = null;
        const client = new Client(DBConfig);
        try {
            await client.connect();
            let sql = `SELECT * FROM Provinces PP
                        WHERE PP.id = ${id}`;
            const result = await client.query(sql);
            await client.end();
            returnArray = result.rows;
        } catch (error) {
            console.log(error);
        }
        return returnArray;
    }

    getAllIdsAsync = async () => {
        let returnArray = null;
        const client = new Client(DBConfig);
        try {
            await client.connect();
            let sql = `SELECT PP.id FROM Provinces PP`;
            const result = await client.query(sql);
            await client.end();
            returnArray = result.rows;
        } catch (error) {
            console.log(error);
        }
        return returnArray;
    }

    insertAsync = async (name, fName, latitude, longitude, dOrder) => {
        let returnArray = null;
        const client = new Client(DBConfig);
        try {
            await client.connect();
            let sql = `INSERT INTO public.provinces(
                name, full_name, latitude, longitude, display_order, id)
                VALUES ('${name}', '${fName}', ${latitude}, ${longitude}, ${dOrder}, (SELECT MAX(id)+1 FROM public.provinces));
                `;
            const result = await client.query(sql);
            await client.end();
            returnArray = result.rows;
        } catch (error) {
            console.log(error);
        }
        return returnArray;
    }

    
    updateByIdAsync = async (data) => {
        let returnArray = null;
        const client = new Client(DBConfig);
        try {
            await client.connect();
            let querys = "";
            for (let i = 0; i < data.length - 1; i++) {
                querys += (i != data.length - 2) ? data[i] + ", " : data[i];
            }

            let sql = `UPDATE Provinces
                SET ${querys}
                WHERE id=${parseInt(data[data.length - 1])};`;
            const result = await client.query(sql);
            await client.end();
            returnArray = result.rows;
        } catch (error) {
            console.log(error);
        }
        return returnArray;
    }

    deleteByIdAsync = async (id) => {
        let returnArray = null;
        const client = new Client(DBConfig);
        try {
            await client.connect();
            let sql = `DELETE FROM Provinces
            WHERE id = ${id}`;
            const result = await client.query(sql);
            await client.end();
            returnArray = result.rows;
        } catch (error) {
            console.log(error);
        }
        return returnArray;
    }
}
