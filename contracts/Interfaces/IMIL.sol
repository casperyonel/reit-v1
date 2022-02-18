//SPDX-License-Identifier: Unlicense
pragma solidity >=0.5.0;

import "./IERC20.sol";

interface IMIL is IERC20 {
    function mint(address account_, uint256 amount_) external;

    function burn(uint256 amount) external;

    function burnFrom(address account_, uint256 amount_) external;
}