//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2; // This is for returning an array of structs. 

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract TreasuryMILv4 {

    // -- Events --
    event Deposit( address indexed wallet, address indexed token, uint amount );

    // event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    // -- Accepted tokens -- 
    ERC20 public constant dai = ERC20(0x4F96Fe3b7A6Cf9725f59d353F723c1bDb64CA6Aa); // Kovan
    // ERC20 public constant usdc = ERC20(0x4F96Fe3b7A6Cf9725f59d353F723c1bDb64CA6Aa);
    // ERC20 public constant ust = ERC20(0x4F96Fe3b7A6Cf9725f59d353F723c1bDb64CA6Aa);
    // ERC20 public constant mil = ERC20(0x4F96Fe3b7A6Cf9725f59d353F723c1bDb64CA6Aa); 

    // -- Maps --
    // mapping( address => Counters.counter ) private depositId;

    mapping( uint => Tracker ) private depositId; 

    mapping( address => uint[] ) walletDeposits;

    uint[] public deposits;

    uint public depositId;

     // To get equity stake:
    balances[msg.sender].div(totalSupply); // Equity stake in DAO

    // increment depositId++
    // new deposit, deposits.push[depositId]
    // make a new array for that user, and point address to it
    uint[] deposits.push(depositId)

    // point the address to an array of structs, where each struct is a diff deposit id, and array is for diff structs, and aaddress points to them. 

    mapping( address => tracker[] ) public schedule; // Tracks deposit info
    mapping( address => uint256 ) public balances; // Total MIL per user
    mapping( address => uint256 ) public claimedBalance; // How much each user has claimed
    mapping( uint => uint256 ) public lockerBalance; // Keeps track of MIL in each locker

    uint public lockerId;
    uint public depositId;
    uint256 public totalSupply;
    uint256 public totalveMIL; // Deposit function mints veMIL, claim function burns veMIL
    // Need to define minting privelages
    
    function deposit(
        address _token,
        uint _lockerId,
        uint _amount, 
        uint _lockUpTime
    ) external {
        require( acceptedToken[ _token ], "Token not accepted");
        ERC20(_token).transferFrom(msg.sender, owner, _amount);
        depositId++ // Increment master tracker
        totalSupply += _amount; // Increase total supply of MIL by deposit amount
        totalLockedSupply += _amount;
        lockerBalance[lockerId] += _amount; // Increase locker balance
        balances[msg.sender] += _amount; // Increase user's MIL balance
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
        totalveMIL += _amount; // Mint veMIL to user ??
        _mint(msg.sender, _amount)  // ???
    }

    function mintveMIL(address _recipient, uint _amount) internal 

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
            }
        }
        return true;
    } 

    mapping( address => bool ) public acceptedToken;
    acceptedToken[ dai_address ] = true;
    // acceptedToken[ usdc ] = true;
    // acceptedToken[ ust ] = true;
    // acceptedToken[ mil ] = true;

    // -- State variables --
    address public owner; // Multi-sig
    uint256 public depositId;

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

    constructor() {
        owner = msg.sender;
        // emit OwnershipTransferred(address(0), msg.sender);
    }

    /// @notice Only allows the `owner` to execute the function.
    modifier onlyOwner() {
        require(msg.sender == owner, "Ownable: caller is not the owner");
        _;
    }

    // -- Transfer ownership functinons --
    // Line 149 and functions below it in Treausury.sol of wonderland

    // Now need to mint them our veMIL tokens to hold until they can redeem
    // When they deposit, we need to mint them _amount is veMIL
        }
    }
}