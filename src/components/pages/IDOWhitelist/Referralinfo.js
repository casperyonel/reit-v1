 

const Referralinfo = ({ referralLink }) => {
    
    async function copyLink() {
        await navigator.clipboard.writeText(referralLink)
        // alert('Copied!')
    }

    return (
        <>
            <div className="middle1-4b">
                <span>Want to lower your IDO price?</span>
            </div>

            <div className="middle2-4b">
                <div className="top-middle2-4b">
                    <span id='refer-others-text'>Refer others with your unique link</span>
                </div>
                <div className="bottom-middle2-4b">
                    <span id='refer-others-box'>
                        <span id='refer-others-link'>{referralLink}</span>
                        <span onClick={copyLink} id='refer-others-copy'>Copy</span>
                    </span>
                </div>
            </div>
            <div className="bottom-4b">
                <p id='the-more-referrals-text'>Here's how it works:</p>
                <p className='referral-explainer-text'><span className="purple-text">$1 off IDO price for every </span>successful referral</p>
                <p className='referral-explainer-text'><span className="purple-text">$0.01 off IDO price for every</span> click on your unique link</p>
                <em id='note-referrals-text'>Note: Successful Referrals are referrals that resulted in a purchase of our IDO.</em>
            </div>
        </>
    )
}

export default Referralinfo
