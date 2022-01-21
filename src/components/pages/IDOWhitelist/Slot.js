
const Slot = ({ details }) => {
  
    const { wallet_address, ido_price } = details
    // This pulls the response data for each wallet off of details, which has the response axios object
    // wallet to check if signed in address = wallet address of that index position. 
    // Need to calc price relative to $20 for column
  



    return ( 
        <>
            <td>{wallet_address}</td>
            <td>{ido_price}</td>
            <td>45.23%</td>
        </>
    )
}

export default Slot;