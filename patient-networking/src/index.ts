import express from 'express';
import mysql from 'mysql2';
import chalk from 'chalk';
import fs from 'fs';

const app = express();
const PORT = 3000;
// const LOG_LEVEL = LogLevel.DEBUG;

app.use(express.json());

const host = process.env.SQL_HOST || 'localhost'; // Needs to be 127.0.0.1 on mac and localhost on other unix systems
const user = process.env.SQL_USER || 'root';
const password = process.env.SQL_PASSWORD || 'root'; // TODO:  Obviously
const database = process.env.SQL_DATABASE || 'BattHealth';
const port = Number(process.env.SQL_PORT || 3306);

const sqlClient = mysql.createConnection({
  host: host,
  user: user,
  password: password,
  database: database,
  port: port,
});

app.get('/health', async (_, res) => {
  // TODO: Don't expose these to users in production
  const response = `
    PillPal.
                                                                                             
    Status: OK 😁
    Database Host: ${host}
    Database User: ${user}
    Database Name: ${database}
    Timestamp: ${Date.now()}
  `
  res.send(response);
});

app.get('/pdm/:id', async (req, res) => {
  const id = req.params.id;
  sqlClient.query(`SELECT * FROM Units WHERE UnitID = ${id}`, function(err, rows, fields) {
    if (err) throw err;
    console.log('Got unit: ', rows);
    res.send(rows);
  })
});

app.listen(PORT, () => {
  // Execute ./sql/DB_Init.sql
  console.log(`Current directory: ${process.cwd()}`);

  const sql = fs.readFileSync('./src/sql/DB_Init.sql', 'utf8');
  const sqlSplit = sql.split(';');
  for (const line of sqlSplit) {
    sqlClient
      .query(line, function(err, sets, fields) {
        console.debug(`Executed SQL: ${line}`);
        if (err) console.error(`Got error: \n${err}`);
      })
  }
  console.info(`Done! Executed ${sqlSplit.length} SQL statements.`);

  console.log(`Server is running on port ` + chalk.whiteBright.bgBlue(`${PORT}`));
});
