require('dotenv').config()
const express = require('express')
const app = express()
const cors = require('cors')
const { SERVER_PORT } = process.env
const { seed } = require('./seed')
const { updateClickCounter } = require('./ctrl')
app.use(express.json())
app.use(cors())

// Seed:
app.post('/seed', seed)

// click_counter:
app.put('/clickCounter', updateClickCounter)


app.listen(SERVER_PORT, () => console.log(`Listening on Port ${SERVER_PORT}`))