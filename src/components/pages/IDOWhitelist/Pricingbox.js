import axios from "axios"
import { useEffect, useState } from "react"

const Pricingbox = ({ stats, setStats }) => {

    // Current IDO Price calculation:
    const [currentIDOPrice, setCurrentIDOPrice] = useState(20)
    let [timer, setTimer] = useState(8)
 
    localStorage.setItem("wallet_address", stats.wallet_address)
    function updateNewStats() {
        axios.put('http://localhost:3000/updateStats', ({ wallet_address: localStorage.getItem('wallet_address') }))
            .then(response => {
                console.log(response)
                setStats( {
                    click_counter: response.data[0][0].click_counter,
                    conversion_counter: response.data[0][0].conversion_counter,
                    link: response.data[0][0].link,
                    wallet_address: response.data[0][0].wallet_address
                } )
            }).catch(err => console.log(err))
    }
    // useEffect(() => {
        
    //     const interval = setInterval(updateNewStats, 10000) // For updating stats
    //     return () => {
    //         clearInterval(interval)
             
    //     }
    // }, [])

    useEffect(() => {
        const interval = setInterval(() => setTimer(timer - 1), 1000)
        if (timer === 0) {
            updateNewStats()
            setTimer(10) // Coutdown length
        }
        return () => {
            clearInterval(interval)
        }
    }, [timer]) // Rendering useEffect every seconds, since this is [timer]

    useEffect(() => {
        function updateCurrentIDOPrice() {
            setCurrentIDOPrice((20 - (Number(stats.click_counter) * 0.01) - (Number(stats.conversion_counter) * 1)))
        }
        updateCurrentIDOPrice()
    }, [currentIDOPrice])

    return (
        <div className="pricing-box-1">
            <div className="pricing-box-1-top">
                
                <div className="pricing-box-1-top-container">
                    Refreshes in {timer} seconds
                </div>

                <div className="pricing-box-1-top-text">
                    <span>Your initial IDO price</span>
                    <span>20 DAI</span>
                </div>
            </div>           
            <div className="pricing-box-1-middle1">
                <span>Successful Referrals</span>
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
