import { BsFillTriangleFill } from "react-icons/bs"
import MIMlogo from '../../../assets/tokens/MIM.svg'


const Slot = ({ details }) => {
  
    const { wallet_address, ido_price } = details

    return ( 
        <>
            
            <td>{wallet_address.slice(0, 6)}....{wallet_address.slice(38, 42)}</td>
            {(((20 - Number(ido_price)) / Number(ido_price)).toFixed(2) > 0) ? <td className="percent-green">  <BsFillTriangleFill className="up-arrow"/>     {((20 - Number(ido_price)) / Number(ido_price)).toFixed(2)}%</td> : <td className="percent-flat">-</td>}
            <td>{ido_price} <img id='mim-logo' src={MIMlogo} alt="mimlogo" /></td>
        </>
    )
}

export default Slot;