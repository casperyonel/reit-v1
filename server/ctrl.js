require('dotenv').config()
const { CONNECTION_STRING } = process.env
const Sequelize = require('sequelize')

const sequelize = new Sequelize(CONNECTION_STRING, {
    dialect: 'postgres', 
    dialectOptions: {
        ssl: {
            rejectUnauthorized: false
        }
    }
})

module.exports = { 
    updateClickCounter: (req, res) => {
        let { id } = req.body
        sequelize.query(`
            UPDATE wallets
            SET click_counter = click_counter + 1,
            WHERE wallet_id = ${id}
    `).then((response) => {
        res.status(200).send(response[0])
    }).catch(err => console.log(err))
    }
}