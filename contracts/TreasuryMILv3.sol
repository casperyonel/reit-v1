//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2; // This is for returning an array of structs. 

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/presets/ERC721PresetMinterPauserAutoId.sol";

import "veNFTv2.sol";

contract TreasuryMILv3 is veNFTv2 {

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
    string public baseURI = "http://localhost:3001/ido/"; // CHANGE UPON DEPLOYMENT

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
        address token;
        uint amount;
        uint32 depositDate;
        uint lockUpTime;
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
        ERC20 _token,
        uint _lockerId,
        uint _amount, 
        uint _lockTime
    ) external {
        require( acceptedToken[ _token ], "Token not accepted");
        
        _token.transferFrom(msg.sender, owner, _amount);
        
        ERC721PresetMinterPauserAutoId veNFT = new ERC721PresetMinterPauserAutoId(
                "Locked Voting MIL",
                "veMIL",
                baseURI
            ); //  Do I need to do this if I already have the "is"
        
        veNFT.mint(msg.sender); // Mint NFT
    }

    // -- Policy functions --
    function addDepositor(address _depositor, address _token, uint _amount) external onlyOwner {
        require( _depositor != address(0), "Failed, deposit is address(0)" );
        
        tracker.push( Tracker({
            wallet: _depositor,
            token: _token,
            amount: _amount,
            depositDate: uint32(block.timestamp)
        }));
    } 






    // -- Transfer ownership functinons --
    // Line 149 and functions below it in Treausury.sol of wonderland






}