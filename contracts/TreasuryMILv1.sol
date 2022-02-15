//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2; // This is for returning an array of structs. 

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract PreSaleKovan {

    // -- Events --
    event Deposit( address indexed wallet, address indexed token, uint amount );

    // event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    // -- Accepted tokens -- 
    ERC20 public constant dai = ERC20(0x4F96Fe3b7A6Cf9725f59d353F723c1bDb64CA6Aa); // Kovan
    ERC20 public constant usdc = ERC20(0x4F96Fe3b7A6Cf9725f59d353F723c1bDb64CA6Aa);
    ERC20 public constant ust = ERC20(0x4F96Fe3b7A6Cf9725f59d353F723c1bDb64CA6Aa);
    ERC20 public constant weth = ERC20(0x4F96Fe3b7A6Cf9725f59d353F723c1bDb64CA6Aa);
    ERC20 public constant eth = ERC20(0x4F96Fe3b7A6Cf9725f59d353F723c1bDb64CA6Aa); // Confirm?
    ERC20 public constant mil = ERC20(0x4F96Fe3b7A6Cf9725f59d353F723c1bDb64CA6Aa); 

    // -- Maps --
    mapping( address => bool ) public acceptedToken;
    acceptedToken[ dai ] = true;
    acceptedToken[ usdc ] = true;
    acceptedToken[ ust ] = true;
    acceptedToken[ weth ] = true;
    acceptedToken[ eth ] = true;
    acceptedToken[ mil ] = true;

    // -- State variables --
    address public owner;
    address public veNFT; // Figure this out

    uint public oneWeek = 1 weeks; // Type string or uint?
    uint public oneMonth = 1 months;
    uint public oneYear = 1 years;
    uint public twoYears = 2 years;
    uint public threeYears = 3 years;
    uint public fourYears = 4 years;

    // -- Arrays --
    Tracker[] public tracker; 

    // -- Structs -- 
    struct Tracker {
        address wallet;
        address token;
        uint amount; 
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
    function depositAndMint(
        IERC20 _token,  // Is this correct?
        uint _lockTime, 
        uint _amount, 
        uint _lockerId
    ) external {
        require( acceptedToken[ _token ], "Token not accepted");
        
        _token.transferFrom(msg.sender, owner, _amount);
        
        // -- Mint new NFT below -- 
        ERC721(veNFT).mintNFT(
            msg.sender, 
            token uri ??, 
            _lockerId, 
            _token, 
            _amount, 
            _lockTime
        )
    }

    // -- Policy functions --
    function addDepositor(address _depositor, address _token, uint _amount) external onlyOwner {
        require( _depositor != address(0), "Failed, deposit is address(0)" );
        tracker.push( Tracker({
            wallet: _depositor,
            token: _token,
            amount: _amount
        }));
    } 






    // -- Transfer ownership functinons --
    // Line 149 and functions below it in Treausury.sol of wonderland






}