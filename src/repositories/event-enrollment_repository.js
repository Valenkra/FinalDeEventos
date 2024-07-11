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

    updateByIdAsync = async (obs, rating, id) => {
        let returnArray = null;
        const client = new Client(DBConfig);
        try {
            await client.connect();
            let querys = "";
            for (let i = 0; i < data.length - 1; i++) {
                querys += (i != data.length - 1) ? data[i] + ", " : data[i];
            }
            let sql = `UPDATE public.event_enrollments
                SET observations=${obs}, rating=${rating}
                WHERE ${id}`;
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
            let sql = `DELETE FROM event_enrollments
            WHERE id = ${id}`;
            const result = await client.query(sql);
            await client.end();
            returnArray = result.rows;
        } catch (error) {
            console.log(error);
        }
        return returnArray;
    }

    insertAsync = async (data) => {
        let returnArray = null;
        const client = new Client(DBConfig);
        try {
            await client.connect();
            let querys = "";
            for (let i = 0; i < data.length; i++) {
                querys += (i != data.length - 1) ? data[i] + ", " : data[i];
                
            }
            let sql = `INSERT INTO public.event_enrollments(
                id, id_user, description, registration_date_time, attended, observations, rating, id_event)
                VALUES ((SELECT MAX(id)+1 FROM public.events), ${querys})`;

                console.log(sql)
            const result = await client.query(sql);
            await client.end();
            returnArray = result.rows;
        } catch (error) {
            console.log(error);
        }
        return returnArray;
    }

    checkForUsersEnrolled = async (id, user) => {
        let returnArray = null;
        const client = new Client(DBConfig);
        try {
            await client.connect();
            let sql = `SELECT EE.id, U.username, E.id, E.name FROM Event_enrollments EE
            INNER JOIN Events E ON E.id = EE.id_event
            INNER JOIN Users U ON U.id = EE.id_user
            WHERE E.id = ${id} and U.username != '${user}'`;
            const result = await client.query(sql);
            await client.end();
            returnArray = result.rows;
        } catch (error) {
            console.log(error);
        }
        return returnArray;
    }

    obtenerCantInscriptosAsync = async (idEvent) => {
        let returnArray = null;
        const client = new Client(DBConfig);
        try {
            await client.connect();
            let sql = `SELECT count(id_user) FROM public.event_enrollments
            WHERE id_event = ${idEvent}`;
            const result = await client.query(sql);
            await client.end();
            returnArray = result.rows;
        } catch (error) {
            console.log(error);
        }
        return returnArray;
    }

    deleteUser = async (eventId, userId) => {
        let returnArray = null;
        const client = new Client(DBConfig);
        try {
            await client.connect();
            let sql = `DELETE FROM Event_enrollments
            WHERE id_event = ${eventId} and id_user = ${userId}`;
            const result = await client.query(sql);
            await client.end();
            returnArray = result.rows;
        } catch (error) {
            console.log(error);
        }
        return returnArray;
    }
}
