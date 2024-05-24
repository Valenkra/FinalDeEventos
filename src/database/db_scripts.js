import config from "../configs/dbconfigs.js"
import pkg from 'pg'

const { Client } = pkg;

const client = new Client(config)
await client.connect();

let sql = 'SELECT * from provinces';
let result = await client.query(sql);
await client.end();
console.log(result.rows);
