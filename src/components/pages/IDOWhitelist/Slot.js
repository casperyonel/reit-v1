
const Slot = ({ details }) => {
  
    const { wallet_address, ido_price } = details

    return ( 
        <>
            <td>{wallet_address.slice(0, 4)}....{wallet_address.slice(38, 42)}</td>
            {(((20 - Number(ido_price)) / Number(ido_price)).toFixed(2) > 0) ? <td className="percent-green">+{((20 - Number(ido_price)) / Number(ido_price)).toFixed(2)}%</td> : <td className="percent-flat">-</td>}
            <td>{ido_price}</td>
        </>
    )
}

export default Slot;