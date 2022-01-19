import axios from "axios"
import { useEffect, useState } from "react"

const Pricingbox = ({ stats }) => {
    
    // Make a state initialize to 8
    // function that uses setTimeOut that counts down and is set equal to the state
    // cb of that settimeout woudl be to change the state to the next lowest number
    // then, when state = 0, trigger axios call to updateStats
    // axios call would be an if block, if state = 0, then make the axios call, and based on useEffect current ido price will change

    const [countdown, setCountdown] = useState('')

    let newStats = { ...stats }
    setInterval(() => { countdown = 0 }, 5000)

    if (countdown === 0) {
        axios.put('http://localhost:3000/updateStats', ({ wallet_address: newStats.wallet_address }))
            .then(response => {
                newStats = {
                    click_counter: response.data[0][0].click_counter,
                    conversion_counter: response.data[0][0].conversion_counter,
                    link: response.data[0][0].link
                }
                console.log(newStats)
            }).catch(err => console.log(err))
    }
    
    // Current IDO Price calculation:
    const [currentIDOPrice, setCurrentIDOPrice] = useState(20)

    useEffect(() => {
        function updateCurrentIDOPrice() {
            setCurrentIDOPrice((20 - (Number(newStats.click_counter) * 0.01) - (Number(newStats.conversion_counter) * 1)))
        }   
        updateCurrentIDOPrice()
    }, [currentIDOPrice])
    
    return (
        <div className="pricing-box-1">
            <div className="pricing-box-1-top">
                
                <div className="pricing-box-1-top-container">
                    Refreshes in {countdown} seconds.
                    
                </div>

                <div className="pricing-box-1-top-text">
                    <span>Your initial IDO price</span>
                    <span>20 DAI</span>
                </div>
            </div>           
            <div className="pricing-box-1-middle1">
                <span>Succesful Referrals</span>
                <span>{stats.conversion_counter}</span>
            </div>           
            <div className="pricing-box-1-middle2">
                <span>Link Shares</span>
                <span>{stats.click_counter}</span>
            </div>           
            <div className="pricing-box-1-bottom">
                <span>Your current IDO price</span>
                <span>{currentIDOPrice}</span>
            </div>           
        </div>
    )
}

export default Pricingbox
