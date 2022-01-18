import axios from "axios"
import idowhitelist from "./idowhitelist.scss"
import { useEffect, useState } from "react";
import { useLocation } from "react-router-dom";
import queryString from "query-string";
import { ethers } from 'ethers'

const IDOWhitelist = () => {
    const { search } = useLocation()
    const { referrer } = queryString.parse(search)
    const [order, setOrder] = useState('')
    console.log(order)
        
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
                // WILL NEED TO ADD SIGNER AND CONTRACT FUNCTION LOGIC HERE!
                axios.post('/addWallet', { bond_class: order, wallet_address: wallet_address })
                    .then(res => console.log(res))
                    .catch(err => console.log(err))
            } catch {
                await requestAccount()
            }
        }
        //     const provider = new ethers.providers.Web3Provider(window.ethereum)
        //     const signer = provider.getSigner()
        //     // const contract = new ethers.Contract(contractName, contractName.abi, signer)
        //     // const transaction = await contract.function(order)
        //     setOrder('')
        //     // await transaction.wait()
        // }
    }

   
     









            
            // here we do an axios call with bond class to back end, and wallet address, and 
            // do async await to figure out referral link for this new wallet addres by axios.get('/wallet_id)
            // then need to display that you have successfully minted X number of REIT! 
            // Here is your referral link
        // }


    // 1. Update state when clicked, then submit that state when submit is clicked (problem here is that 
        // they could submit a state of nothing, need to catch this error (just make sure something is in state, otherwise tell them
        // to please select an option!)
    // 2.  Better route is to tie the span buttons in a form to the submit button?



    
    
    // Upon click of submit, if referrer id is empty, then insert into DB with new wallet_id and 
    // address, and class bonded.
    
    
    // Upon click of submit, update the conversion_counter of the query id to conversion_counter. 

    return (
        <div className="outer">
              <div className="box-left-1">
                  <div className="box-left-2">
                      <div className="box-left-3">
                          <div className="box-left-4a">
                                
                                <div className="top-4a">
                                    <span id='select-amount'>Select Purchase Amount:</span>
                                    
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
                          <div className="box-left-4b">
                                <div className="top-4b">
                                    
                                    <button id='submit-btn' onClick={submit}>Submit Order</button>
                                
                                </div>
                                <div className="middle1-4b">
                                 
                                </div>
                                <div className="middle2-4b"></div>
                                <div className="bottom-4b"></div>       
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