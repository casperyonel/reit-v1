import axios from "axios"
import { ethers } from 'ethers'
import queryString from "query-string";
import { useEffect, useState } from "react";
import idowhitelist from "./idowhitelist.scss"
import { useLocation } from "react-router-dom";
import Referralinfo from "./Referralinfo";

const IDOWhitelist = () => {
    const { search } = useLocation()
    const { referrer } = queryString.parse(search)
    const [order, setOrder] = useState('')
    const [showReferralInfo, setShowReferralInfo] = useState(true)
        
    async function requestAccount() {
        if (typeof window.ethereum !== 'undefined') {
            const account = await window.ethereum.request({ method: 'eth_requestAccounts' }) // User sign in
            return account[0]
        } 
    }

    useEffect(() => {
        if (referrer) {
            axios.put('http://localhost:3000/clickCounter', { referrer: referrer }) // This runs on axios server to backend. While backend feeds the "link" in DB with actual website URL. That needs to change, this deosn't. 
            .then(response => console.log(response.data)) // Await?
            .catch(error => console.log(error))
        }
           
        requestAccount()
  }, [])

    const submit = async () => {
        if (!order) {
            alert('You are trying to mint $REIT but havent selected a class!')
            return
        } 
        if (window.ethereum) {
            try {
                let wallet_address = await requestAccount()
                await axios.put('http://localhost:3000/confirmNewWallet', ({ wallet_address: wallet_address }))
                    .then(async res => {
                        if (res.data[0][0].exists) { // True if wallet is already in DB. 
                            return
                        } else {
                            await axios.post('http://localhost:3000/addWallet', { bond_class: order, wallet_address: wallet_address })
                            .then(res => console.log(res))
                            .catch(err => console.log(err))
                        //     Else complete transaction and add wallet in DB. 
                        //     const provider = new ethers.providers.Web3Provider(window.ethereum)
                        //     const signer = provider.getSigner()
                        //     const contract = new ethers.Contract(contractName, contractName.abi, signer)
                        //     const transaction = await contract.function(order)
                        //     setOrder('')
                        //     await transaction.wait()
                        //     Set new state (true) of showReferralLink after successful transaction here. 
                        //     WILL NEED TO ADD SIGNER AND CONTRACT FUNCTION LOGIC HERE!
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
                                    <span className='exchange-time-container'>
                                        <span id='refresh'>Refreshes in 8 seconds</span>
                                        <span id='exchange-rate'>20 DAI = 1 REIT</span>
                                    </span>
                                </div>
                                <div className="middle1-4a">
                                    <form action="click">
                                        <span className='btn-class-a' onClick={() => setOrder('A')}>
                                            <label className='class-label'htmlFor="class-a">Class A:</label>
                                            <label className='class-label'htmlFor="class-a">500</label>
                                            <label className='class-label'htmlFor="class-a">DAI</label>
                                        </span>
                                    </form>
                                </div>
                                <div className="middle2-4a">
                                    <form action="click">
                                        <span className='btn-class-b' onClick={() => setOrder('B')}> 
                                            <label className='class-label'htmlFor="class-a">Class B:</label>
                                            <label className='class-label'htmlFor="class-a">1,000</label>
                                            <label className='class-label'htmlFor="class-a">DAI</label>
                                        </span>   
                                    </form>
                                </div>
                                <div className="bottom-4a">
                                    <p id='note-text'>Note: Both classes represent an IDO price of $20 per share. This can be lowered by referring others to join. Upon referrals, your amount spent (either 500 or 1,000 DAI) will remain the same, but you will be airdropped more $REIT tokens. 
                                    <br /> Read more about how to lower your IDO price here.</p>
                                </div> 
                          </div>
                          <div className="box-left-4b" >
                                <div className="top-4b">
                                    <button id='submit-btn' onClick={submit}>Submit order</button>
                                </div>
                            {showReferralInfo? <Referralinfo /> : null}

                               {/* once posted, we set referralInfo = true
                               this component here will only show when prop in it (referralInfo = true)
                               So we control the process of showing the div or not in here with true = referralInfo
                               But whats actually shown is all in another component.  */}

                                
                                
                                    
                            </div>
                      </div>
                  </div>
              </div>
              <div className="box-right-1">
                  <div className="box-right-2">
                      <div className="box-right-3">
                          <div className="slot"></div>
                          {/* Make this a seperate component */}
                          <div className="slot"></div>
                          <div className="slot"></div>
                          <div className="slot"></div>
                          <div className="slot"></div>
                          <div className="slot"></div>
                          <div className="slot"></div>
                          <div className="slot"></div>
                          <div className="slot"></div>
                          <div className="slot"></div>
                          <div className="slot"></div>
                          <div className="slot"></div>
                          <div className="slot"></div>
                          <div className="slot"></div>
                          <div className="slot"></div>
                          <div className="slot"></div>
                          <div className="slot"></div>
                          <div className="slot"></div>
                      </div>
                  </div>
              </div>
        </div>
    )
}

export default IDOWhitelist