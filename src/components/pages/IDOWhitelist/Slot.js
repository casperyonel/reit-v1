

const Slot = ({ details, signedInWallet }) => {
  
    let signedInWallet = signedInWallet

    const { click_counter, conversion_counter, wallet_address } = details
    // This pulls the response data for each wallet off of details, which has the response axios object
    // Also need to rank these somehow, maybe we do that in the mappping
    // First calculate price, then map?
    // Make another div that has an if statement for each mapped 
    // wallet to check if signed in address = wallet address of that index position. 
  
    return ( 
    <div>
        <div>{click_counter}</div>
        <div>{conversion_counter}</div>
    </div>
    )
}

export default Slot;
