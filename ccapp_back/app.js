const express = require('express');
const mysql = require('mysql')
const app = express();
const port = 3000;

const db = mysql.createConnection({
  host: 'localhost',
  user: 'root ',
  password: '060710',
  database: ' chat_app',
  port: '3300',
});

app.listen(port, () => {
    console.log('server is working on port localhost:3000')
  })
app.use(express.urlencoded({extended:true}))
app.use(express.json())

db.connect();

db.query('SELECT * FROM student', (error, result) => {
  if (error) return console.log(error, 'check');

  console.log(result);
});

app.get('/process/adduser',(req,res) =>{
    console.log('/process/adduser 호출됨'+req)
    const paramEmail =req.body.Email;
    const paramNickname = req.body.Nickname;
    const paramPassword = req.body.password;
    const paramPhonenumber = req.body.phonenumber;


})