import axios from "axios"
import idowhitelist from "./idowhitelist.scss"
import { useEffect, useState } from "react";
import { useLocation } from "react-router-dom";
import queryString from "query-string";

const IDOWhitelist = () => {
    const { search } = useLocation()
    const { referrer } = queryString.parse(search)
    // // Pulls query string from URL and then parses id off query. 
    console.log(search, referrer)
    
    useEffect(() => {
        axios.put('http://localhost:3000/clickCounter', { referrer: referrer })
       .then(response => console.log(response.data))
       .catch(error => console.log(error))
    }, [])
    // Change axios.put before deploying. Consider a seperate Heroku for just axios calls.
    // Async await?
    
    
    
    const [order, setOrder] = useState('')






    
    
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
                                    <span className='btn-class-a'>
                                        <label className='class-label'htmlFor="class-a">Class A:</label>
                                        <label className='class-label'htmlFor="class-a">500</label>
                                        <label className='class-label'htmlFor="class-a">DAI</label>
                                    </span>
                                </form>
                                
                                </div>
                                
                                <div className="middle2-4a">

                                <form action="click">
                                    <span className='btn-class-b'> 
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
                                    <button id='submit-btn'>Submit Order</button>
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