import { FaBars } from 'react-icons/fa';
import { NavLink as Link } from 'react-router-dom';
import styled from 'styled-components';



export const Nav = styled.nav`
  display: flex;
  justify-content: space-between;
  padding: 0.5rem calc((100vw - 960px) / 2);
  z-index: 10;
  position: sticky;
  top: 0;
  
  backdrop-filter: blur(5px);
`;

export const NavLink = styled(Link)`
  color: rgb(200, 199, 216);
  display: flex;
  align-items: center;
  text-decoration: none;
  padding: 0 1rem;
  height: 100%;
  cursor: pointer;
  font-family: Montserrat Medium;
  &.active {
    color: rgb(200, 199, 216); // Change this for "Clicked on" link
  }
  &:hover {
    color: rgb(137, 136, 150);
    transition: 150ms;
}
`;

export const Bars = styled(FaBars)`
  display: none;
  color: rgb(200, 199, 216);
  @media screen and (max-width: 768px) {
    display: block;
    position: absolute;
    top: 0;
    right: 0;
    transform: translate(-100%, 75%);
    font-size: 1.8rem;
    cursor: pointer;
  }

  
`;

export const NavMenu = styled.div`
  display: flex;
  align-items: center;
  margin-right: 24px;
  
  @media screen and (max-width: 768px) {
    display: none;
  }
`;

export const NavBtnLink = styled(Link)`
  border-radius: 8px;
  background: rgb(104, 102, 246);
  padding: 8px 16px;
  color: rgb(200, 199, 216);
  font-family: Montserrat Medium;
  outline: none;
  border: none;
  cursor: pointer;
  transition: all 0.2s ease-in-out;
  text-decoration: none;
  margin-left: 24px;
  background-image: linear-gradient(to left,#5E72F5, #5957d7, #5E72F5);
  background-size: 200%;
  transition: .6s;
  transition: all .15s ease;
    &:hover {
        background-position: right;
        transform: scale(1.07);
        transition: all .25s ease;
        
    }
`;