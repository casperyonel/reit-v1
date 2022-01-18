require('dotenv').config()
const express = require('express')
const app = express()
const cors = require('cors')
const { SERVER_PORT } = process.env
const { seed } = require('./seed')
app.use(express.json())
app.use(cors())

const { updateClickCounter, addWallet } = require('./ctrl')

// Seed:
app.post('/seed', seed)

// Increment click_counter for existing wallet:
app.put('/clickCounter', updateClickCounter)

// Add wallet
app.post('/addWallet', addWallet)


app.listen(SERVER_PORT, () => console.log(`Listening on Port ${SERVER_PORT}`))