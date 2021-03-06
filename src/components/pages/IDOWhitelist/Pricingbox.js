import axios from "axios"
import { useEffect, useState } from "react"

const Pricingbox = ({ stats, setStats }) => {

    let [timer, setTimer] = useState(10) // Countdown (1/2)
    localStorage.setItem("wallet_address", stats.wallet_address)

    useEffect(() => {
        const interval = setInterval(() => setTimer(timer - 1), 1000)
        if (timer === 0) {
            async function updateNewStats() {
                await axios.put('http://localhost:3000/updateStats', ({ wallet_address: localStorage.getItem('wallet_address') }))
                    .then(response => {
                        setStats({
                            click_counter: response.data[0][0].click_counter,
                            conversion_counter: response.data[0][0].conversion_counter,
                            link: response.data[0][0].link,
                            wallet_address: response.data[0][0].wallet_address,
                            ido_price: (20 - (Math.floor(response.data[0][0].click_counter) * 0.01) - (Math.floor(response.data[0][0].conversion_counter) * 1)).toFixed(2)
                        })
                    }).catch(err => console.log(err))
            }
            updateNewStats()
            setTimer(10) // Coutdown (2/2)
        }
        return () => clearInterval(interval)
    }, [timer]) // Rendering useEffect every seconds, since this is [timer]
    
    return (
        <div className="pricing-box-1">
            <div className="pricing-box-1-top">
                <div className="pricing-box-1-top-container"> 
                        {/* The below is for 1) red color of countdown, 2) second vs. seconds */}
                        {timer === 1 ? <span className="singular-timer">Refreshes in 
                        <span className="red-txt"> {timer} second</span>
                        </span> : <span>Refreshes in 
                        <span className="red-txt"> {timer} seconds</span>
                        </span>}
                </div>
                <div className="pricing-box-1-top-text">
                    <span>Your initial IDO price</span>
                    <span className="right-text-pricing-thin">20.00 MIM</span>
                </div>
            </div>           
            <div className="pricing-box-1-middle1">
                <span>Successful Referrals</span>
                <span className="right-text-pricing-thin">{stats.conversion_counter}</span>
            </div>           
            <div className="pricing-box-1-middle2">
                <span>Link Shares</span>
                <span className="right-text-pricing-thin">{stats.click_counter}</span>
            </div>           
            <div className="pricing-box-1-bottom">
                <span>Your current IDO price</span>
                <span className="right-text-pricing-thin">{stats.ido_price} MIM</span>
            </div>           
        </div>
    )
}

export default Pricingbox
