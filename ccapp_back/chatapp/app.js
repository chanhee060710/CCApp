require('dotenv').config()

const express = require('express');
const mysql = require('mysql')
const app = express();
const port = 3000;

const jwt = require('jsonwebtoken')

app.use(express.json())

const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '!870724',
  database: 'mydatabase',
  port: '3306',
});

app.listen(port, () => {
    console.log('server is working on port localhost:3000')
  })
app.use(express.urlencoded({extended:true}))
app.use(express.json())



db.connect();

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

app.delete('/logout',(req,res) =>{
  refreshTokens = refreshTokens.filter(token => token !==req.body.token)
  res.sendStatus(204)
})

const posts = [
  {
    username: "chanhee123",
    password: "123456",
    email: "ppp940304ppp@gmail.com",
    phonenum: "010-1111-2222"
  },
  {
    username: "chanhee",
    title:"Post 2"
  }
]

app.post('/signIn',(req,res) =>{
  try{
    const NICKNAME = req.body.NICKNAME
    const EMAIL = req.body.EMAIL
    const PASSWORD = req.body.PASSWORD
    const PHONENUMBER = req.body.PHONENUMBER
    db.query('INSERT INTO user (nickname, email, password, phone_number) VALUES (?, ?, ?, ?)',[NICKNAME,EMAIL,PASSWORD,PHONENUMBER])
    res.send('success');
  } catch(err){
    res.send("에러")
  }
  
})

app.get('/posts',authenticateToken,(req,res) =>{
  res.json(posts.filter(post => post.username === req.user.name))
})

app.post('/login',(req,res) =>{
  const EMAIL = req.body.EMAIL
  const PASSWORD = req.body.PASSWORD
  const user = {name:EMAIL,name:PASSWORD}
  
  const accessToken = generateAccessToken(user)
  const refreshToken = jwt.sign(user,process.env.REFRESH_TOKEN_SECRET)
  refreshTokens.push(refreshToken)
  res.json({accessToken:accessToken, refreshToken:refreshToken})
  db.query('SELECT * FROM user WHERE email = ? AND password = ? ',[EMAIL,PASSWORD])
})

function generateAccessToken(user){
  return jwt.sign(user,process.env.ACCESS_TOKEN_SECRET,{expiresIn: '15m'})
}

//토큰의 유효성 검사
function authenticateToken(req,res,next){
  const authHeader = req.headers['authorization']
  const token = authHeader && authHeader.split(' ')[1]
  if (token == null) return res.sendStatus(401)

  jwt.verify(token,process.env.ACCESS_TOKEN_SECRET,(err,user) => {
    if(err) return res.sendStatus(403)
    req.user = user
    next()
  })
}