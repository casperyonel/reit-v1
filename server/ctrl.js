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

const baseURL = 'http://localhost:3001/ido?referrer='

module.exports = { 
    updateClickCounter: (req, res) => {
        let { referrer } = req.body
        sequelize.query(`
            UPDATE wallets
            SET click_counter = click_counter + 1
            WHERE wallet_id = ${referrer};
        `).then((response) => {
            res.status(200).send(response)
        }).catch(err => console.log(err))
    }, 
    addWallet: (req, res) => {
        console.log(req.body)
        let { bond_class } = req.body
        sequelize.query(`
            INSERT INTO wallets (wallet_address, bond_class, link, click_counter, conversion_counter)
            values ('0xB1f0e758951A02B24D04dd211d0424445Ae04c5D', '${bond_class}', 'linkgoeshere.com', 0, 0);

            UPDATE wallets
            SET link = ''${baseURL}'newID'
            WHERE wallet_id = :newID

        
        `)
        
    }
}