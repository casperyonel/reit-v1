//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./Libraries/SafeMath.sol";

import "./Interfaces/IERC20.sol";
import "./Interfaces/IMIL.sol";
import "./Interfaces/IERC20Permit.sol";

import "./Types/ERC20Permit.sol";
import "./Types/OlympusAccessControlled.sol";

contract MILERC20 is ERC20Permit, IMIL, OlympusAccessControlled {
    using SafeMath for uint256;

    address public initializer;
    address public treasury;
    address public owner;

    constructor(address _initializer)
        ERC20("Voting Escrow Magic Internet Land", "veMIL", 9)
        ERC20Permit("LockedEscrowMagicInternetLand")
        OlympusAccessControlled(IOlympusAuthority(_authority))
    {
        initializer = msg.sender; // Only multi-sig or treasury contract can mint. 
    }

     /// @notice Only allows the `owner and Treasury contract` to execute mint burn functions.
    modifier onlyOwner_or_Treasury() {
        require(msg.sender == owner || msg.sender == treasury, "Owner or Treasury: caller is not the owner or treasury");
        _;
    }

    // do this last
    function initializeOwner_Treasury(address _owner, address _treasury) external {
        require(msg.sender == initializer, "Initializer:  caller is not initializer");

        require(_owner != address(0), "Staking");
        owner = _owner;

        require(_treasury != address(0), "Zero address: Treasury");
        treasury = _treasury;

        emit Transfer(address(0x0), stakingContract, _totalSupply);
        emit LogStakingContractUpdated(stakingContract);

        initializer = address(0);
    }

    function mint(address account_, uint256 amount_) external override onlyOwner_or_Treasury {
        _mint(account_, amount_);
    }

    function burn(uint256 amount) external override {
        _burn(msg.sender, amount);
    }

    function burnFrom(address account_, uint256 amount_) external override {
        _burnFrom(account_, amount_);
    }

    function _burnFrom(address account_, uint256 amount_) internal {
        uint256 decreasedAllowance_ = allowance(account_, msg.sender).sub(
            amount_,
            "ERC20: burn amount exceeds allowance"
        );

        _approve(account_, msg.sender, decreasedAllowance_);
        _burn(account_, amount_);
    }
}