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
        let { bond_class, wallet_address } = req.body
        sequelize.query(`
            INSERT INTO wallets (wallet_address, bond_class, link, click_counter, conversion_counter)
            values ('0xB1f0e758951A02B24D04dd211d0424445Ae04c5D', '${bond_class}', '${baseURL}'wallets.wallet_id, 0, 0);

            UPDATE wallets
            WHERE wallet_address = '${wallet_address}'
            SET link = ''${baseURL}'newID'????
            generate the link on the frontend and then send that to the backend?
            

        
        `)
        
    }
}

// I need to first submit the new wallet address so it generates a new ID via serial primary key
// Then I need to use that ID to insert a new link

// I think we create another file create a const callback that returns window.ethereum.address. And when they click submit we call this
// Above keeps everything in main component but uses external components to handle those functions, which we export. 
// That way everything is in one request, we can make it so we wait to wallet address before doing axios.post(/addWallet)
