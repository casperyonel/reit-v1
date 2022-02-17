//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2; // This is for returning an array of structs. 

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "./StandardBondingCalculator.sol";

contract TreasuryMILv4 {

    // -- Events --
    event Deposit( address indexed token, uint amount, uint value );
    event CreateDebt( address indexed debtor, address indexed token, uint amount, uint value );

    // -- Accepted tokens -- 
    ERC20 public constant dai = ERC20(0x4F96Fe3b7A6Cf9725f59d353F723c1bDb64CA6Aa); // Kovan
    IERC20 public constant mil = IERC20(......); // IERC20 vs. ERC20?

    mapping( address => bool ) public acceptedToken;
    mapping( address => tracker[] ) public schedule; // Tracks deposit info
    mapping( address => uint256 ) public balances; // Total MIL per user
    mapping( address => uint256 ) public claimedBalance; // How much each user has claimed
    mapping( uint => uint256 ) public lockerBalance; // Keeps track of MIL in each locker

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

    acceptedToken[ dai_address ] = true;
    address public owner;
    uint public lockerId;
    uint public depositId;
    uint256 public totalSupply;
    uint256 public totalveMIL; // Deposit function mints veMIL, claim function burns veMIL // Need to define minting privelages
    uint256 public totalNAV; // Total deposits
    uint public discountRate; // Set my mult-sig owner
    uint public bondPrice; 

    uint constant YEAR_IN_SECONDS = 31536000;
    uint constant DAY_IN_SECONDS = 86400;   
    uint public oneWeek = 5 * DAY_IN_SECONDS;
    uint public oneMonth = 30 * DAY_IN_SECONDS;
    uint public oneYear = YEAR_IN_SECONDS;
    uint public twoYears = 2 * YEAR_IN_SECONDS;
    uint public threeYears = 3 * YEAR_IN_SECONDS;
    uint public fourYears = 4 * YEAR_IN_SECONDS;

    constructor() {
        owner = msg.sender;
        // emit OwnershipTransferred(address(0), msg.sender);
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
        ERC20(_token).transferFrom(msg.sender, owner, _amount);
        depositId++ // Increment master tracker
        // totalSupply += _amount; // Increase total supply of MIL by deposit amount
        totalLockedSupply += _amount; // Increase total supply of veMIL by deposit amount
        totalNAV += _amount; // Increase backing NAV by deposit amount
        lockerBalance[lockerId] += _amount; // Increase locker balance
        balances[msg.sender] += _amount; // Increase user's MIL balance (veMIL or MIL?)
        schedule[msg.sender] = tracker.push( Tracker({
                depositId: depositId,
                lockerId: _lockerId,
                token: _token,
                amount: _amount,
                depositDate: uint32(block.timestamp),
                lockUpTime: uint32(_lockUpTime),
                unlockDate: uint32(block.timestamp + _lockUpTime), 
                isClaimed: false
            }));
        totalveMIL += mintveMIL(msg.sender, _amount); // Mint veMIL and add to total veMIL
    }

    function mintveMIL(address _recipient, uint256 _amount) internal returns (uint) {
        veMIL.mint(_recipient, _amount); // Need to import veMIL ERC20
    }

    function claim() external nonReentrant returns(bool) {
        require(balances[msg.sender] > 0, "Wallet does not have MIL balance");
        uint256 memory _index = schedule[msg.sender].length;

        for (let i = 0; i < _index; i++) {
            if (schedule[msg.sender][i].isClaimed == false && schedule[msg.sender][i].unlockDate < uint32(block.timestamp)) { // If they haven't claimed yet, and now is greater than unlockDate, mint
                schedule[msg.sender][i].isClaimed == true; // Change first to protect reentrency. ** REECENTRENCY GAURD OPEN ZEPPELIN MODIFIER
                uint memory _mintAmount = schedule[msg.sender][i].amount;
                ERC20(MIL).transferFrom(owner, msg.sender, _mintAmount) // *** Replace owner with contract that holds veMIL ***
                claimedBalance[msg.sender] += amount;
                schedule[msg.sender][i].amount = 0;
                totalLockedSupply -= _mintAmount;
                break;
            }
        }
        return true;
    }

    // Market price = total LP value / total circulating supply
    // Backing price = total NAV / total circulating supply
    // Bond price = market price - (market premium * (1 - discoutRate))

    // -- Bonding -- 
    function getTotalValue( address _pair ) public view returns ( uint _value ) {
        _value = getKValue( _pair ).sqrrt().mul(2);
    }

    function updateBondPrice(address _pair, uint _amount) public returns (uint currentBondPrice) {
        _value = valuation(_pair, _amount) / 2; // Check to make sure / 2 is correct?
        _discountRate = getDiscountRate();

        if (_value > totalNAV / totalSupply) { // If market price > NAV price
            uint marketPremium = _value - (totalNAV / totalSupply);
            return _value - ( marketPremium * (1 - _discountRate) ); // Bond at discount on premium
        } else {
            return totalNAV / totalSupply; // Bond at backing
        }
    }

    function getDiscountRate() internal returns (uint) {
        return discountRate;
    }

    function adjustDiscountRate(uint _discountRate) external onlyOwner {
        discountRate = _discountRate;
    }
    


    // -- Transfer ownership logic --
    // Line 149 and functions below it in Treausury.sol of wonderland
}