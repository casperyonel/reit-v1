import "./homepage.scss";
import mainMonopolyDashboard from "../../../assets/reit-visuals/outer-main-dashboard (4).png";

import { BsChevronDoubleDown } from 'react-icons/bs'


const Homepage = () => {
    return (
            <div className="outer-main">
                
                <div className="outer-top">
                    <div className="outer-top-left-1">
                        <div className="outer-top-left-2">
                            <h1 className="top-header-text">Monopoly, in the metaverse</h1>
                                <div className="top-subheader-text">REIT DAO is the first Metaverse Land Investment DAO, <span className="top-subheader-text-2">operating like Monopoly.</span></div>
                            
                            <a href="#how-it-works" className="how-it-works-container">
                                <div className="how-it-works">How it works <BsChevronDoubleDown className="down-arrow" /> </div>
                            </a>
                                
                            
                        </div>
                    </div>
                    <div className="outer-top-right-1">
                        <div className="outer-top-right-2"> 
                            <img id="mainMonopolyDashboard" src={mainMonopolyDashboard} alt="monopoly-dashboard" />
                        </div>     
                    </div>
                </div>


                <div className="outer-middle" id="how-it-works">

                    <div className="outer-middle-left-1">
                        <div className="outer-middle-left-2"></div>
                    </div>
                    <div className="outer-middle-right-1">
                        <div className="outer-middle-right-2">
                            <div className="land-card">Card 1</div>
                            <div className="land-card">Card 2</div>
                            <div className="land-card">Card 3</div>
                            <div className="land-card">Card 4</div>
                            <div className="land-card">Card 5</div>
                            <div className="land-card">Card 6</div>

                            
                        </div>     
                    </div>
                </div>

                <div className="outer-bottom">
                    <div className="outer-bottom-left-1">
                        <div className="outer-bottom-left-2"></div>
                    </div>
                    <div className="outer-bottom-right-1">
                        <div className="outer-bottom-right-2"></div>     
                    </div>

                </div>

                
            </div>
    )
}

export default Homepage
