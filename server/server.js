require('dotenv').config()
const express = require('express')
const app = express()
const cors = require('cors')
const { SERVER_PORT } = process.env
const { seed } = require('./seed')
app.use(express.json())
app.use(cors())

// Seed:
app.post('/seed', seed)

app.listen(SERVER_PORT, () => console.log(`Listening on Port ${SERVER_PORT}`))