import { useState, useEffect } from "react"; 
import axios from "axios";
import Slot from "./Slot";

const Leaderboards = ({ stats }) => {

    let [arrayOfWallets, setArrayOfWallets] = useState([]) // Store DB array of wallets
    // let [highlightedWallet, setHighlightedWallet] = useState('') // Current user's wallet to highlight

    useEffect(() => {
        axios.get('http://localhost:3000/walletRankings')
            .then(response => {
                setArrayOfWallets(response.data)
            }).catch(error => console.log(error))
        // setHighlightedWallet(stats.wallet_address) // Not sure I want to highlight the user's wallet actually
    }, [])

    const walletsMapped = arrayOfWallets.map(wallet => {
        return <tr className="leaderboard-row" key={wallet.wallet_address}>
                    <Slot details={wallet} />
                    {/* {highlightedWallet === wallet.wallet_address ? <div>THIS IS THE GOLDEN WALLET</div> : null} */}
               </tr>  
    })

    return (
            <table className="rankings-table">
                <thead>
                    <tr>
                        <th>Rank</th>
                        <th>Wallet</th>
                        <th>% Change</th>
                        <th>IDO Price</th>
                    </tr>
                </thead>
                <tbody>
                    {walletsMapped}
                </tbody>
            </table>
    )
};

export default Leaderboards;