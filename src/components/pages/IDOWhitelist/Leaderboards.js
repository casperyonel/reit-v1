import { useState, useEffect } from "react"; 
import axios from "axios";
import Slot from "./Slot";

const Leaderboards = ({ stats }) => {

    let [arrayOfWallets, setArrayOfWallets] = useState([]) // Store DB array of wallets
    let signedInWallet = stats.wallet_address // Use this to highlight the user's wallet in rankings

    useEffect(() => {
        axios.get('http://localhost:3000/walletRankings')
            .then(response => {
                console.log(response.data)
                // setArrayOfWallets(response.data)
            }).catch(error => console.log (error))
    }, [])

    const walletsMapped = arrayOfWallets.map(wallet => {
        return ( 
            <div key={wallet.index}>
                <Slot details={wallet}/>
            </div>
        )
    })

    return (
            <div id='main-container'>
                {walletsMapped}
            </div>
    ) 
};

export default Leaderboards;
