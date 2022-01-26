import axios from "axios"
import { ethers } from 'ethers'
import queryString from "query-string";
import { useEffect, useState } from "react";
import idowhitelist from "./idowhitelist.scss"
import { useLocation } from "react-router-dom";
import Referralinfo from "./Referralinfo";
import Pricingbox from "./Pricingbox"; 
import Leaderboards from "./Leaderboards";
import MIMlogo from '../../../assets/tokens/MIM.svg'

import PreSale from "../../../../src/artifacts/contracts/PreSale.sol/PreSale.json";
const preSaleAddress = "0x0aB603d04741088904e67bD49b87f18329a5F8c7";
const DAIToken = '0x4F96Fe3b7A6Cf9725f59d353F723c1bDb64CA6Aa';
 
const IDOWhitelist = () => {
    const { search } = useLocation()
    const { referrer } = queryString.parse(search)
    const [order, setOrder] = useState('') // For bond class
    const [referralLink, setReferralLink] = useState('') // For showing referralLink info
    const [stats, setStats] = useState('') // For showing stats for existing users
    const [walletConnected, setWalletConnected] = useState(false)
    const [walletAddress, setWalletAddress] = useState('')
    
    // Connect metamask:
    async function requestAccount() {
        if (typeof window.ethereum !== 'undefined') {
            const account = await window.ethereum.request({ method: 'eth_requestAccounts' }) // User sign in
            setWalletConnected(true)
            return account[0]
        }
    }

    // Called at page load if they are an existing buyer:
    async function updateStats() {
        let wallet_address = await requestAccount()
        setWalletConnected(true)
        axios.put('http://localhost:3000/confirmNewWallet', ({ wallet_address: wallet_address }))
        .then(async res => {    
            console.log(res.data[0][0].exists)
            if (res.data[0][0].exists) {
                await axios.put('http://localhost:3000/updateStats', ({ wallet_address: wallet_address }))
                .then(response => {
                    // IF USER SWITCHES WALLETS WE NEED TO HANDLE THAT, THIS NEEDS TO UDPATE!
                    setReferralLink(response.data[0][0].link)
                    setStats({
                        click_counter: response.data[0][0].click_counter,
                        conversion_counter: response.data[0][0].conversion_counter,
                        link: response.data[0][0].link,
                        wallet_address: wallet_address,
                        ido_price: (20 - (Math.floor(response.data[0][0].click_counter) * 0.01) - (Math.floor(response.data[0][0].conversion_counter) * 1)).toFixed(2)
                    })
                })
                .catch(err => console.log(err))
            } else {
                return // They haven't purchased IDO before, so just proceed
            }
        }).catch(err => console.log(err)) 
    }

    useEffect(() => {
        if (referrer) { // Checks if URL has a referrer and updates referral_counter for referralLink owner
            axios.put('http://localhost:3000/updateClickCounter', { referrer: referrer }) // This runs on axios server to backend. While backend feeds the "link" in DB with actual website URL. That needs to change, this deosn't. 
            .then(response => console.log(response.data)) // Await?
            .catch(error => console.log(error))
            // WRITE AN AND STATEMENT HERE TO GET RID OF SPAMS / PAGE RELOADS!
        }
        updateStats()
        // console.log(Document.referrer)
    }, [])
       
    // Upon purchase of IDO, make sure new wallet then add wallet:
    const submit = async () => {
        if (!order) {
            alert('You are trying to mint $REIT but havent selected a class!')
            return
        } 
        if (window.ethereum) {
            try {
                // Sign into wallet and confirm wallet doesn't already exist:
                let wallet_address = await requestAccount()
                setWalletAddress(wallet_address)
                setWalletConnected(true)
                await axios.put('http://localhost:3000/confirmNewWallet', ({ wallet_address: wallet_address }))
                    .then(async res => {
                        if (res.data[0][0].exists) { // If wallet is already in DB column wallet_address, don't proceed. 
                            alert('YOU ALREADY PURCHASED IN THE IDO') // MAKE THIS A POP OUT BOX. 
                            return
                        } else {
                            // Add wallet to DB and generate new referral link:
                            await axios.post('http://localhost:3000/addWallet', { bond_class: order, wallet_address: wallet_address })
                            .then(res => {
                                console.log(res.data)
                            })
                            .catch(err => console.log(err))
                            // Send either 500 or 1000 DAI to IDO contract:
                            if (typeof window.ethereum !== 'undefined') {
                                const provider = new ethers.providers.Web3Provider(window.ethereum)
                                const signer = provider.getSigner()
                                const contract = new ethers.Contract(preSaleAddress, PreSale.abi, signer)
                                const transaction = await contract.purchaseIDO((order === 'A' ? 500 : 1000), DAIToken)
                                await transaction.wait()
                                console.log(`${order} DAI successfully sent to IDO contract`)                                 
                            }                            
                            // Lastly, give credit to successful referral by incrementing conversion_counter in DB with referrer from query:
                            if (referrer) {
                                axios.put('http://localhost:3000/updateConversionCounter', { referrer: referrer }) // This runs on axios server to backend. While backend feeds the "link" in DB with actual website URL. That needs to change, this deosn't. 
                                    .then(response => console.log(response.data)) 
                                    .catch(error => console.log(error))
                            }
                            // Update Pricingbox stats with referral and current IDO price from DB:
                            await axios.put('http://localhost:3000/updateStats', ({ wallet_address: wallet_address }))
                            .then(response => {
                                // IF USER SWITCHES WALLETS WE NEED TO HANDLE THAT, THIS NEEDS TO UDPATE!
                                setReferralLink(response.data[0][0].link)
                                setStats({
                                    click_counter: response.data[0][0].click_counter,
                                    conversion_counter: response.data[0][0].conversion_counter,
                                    link: response.data[0][0].link,
                                    wallet_address: wallet_address,
                                    ido_price: (20 - (Math.floor(response.data[0][0].click_counter) * 0.01) - (Math.floor(response.data[0][0].conversion_counter) * 1)).toFixed(2)
                                })
                            })
                            .catch(err => console.log(err))
                        } setOrder('')
                    }).catch(err => console.log(err))
            } catch {
                await requestAccount()
            }
        }  
    }

    return (
        <div className="outer">
              <div className="box-left-1">
                  <div className="box-left-2">
                      <div className="box-left-3">
                          <div className="box-left-4a">
                                <div className="top-4a">
                                    <span id='select-amount'>Secure your spot:</span>
                                    <span className='exchange-rate-container'>
                                         
                                        <span>20 MIM = 1 REIT</span>
                                    </span>
                                </div>
                                <div className="middle1-4a">
                                    <form action="click">
                                        
                                        
                                        <span className={`${order === 'A' ? 'clicked-outlined' : '' } btn-class-a`}  onClick={() => setOrder('A')} >                                            
                                            <label className='class-label'htmlFor="class-a">Class A:</label>
                                            <label className='class-label'htmlFor="class-a">500</label>
                                            <label className='class-label'htmlFor="class-a"><img className="mim-logo-class" src={MIMlogo} alt="mimlogo" /></label>
                                        </span>
                                    </form>
                                </div>
                                <div className="middle2-4a">
                                    <form action="click">
                                        <span className={`${order === 'B' ? 'clicked-outlined' : '' } btn-class-b`} onClick={() => setOrder('B')} >
                                            <label className='class-label'htmlFor="class-a">Class B:</label>
                                            <label className='class-label'htmlFor="class-a">1,000</label>
                                            <label className='class-label'htmlFor="class-a"><img className="mim-logo-class" src={MIMlogo} alt="mimlogo" /></label>
                                        </span>   
                                    </form>
                                </div>
                                
                            </div>
                            <div className="top-4b">
                                <button id='submit-btn' onClick={walletConnected ? submit : requestAccount}>{walletConnected ? 'Submit order' : 'Connect wallet'}</button>
                                {/* <button id='submit-btn' onClick={submit}>Submit order</button> */}
                            </div>
                            <div className="bottom-4a">
                                    <em id='note-text'>Note: Both classes represent an IDO price of $20 per share. This can be lowered by referring others to join. Upon referrals, your total purchase amount (either 500 DAI or 1,000 DAI) will remain the same, but you will receive more $REIT tokens.
                                    <br/>Read more about how to lower your IDO price <a className="link-txt" rel="noreferrer" target='_blank' href="https://medium.com/@REITDAO"> here.</a></em>
                            </div> 
                        </div>
                        <div className="box-right-3">
                        <div className="box-left-2-right">
                                {referralLink === ''? null : <Referralinfo referralLink={referralLink} />}        
                                {referralLink === ''? null : <Pricingbox stats={stats} setStats={setStats} />}
                        </div>
                        </div>
                    </div>
                  
              </div>
              
              
              <div className="box-right-1">
                    <div className="box-right-2">
                        <div className="box-right-2-top">
                            <div className="box-right-2-left">
                                <h2 className="leaderboards-header-leaderboards">
                                    <div className="top-header-leaderboards">
                                        <span>Rankings</span>
                                        <span className="leaderboards-header-in-progress">NOT STARTED</span> <br />
                                    </div>
                                    <h3 className="leaderboards-header-time">Mar 9, 18:00 UTC - Mar 16, 18:00 UTC</h3>
                                </h2>

                                

                            </div>
                            <Leaderboards stats={stats} />
                        </div>
                    </div>
              </div>

              
        </div>
    )
}

export default IDOWhitelist