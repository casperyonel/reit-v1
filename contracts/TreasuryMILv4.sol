//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2; // This is for returning an array of structs. 

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract TreasuryMILv4 {

    // -- Events --
    event Deposit( address indexed wallet, address indexed token, uint amount );

    // event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    // -- Accepted tokens -- 
    ERC20 public constant dai = ERC20(0x4F96Fe3b7A6Cf9725f59d353F723c1bDb64CA6Aa); // Kovan
    // ERC20 public constant usdc = ERC20(0x4F96Fe3b7A6Cf9725f59d353F723c1bDb64CA6Aa);
    // ERC20 public constant ust = ERC20(0x4F96Fe3b7A6Cf9725f59d353F723c1bDb64CA6Aa);
    // ERC20 public constant weth = ERC20(0x4F96Fe3b7A6Cf9725f59d353F723c1bDb64CA6Aa);
    // ERC20 public constant eth = ERC20(0x4F96Fe3b7A6Cf9725f59d353F723c1bDb64CA6Aa); // Confirm?
    // ERC20 public constant mil = ERC20(0x4F96Fe3b7A6Cf9725f59d353F723c1bDb64CA6Aa); 

    // -- Maps --
    mapping( address => bool ) public acceptedToken;
    // acceptedToken[ dai_address ] = true;
    // acceptedToken[ usdc ] = true;
    // acceptedToken[ ust ] = true;
    // acceptedToken[ weth ] = true;
    // acceptedToken[ eth ] = true;
    // acceptedToken[ mil ] = true;

    // -- State variables --
    address public owner;

    uint constant YEAR_IN_SECONDS = 31536000;
    uint constant DAY_IN_SECONDS = 86400;   
    
    uint public oneWeek = 5 * DAY_IN_SECONDS;
    uint public oneMonth = 30 * DAY_IN_SECONDS;
    uint public oneYear = YEAR_IN_SECONDS;
    uint public twoYears = 2 * YEAR_IN_SECONDS;
    uint public threeYears = 3 * YEAR_IN_SECONDS;
    uint public fourYears = 4 * YEAR_IN_SECONDS;

    // -- Arrays --
    Tracker[] public tracker; 

    // -- Structs -- 
    struct Tracker {
        address wallet;
        uint lockerId;
        address token;
        uint amount;
        uint32 depositDate;
        uint lockUpTime;
        uint unlockDate;
    }

    constructor() {
        owner = msg.sender;
        // emit OwnershipTransferred(address(0), msg.sender);
    }

    /// @notice Only allows the `owner` to execute the function.
    modifier onlyOwner() {
        require(msg.sender == owner, "Ownable: caller is not the owner");
        _;
    }

    // -- Functions -- /
    function deposit(
        address _token,
        uint _lockerId,
        uint _amount, 
        uint _lockUpTime
    ) external returns (bool) {
        // require( acceptedToken[ _token ], "Token not accepted");
        
        ERC20(_token).transferFrom(msg.sender, owner, _amount);
        
        tracker.push( Tracker({
            wallet: msg.sender,
            lockerId: _lockerId,
            token: _token,
            amount: _amount,
            depositDate: uint32(block.timestamp),
            lockUpTime: uint32(_lockUpTime),
            unlockDate: uint32(block.timestamp + _lockUpTime)
        }));

        return true;
    }

    // -- Transfer ownership functinons --
    // Line 149 and functions below it in Treausury.sol of wonderland

}