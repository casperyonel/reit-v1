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
        `)
        .then(response => res.status(200).send(response)).catch(err => console.log(err))
    }, 
    confirmNewWallet: (req, res) => { // Checks if wallet exists already in DB
        let { wallet_address } = req.body
            sequelize.query(`
                SELECT exists (SELECT 1 FROM wallets WHERE wallet_address = '${wallet_address}' LIMIT 1);
            `)
            .then(response => res.status(200).send(response)).catch(err => console.log(err))
    },
    addWallet: async (req, res) => {
        let { bond_class, wallet_address } = req.body
        await sequelize.query(`
            INSERT INTO wallets (wallet_address, bond_class, click_counter, conversion_counter)
            values ('${wallet_address}', '${bond_class}', 0, 0);
        `)
        let walletID = await sequelize.query(`
            SELECT wallet_id FROM wallets
            WHERE wallet_address = '${wallet_address}';
        `)
        // let referralLink = baseURL + walletID[0][0].wallet_id
        await sequelize.query(`
            UPDATE wallets
            SET link = '${baseURL}${walletID[0][0].wallet_id}'
            WHERE wallet_address = '${wallet_address}';
        `)
        .then(response => res.status(200).send(response)).catch(err => console.log(err))
            // res.status(200).send({ response: response, referralLink: referralLink })    
        // ).catch(err => console.log(err))
    },
    updateStats: (req, res) => {
        let { wallet_address } = req.body
        sequelize.query(`
            SELECT link, click_counter, conversion_counter, wallet_address FROM wallets
            WHERE wallet_address = '${wallet_address}';
        `)
        .then(response => res.status(200).send(response)).catch(err => console.log(err))
    }, 
    updateConversionCounter: (req, res) => {
        let { referrer } = req.body
        sequelize.query(`
            UPDATE wallets
            SET conversion_counter = conversion_counter + 1
            WHERE wallet_id = '${referrer}';
        `)
        .then(response => res.status(200).send(response)).catch(err => console.log(err))
    },
    walletRankings: (req, res) => {
        sequelize.query(`
            SELECT wallet_address, (20 - (click_counter * 0.01) - (conversion_counter)) AS ido_price
            FROM wallets
            ORDER BY ido_price ASC;
        `)
        .then(response => res.status(200).send(response[0])).catch(err => console.log(err))
    }
}