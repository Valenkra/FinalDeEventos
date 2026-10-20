import DBConfig from '../configs/dbconfigs.js';
import { Pool } from 'pg';
const pool = new Pool(DBConfig);
export default class UsersRepository {
  getUserByEventId = async (id) => (await pool.query(`SELECT U.id,U.username,U.first_name,U.last_name FROM users U JOIN events E ON U.id=E.id_creator_user WHERE E.id=$1`, [id])).rows;
  checkForOwnerByEventId = async (id) => (await pool.query(`SELECT U.username,U.id FROM events E JOIN users U ON U.id=E.id_creator_user WHERE E.id=$1`, [id])).rows;
  checkForOwnerByEventLocationId = async (id) => (await pool.query(`SELECT U.username,U.id FROM event_locations EL JOIN users U ON U.id=EL.id_creator_user WHERE EL.id=$1`, [id])).rows;
  insertUserAsync = async (fName,lName,user,hash) => (await pool.query(`INSERT INTO users(first_name,last_name,username,password) VALUES ($1,$2,$3,$4) RETURNING id`, [fName,lName,user,hash])).rows;
  findExistingUserAsync = async (user) => (await pool.query(`SELECT id,username,password FROM users WHERE username=$1`, [user])).rows;
  loginAsync = async (user) => this.findExistingUserAsync(user);
  getUserIdByUsernameAndPasswordAsync = async (user) => (await pool.query(`SELECT id FROM users WHERE username=$1`, [user])).rows;
  getWithConditionAsync = async (querys=[]) => {
    // Filters are built by legacy controllers; avoid accepting arbitrary SQL fragments here.
    if (querys.length) throw new Error('Filtros dinámicos de usuarios pendientes de migración a consultas parametrizadas');
    return (await pool.query(`SELECT DISTINCT U.id,U.username,U.first_name,U.last_name FROM events E JOIN users U ON U.id=E.id_creator_user`)).rows;
  };
  getUserEnrollmentDetailsByQuerysAsync = async (id, querys=[]) => {
    if (querys.length) throw new Error('Filtros dinámicos de inscripciones pendientes de migración');
    return (await pool.query(`SELECT U.id,U.username,U.first_name,U.last_name FROM users U JOIN event_enrollments EE ON EE.id_user=U.id WHERE EE.id_event=$1`,[id])).rows;
  };
}
