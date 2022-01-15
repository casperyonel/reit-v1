import Navbar from './Navbar'
import Footer from './Footer'
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom'
import Homepage from './pages/homepage/Homepage'
import IDOWhitelist from './pages/IDOWhitelist/IDOWhitelist'
import Leaderboards from './pages/leaderboards/Leaderboards'
import Errorpage from './pages/errorpage/Errorpage'

const Main = () => {
    return (
        <>
            <Router>
               
                <Navbar />
                
                <Routes>
                    <Route path='/' exact element={<Homepage />} />
                    <Route path='/ido' element={<IDOWhitelist />} />
                    <Route path='/leaderboards' element={<Leaderboards />} />
                    <Route path="*" element={<Errorpage />} />
                </Routes>

                <Footer />
            </Router>
        </>
    )
}

export default Main
