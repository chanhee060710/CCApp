require('dotenv').config()

const express = require('express');
const mysql = require('mysql')
const app = express();
const port = 4000;

const jwt = require('jsonwebtoken')

app.use(express.json())

let refreshTokens = []

app.post('/token',(req,res) =>{
  const refreshToken = req.body.token
  if(refreshToken == null) return res.sendStatus(401)
  if(!refreshTokens.includes(refreshToken)) return res.sendStatus(403)
  jwt.verify(refreshToken,process.env.REFRESH_TOKEN_SECRET,(err,user) =>{
    if(err) return res.sendStatus(403)
    const accessToken= generateAccessToken({name: user.name})
    res.json({accessToken:accessToken})
  })
})

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



app.listen(port, () => {
    console.log('server is working on port localhost:3000')
  })
app.use(express.urlencoded({extended:true}))
app.use(express.json())

app.delete('/logout',(req,res) =>{
  refreshTokens = refreshTokens.filter(token => token !==req.body.token)
  res.sendStatus(204)
})

app.post('/sign_in',(req,res) =>{
  try{
    const nickname = req.body.nickname
    const email = req.body.email
    const password = req.body.password
    const phonenumber = req.body.phonenumber
    db.query('INSERT INTO Users (nickname, email,password,phonenumber) VALUES (?, ?, ?, ?)',[nickname,email,password,phonenumber])
  }catch(err){
    return false
  }
 
})

app.post('/login',(req,res) =>{
  // const useremail = req.body.useremail
   const username = req.body.username
  // const userpassword = req.body.password
  // const userphonenumber = req.body.phonenumber
   const user = {name:username}

  const accessToken = generateAccessToken(user)
  const refreshToken = jwt.sign(user,process.env.REFRESH_TOKEN_SECRET)
  refreshTokens.push(refreshToken)
  res.json({accessToken:accessToken, refreshToken:refreshToken})
})

function generateAccessToken(user){
  return jwt.sign(user,process.env.ACCESS_TOKEN_SECRET,{expiresIn: '15s'})
}