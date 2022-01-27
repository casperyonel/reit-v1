import './navbar.scss'
import logo from "../assets/reit-visuals/monopoly-man-color-2.png"
import {Nav, NavLink, Bars, NavMenu, NavBtnLink} from './NavbarElements'

// import component home pages from /pages folder

const Navbar = () => {
    
    return (
            <Nav>
                <NavLink to='/'>
                    <img id='logo' src={logo} alt="logo" />
                </NavLink>
                <Bars />
                <NavMenu>
                 <NavLink to='/leaderboards' activestyle="true">Leaderboards</NavLink>
                   <NavLink to='/howtoplay' activestyle="true">How To Play</NavLink>
                   <a className='external-nav-element' href="https://medium.com/@REITDAO" target='_blank' rel="noopener noreferrer">Blog</a>
                   <a className='external-nav-element' href="https://medium.com/@REITDAO" target='_blank' rel="noopener noreferrer">Discord</a>
                   <NavBtnLink to='/ido'>IDO Whitelist</NavBtnLink>
                </NavMenu>
            </Nav>
    )
}

export default Navbar