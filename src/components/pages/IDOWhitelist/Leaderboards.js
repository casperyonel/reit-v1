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
                    <td>{arrayOfWallets.indexOf(wallet) + 1}</td>
                    <Slot details={wallet} />
                    {/* {highlightedWallet === wallet.wallet_address ? <div>THIS IS THE GOLDEN WALLET</div> : null} */}
               </tr>  
    })

    return (
            <table style={{width: "100%"}} className="rankings-table">
                 <colgroup >
                    <col span='1' style={{width: "10%"}}/>
                    <col span='1' style={{width: "60%"}}/>
                    <col span='1' style={{width: "20%", display: "flex", justifyContent: "center"}}/>
                    <col span='1' style={{width: "15%"}}/>
                 </colgroup>
                <thead>
                    <tr className="leaderboards-header">
                        <th id="rank-column" className="leaderboards-header-text">Rank</th>
                        <th id="wallet-column" className="leaderboards-header-text">Wallet</th>
                        <th id="change-column" className="leaderboards-header-text">% Change</th>
                        <th id="ido-price-column" className="leaderboards-header-text">IDO Price</th>
                    </tr>
                </thead>
                <tbody>
                    {walletsMapped}
                </tbody>
                
            </table>
    )
};

export default Leaderboards;