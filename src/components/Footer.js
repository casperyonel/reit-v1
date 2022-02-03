
import { FaGithub, FaMedium, FaEnvelope } from "react-icons/fa"
import { BsTwitter, BsDiscord } from 'react-icons/bs'

const Footer = () => {
    return (
        <div className="footer">
        
            {/* <h1>footer</h1> */}

            <FaGithub /> 
            <FaMedium />
            <BsDiscord />
            <BsTwitter />
            <FaEnvelope />
        </div>
    )
}

export default Footer