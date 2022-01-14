require('dotenv').config()
const express = require('express')
const app = express()
const cors = require('cors')
const { SERVER_PORT } = process.env

app.use(express.json())
app.use(cors())

app.listen(SERVER_PORT, () => console.log(`Listening on Port ${SERVER_PORT}`))