import { Link } from "react-router-dom"
import logo from "../assets/reit-visuals/monopoly-man-color-2.png"

// import component home pages from /pages folder

const Navbar = () => {
    return (
        <div className="header-full">
            <div className="header-left">
                <img src={logo} alt="" />
            </div>
            <div className="header-right">
                <nav>
                {/* dYdX has Link -> Button -> p tag */}
                    <Link to='/'></Link>
                    <Link to='/ido'>IDOWhitelist</Link>
                    <Link to='/leaderboards'>Leaderboards</Link>
                </nav>
            </div>
        </div>
    )
}

export default Navbar
