import "./homepage.scss";
import mainMonopolyDashboard from "../../../assets/reit-visuals/outer-main-dashboard (4).png";




const Homepage = () => {
    return (
            <div className="outer-main">
                
                <div className="outer-top">
                    <div className="outer-top-left-1">
                        <div className="outer-top-left-2">
                            <h1 className="top-header-text">Monopoly, in the metaverse</h1>
                            <h2 className="top-subheader-text">REIT DAO is monopoly, </h2>

                        </div>
                    </div>
                    <div className="outer-top-right-1">
                        <div className="outer-top-right-2"> 
                            <img id="mainMonopolyDashboard" src={mainMonopolyDashboard} alt="monopoly-dashboard" />
                        </div>     
                    </div>
                </div>


                <div className="outer-middle">
                    <div className="outer-middle-left-1">
                        <div className="outer-middle-left-2"></div>
                    </div>
                    <div className="outer-middle-right-1">
                        <div className="outer-middle-right-2"> </div>     
                    </div>
                </div>

                <div className="outer-bottom">
                    <div className="outer-bottom-left-1">
                        <div className="outer-bottom-left-2"></div>
                    </div>
                    <div className="outer-bottom-right-1">
                        <div className="outer-bottom-right-2"> </div>     
                    </div>
                </div>

                
            </div>
    )
}

export default Homepage
