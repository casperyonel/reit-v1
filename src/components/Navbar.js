import Main from "./Main"
import { Link } from "react-router-dom"

// import component home pages from /pages folder

const Navbar = () => {
    return (
        <div>
            
            <nav>
                <Link to='/'>Home</Link>
                <Link to='/ido'>IDOWhitelist</Link>
                <Link to='/leaderboards'>Leaderboards</Link>
            </nav>
            
        </div>
    )
}

export default Navbar
