import DBConfig from "../configs/dbconfigs.js"
import pkg from "pg";
const { Client, Pool } = pkg;


export default class EventEnrollmentsRepository {
    getUserEnrollmentDetailsByQuerysAsync = async (id, querys) => {
        let returnArray = null;
        const client = new Client(DBConfig);
        try {
            await client.connect();
            let sql = `SELECT EE.attended, EE.rating, EE.description FROM event_enrollments EE
            INNER JOIN Events E ON E.id = EE.id_event
            INNER JOIN users U ON U.id = E.id_creator_user
            WHERE E.id = ${id} `;

            for(let i = 0; i < querys.length; i++) {
                if(i == 0) sql += "and "
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

    updateByIdAsync = async (-) => {
        let returnArray = null;
        const client = new Client(DBConfig);
        try {
            await client.connect();
            let querys = "";
            for (let i = 0; i < data.length - 1; i++) {
                querys += (i != data.length - 1) ? data[i] + ", " : data[i];
            }
            let sql = `UPDATE public.event_enrollments
                SET ${querys}
                WHERE ${data[data.length - 1]}`;
            const result = await client.query(sql);
            await client.end();
            returnArray = result.rows;
        } catch (error) {
            console.log(error);
        }
        return returnArray;
    }
}
