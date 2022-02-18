//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2; // This is for returning an array of structs. 

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "./Interfaces/IERC20.sol";
import "./Interfaces/IERC20Permit.sol";
import "./Interfaces/IMIL.sol";
import "./StandardBondingCalculator.sol";
import "./TwapGetter.sol";
import "./MILERC20.sol";
import "./veMILERC20.sol";

contract TreasuryMILv4 {

    // -- Events --
    event Deposit( address indexed token, uint amount, uint value );
    event CreateDebt( address indexed debtor, address indexed token, uint amount, uint value );

    // -- Accepted tokens -- 
    ERC20 public constant dai = ERC20(0x4F96Fe3b7A6Cf9725f59d353F723c1bDb64CA6Aa); // Kovan
    // IERC20 public constant mil = IERC20(......); // IERC20 vs. ERC20?

    mapping( address => bool ) public acceptedToken;
    mapping( address => tracker[] ) public schedule; // Tracks deposit info
    mapping( address => uint256 ) public balances; // Total MIL per user (includes veMIL locked per user, so outstanding amount)
    mapping( uint => uint256 ) public lockerNAV; // Keeps track of MIL in each locker

    // -- Arrays --
    Tracker[] public tracker; 

    // -- Structs -- 
    struct Tracker {
        uint256 depositId;
        address wallet;
        uint lockerId;
        address token;
        uint amount;
        uint32 depositDate;
        uint lockUpTime;
        uint unlockDate;
        bool isClaimed;
    }

    // acceptedToken[ dai_address ] = true;
    address public owner; // Mult-sig owner
    uint public lockerId;
    uint public depositId;

    uint256 public totalSupply; 
    uint256 public circulatingMIL; 
    uint256 public circulatingveMIL;

    uint256 public totalNAV;

    uint public discountRate; // Controlled by mult-sig owner
    uint public bondPrice; 

    // -- Tokens --
    IMIL public immutable MIL; // Use IMIL since we're just doing mint / burnFrom functions
    IMIL public immutable veMIL; // Use IMIL since we're just doing mint / burnFrom functions

    TwapGetter public twapGetter;
    uint32 twapInterval; // CHANGE UPON DEPLOYMENT
    
    uint constant YEAR_IN_SECONDS = 31536000;
    uint constant DAY_IN_SECONDS = 86400;   
    uint public oneWeek = 7 * DAY_IN_SECONDS;
    uint public oneMonth = 30 * DAY_IN_SECONDS;
    uint public oneYear = YEAR_IN_SECONDS;
    uint public twoYears = 2 * YEAR_IN_SECONDS;
    uint public threeYears = 3 * YEAR_IN_SECONDS;
    uint public fourYears = 4 * YEAR_IN_SECONDS;

    constructor(address _MIL, address _veMIL) {
        owner = msg.sender;
        // emit OwnershipTransferred(address(0), msg.sender);
        twapGetter = new TwapGetter();

        MIL = MILERC20( _MIL ); // Deploy MIL contract before, pass in as _MIL, immutable keyword so read-only but constructor. 
        veMIL = veMILERC20( _veMIL ); // Deploy veMIL contract before, pass in as _veMIL. 
    }

    /// @notice Only allows the `owner` to execute the function.
    modifier onlyOwner() {
        require(msg.sender == owner, "Ownable: caller is not the owner");
        _;
    }

    function deposit(
        address _token,
        uint _lockerId,
        uint _amount,
        uint _lockUpTime
    ) external {
        require( acceptedToken[ _token ], "Token not accepted");
        require( _amount > 0, "Purchase amount is 0");
        
        uint mintAmount; 

        IERC20(_token).transferFrom(msg.sender, owner, _amount);
        
        if( _token != MIL ) {  // DAI / USDC / MIM / ETC
            mintAmount = _amount * (1 + discountRate);
            balances[msg.sender] += mintAmount; // Update user balance with newly minted MIL (includes locked balance)

            totalNAV += _amount;
            circulatingveMIL += mintAmount;
            totalSupply += mintAmount; // This is main MIL supply
            
        } else { // MIL
            mintAmount = _amount;

            circulatingveMIL += mintAmount;
            circulatingMIL -= mintAmount;
        }
        
        veMIL.mint(msg.sender, mintAmount);

        schedule[msg.sender] = tracker.push( Tracker({
            depositId: depositId,
            lockerId: _lockerId,
            token: _token,
            amount: mintAmount,
            depositDate: uint32(block.timestamp),
            lockUpTime: uint32(_lockUpTime),
            unlockDate: uint32(block.timestamp + _lockUpTime), 
            isClaimed: false
        }));  
        }

        depositId++;
        lockerNAV[lockerId] += _amount; // Update lockerBalance NAV

    }

    function claim() external nonReentrant returns(bool) {
        require(balances[msg.sender] > 0, "Wallet does not have MIL balance"); // Should also check wallet.balanceOf(MIL) > 0
        uint256 _index = schedule[msg.sender].length;

        for (i = 0; i < _index; i++) {
            
            if ( schedule[msg.sender][i].isClaimed == false && schedule[msg.sender][i].unlockDate < uint32(block.timestamp) ) { // If they haven't claimed yet, and now is greater than unlockDate, mint
                
                schedule[msg.sender][i].isClaimed = true; // First change to True to protect against reentrency attacks

                veMIL.burnFrom( msg.sender, schedule[msg.sender][i].amount ) // Burn their veMIL
                circulatingveMIL -= schedule[msg.sender][i].amount;
                
                MIL.mint( msg.sender, schedule[msg.sender][i].amount ) // Mint them 1-to-1 MIL
                circulatingMIL += schedule[msg.sender][i].amount;
            
                return true
            } else {
                return false
            }
        }
    }

    // Market price = total LP value / total circulating supply
    // Backing price = total NAV / total circulating supply
    // Bond price = market price - (market premium * (1 - discoutRate))

    function updateBondPrice(address _pair) public returns (uint currentBondPrice) { 
        _value = twapGetter.getSqrtTwapX96( address uniswapV3Pool, uint32 twapInterval ); // CHANGE ARGUMENTS ****

        if ( ( _value * totalSupply ) > ( 1 * totalNAV ) ) { // NEED TO CHANGE TO MARKET VALUE OF MULTI - SIG (land, or backing value)
            uint marketPremium = ( _value * totalSupply ) - ( 1 * totalNAV ) / totalSupply;
            return _value - ( marketPremium * (1 - discountRate) ); 
        } 

        if (_value > totalNAV / totalSupply) { // If market price > NAV backing price ???
            uint marketPremium = _value - (totalNAV / totalSupply);
            return _value - ( marketPremium * (1 - discountRate) ); // Bond at discount on premium
        } else {
            return totalNAV / totalSupply; // Bond at backing
        }
    }

    function adjustDiscountRate(uint _discountRate) external onlyOwner {
        discountRate = _discountRate;
    }

    function getBackingPerMILSupply() external view returns ( uint MILtoNANSupply ) {
            return totalSupply / totalNAV;
        } // Doesn't account for market price of MIL though, right?

    function getBackingPerMILMarketPrice() external view returns ( uint MILtoNAV ) {
            // find market price of MIL


            
            
            return totalSupply / totalNAV;
        } // Doesn't account for market price of MIL though, right?

    function getNonLockedMILBacking external view returns ( uint NonLockedMILtoNAV ) {
        return ( totalSupply - circulatingveMIL ) / totalNAV;
    }

    function getPercentOfMILLocked external view returns ( uint LockedMILtoTotalSupply ) {
        require( totalSupply = circulatingMIL +  circulatingveMIL, "Error: Total Supply does not equal circulatingveMIL + circulatingMIL" )
        return ( circulatingveMIL / totalSupply );
    }
    
    function checkCalcs external view returns (uint shouldBeZero) {
        return totalSupply - circulatingveMIL - circulatingMIL;
    }
    


    // -- Transfer ownership logic --
    // Line 149 and functions below it in Treausury.sol of wonderland
}