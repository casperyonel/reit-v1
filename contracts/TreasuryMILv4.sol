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
    // mapping( address => Counters.counter ) private depositId;

    mapping( uint => Tracker ) private depositId; // 

    mapping( address => uint[] ) walletDeposits; //

    uint[] public deposits;

    uint public depositId;

     // To get equity stake:
    balances[msg.sender].div(totalSupply); // Equity stake in DAO

    // increment depositId++
    // new deposit, deposits.push[depositId]
    // make a new array for that user, and point address to it
    uint[] deposits.push(depositId)

    // point the address to an array of structs, where each struct is a diff deposit id, and array is for diff structs, and aaddress points to them. 

    mapping( address => tracker[] ) public schedule;
    mapping( address => uint256 ) public balances;
    mapping( address => uint256 ) public claimedBalance;
    mapping( uint => uint256 ) public lockerBalance; // lockerId points to supply balance of MIL

    uint public lockerId;

    uint public depositId;
    uint256 public totalSupply;
    
    function deposit( // v02
        address _token,
        uint _lockerId,
        uint _amount, 
        uint _lockUpTime
    ) external {
        require( acceptedToken[ _token ], "Token not accepted");
        ERC20(_token).transferFrom(msg.sender, owner, _amount);
        depositId++ // Increment master tracker
        lockerBalance[lockerId] += _amount;
        balances[msg.sender] += _amount; // To update total ownership of MIL per address
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
    }

    function claim() external returns(bool) {
        require(balances[msg.sender] > 0, "Wallet does not have MIL balance");
        require(schedule[msg.sender]) // make sure isClaimed is true on their depositIds. Get there depositIds
        // Need to know the length o fthe array

        uint256 memory index = schedule[msg.sender].length;

        for (let i = 0; i < index; i++) {
            if (schedule[msg.sender][i].isClaimed == true) {
                schedule[msg.sender][i].amount = _mint;

                claimedBalance[msg.sender] += amount;

                schedule[msg.sender][i].isClaimed == true;

                // THEN MINT FUNDS TO THEIR WALLET, AFTER STATE CHANGE
                // decrease their amount paid out
            }
        }
    } 



    

    mapping( address => bool ) public acceptedToken;
    acceptedToken[ dai_address ] = true;
    // acceptedToken[ usdc ] = true;
    // acceptedToken[ ust ] = true;
    // acceptedToken[ weth ] = true;
    // acceptedToken[ eth ] = true;
    // acceptedToken[ mil ] = true;

    // -- State variables --
    address public owner;
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

    // -- Functions -- // v01
    // function deposit(
    //     address _token,
    //     uint _lockerId,
    //     uint _amount, 
    //     uint _lockUpTime
    // ) external {
    //     require( acceptedToken[ _token ], "Token not accepted");
        
    //     ERC20(_token).transferFrom(msg.sender, owner, _amount);

    //     depositId++;

    //     // uint256 memory _depositId = depositId[ msg.sender ].increment()
    //     // depositId[ _depositId ] = msg.sender
        
    //     tracker.push( Tracker({
    //         depositId: depositId,
    //         wallet: msg.sender,
    //         lockerId: _lockerId,
    //         token: _token,
    //         amount: _amount,
    //         depositDate: uint32(block.timestamp),
    //         lockUpTime: uint32(_lockUpTime),
    //         unlockDate: uint32(block.timestamp + _lockUpTime)
    //     }));
    // }

    // -- Transfer ownership functinons --
    // Line 149 and functions below it in Treausury.sol of wonderland

    // Now need to mint them our veMIL tokens to hold until they can redeem

    // So when they redeem:
    // 1. We use their wallet address
    // 2. We make sure current timestamp is greater than endTime 
    // 2. We get how many veMILs they have
    // 3. Each week should be an epoch, and then every week we should update everyone's balance (gons)
    // 4. keep how much rewards in a struct 

    // mapping to total amount that user is is owed

    // We have a storage contract that holds all of the depositId data with associated wallets
    // Then that contracts points to a logic contract that implements changes in storage


    function distribute(address _depositId) external returns (bool) {
        for (let i = 0; i < tracker; i++) {
            if( tracker.depositId == _depositId && tracker.unlockDate < block.timestamp ) {
                
                
                _mint(msg.sender)
                // the amount of MIL they get for that depositId
            }    
        }
            
            ( _depositId == tracker.depositId ) {
            if( tracker.unlockDate > block.timestamp ) 


            // Map of structs, depositId => Struct of that depositId

            // When you want to redeem, we run a function that takes in your wallet address and loops over map to check:
                // if theres a wallet address match, then we check if the current time is greater than endTime


            // Of the total redemptions that are possible, this person owns what % of total?
            // So maybe we keep % stake in a lockerId, and keep totals in lockerIds, with redemption. 

            // 



        }
    }

// Redemption must be to address calling the function. Make sure to change enum state prior to withdrawing funds. 


}