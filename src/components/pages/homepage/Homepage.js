import "./homepage.scss";
import mainMonopolyDashboard from "../../../assets/reit-visuals/outer-main-dashboard (4).png";
import middleDiagram from "../../../assets/reit-visuals/monopolyDiagram (2).png";

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
                        <div className="outer-middle-left-2">
                            <div className="outer-middle-left-2-top">Democratizing access to metaverse land</div>
                            <div className="outer-middle-left-2-middle">Stake Magic Monopoly Money ($MMM) to claim Magic Internet Land ($MIL).</div>
                            <div className="outer-middle-left-2-bottom">Owning Magic Internet Land is like owning land in every major metaverse game.</div>


                        </div>
                    </div>
                    <div className="outer-middle-right-1">

                        <img id="middleDiagram" src={middleDiagram} alt="monopoly-diagram" />
                        <div className="outer-middle-right-2"> </div>
                       
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
