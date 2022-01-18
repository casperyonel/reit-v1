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
        .then((response) => {
            res.status(200).send(response)
        }).catch(err => console.log(err))
    }, 
    confirmNewWallet: (req, res) => {
        let { wallet_address } = req.body
        try {
            sequelize.query(`
                SELECT exists (SELECT 1 FROM wallets WHERE wallet_address = '${wallet_address}' LIMIT 1);
            `)
            .then(response => {
                res.status(200).send(response)
            }).catch(err => console.log(err))    
        } catch (error) {
            res.status(404).send("404 ERROR FAILED TO CONFIRM IF NEW WALLET")
        }
    },
    addWallet: async (req, res) => {
        console.log(req.body)
        let { bond_class, wallet_address } = req.body
        await sequelize.query(`
            INSERT INTO wallets (wallet_address, bond_class, click_counter, conversion_counter)
            values ('${wallet_address}', '${bond_class}', 0, 0);
        `)
        let walletID = await sequelize.query(`
            SELECT wallet_id FROM wallets
            WHERE wallet_address = '${wallet_address}';
        `)
        await sequelize.query(`
            UPDATE wallets
            SET link = '${baseURL}${walletID[0][0].wallet_id}'
            WHERE wallet_address = '${wallet_address}';
        `)
        .then((response) => {
            res.status(200).send(response)
        }).catch((err) => console.log(err))
    }
}








// I need to first submit the new wallet address so it generates a new ID via serial primary key
// Then I need to use that ID to insert a new link

// I think we create another file create a const callback that returns window.ethereum.address. And when they click submit we call this
// Above keeps everything in main component but uses external components to handle those functions, which we export. 
// That way everything is in one request, we can make it so we wait to wallet address before doing axios.post(/addWallet)


