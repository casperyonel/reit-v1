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
    seed: (req, res) => {
        sequelize.query(`
        CREATE TABLE wallets (
        wallet_id SERIAL PRIMARY KEY, 
        wallet_address varchar(64) UNIQUE NOT NULL,
        bond_class varchar(1), 
        link varchar(200) UNIQUE,
        referral_counter int);
        
        INSERT INTO wallets (wallet_address, bond_class, link, referral_counter)
        values ('0xB1f0e758951A02B24D04dd211d0424445Ae04c5C', 'A', 'linkgoeshere.com', 1)
        `).then(() => {
            console.log('Seed successful')
            res.sendStatus(200)
        }).catch(err => console.log('Error while seeding', err))
    }
}