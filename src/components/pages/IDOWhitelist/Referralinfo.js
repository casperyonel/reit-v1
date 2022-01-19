 

const Referralinfo = ({ referralLink }) => {
    
    return (
        <>
            <div className="middle1-4b">
                <span>Your initial IDO price is $20. Want to lower your price?</span>
                {/* THIS SHOULDN'T SHOW UP WHEN YOU LOG BACK IN THOUGH */}
            </div>

            <div className="middle2-4b">
                <div className="top-middle2-4b">
                    <span id='refer-others-text'>Refer others with your unique link:</span>
                </div>
                <div className="bottom-middle2-4b">
                    <span id='refer-others-box'>
                        <span id='refer-others-link'>{referralLink}
                            <span id='refer-others-copy'>Copy</span>
                        </span>
                    </span>
                </div>
            </div>
            <div className="bottom-4b">
                <p id='the-more-referrals-text'>Here's how it works</p>
                <p className='referral-explainer-text'>Each successful referral = 1 DAI off IDO price</p>
                <p className='referral-explainer-text'>Each click on your referral link = 0.05 DAI off IDO price</p>
                <p id='note-referrals-text'>Note: Successful Referrals represent referrals that resulted in a purchase of our IDO.</p>
            </div>
        </>
    )
}

export default Referralinfo
