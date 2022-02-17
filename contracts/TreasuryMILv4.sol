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

    // -- Accepted tokens -- 
    ERC20 public constant dai = ERC20(0x4F96Fe3b7A6Cf9725f59d353F723c1bDb64CA6Aa); // Kovan

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
    uint public lockerId;
    uint public depositId;
    uint256 public totalSupply;
    uint256 public totalveMIL; // Deposit function mints veMIL, claim function burns veMIL // Need to define minting privelages
    uint256 public totalNAV;
    uint256 public debtOutstanding; // *****

    address public owner; // Multi-sig

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
        totalveMIL += mintveMIL(msg.sender, _amount); // Mint veMIL and add to total veMIL
        totalNAV += _amount;

        debtOutstanding += _amount; // ****
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

    // -- Bonding at a discount --
    uint public discountRate;

    uint public bondPrice; // This will be oracle less discountRate. Frontend reads this state upon page load. 

    // if market price from oracle is above totalNAV
    // each time you send money to multi-sig you need to increase the NAV counter, 

    function changeDiscountRate(uint _rate) external onlyOwner {
        discountRate = _rate;
    }
    
    
    function getBondPrice() public view returns (uint bondPrice) {
        // if market price per MIL is above NAV per MIL, set bondprice = market price less 5% 
        
        // get chainlink oracle market price of MIL, if 5% discount is grerater than NAV, display market price minus 5%
        // else display NAV as bonds price

    }

    // Bond Price = Control Variable * Debt Ratio
    // Debt Ratio = Total Debt / Total OHM Supply (treasury.baseSupply() is a function in treasury contract)
    // Control Variable = Bond Price / Debt Ratio

    // Debt = deposits that haven't been paid out yet
    // Debt Ratio = totalDebt / treasury.baseSupply()

    // 5 / 100
 

    // derive a new control variable from the target debt and current supply
    uint64 newControlVariable = uint64((price * treasury.baseSupply()) / targetDebt);


    4.8 * 30000 tokens = market cap
    
    market cap / 10000

    market cap / total debt = control variable



        send_ = value.sub(_profit);
        OHM.mint(msg.sender, send_);

        totalReserves = totalReserves.add(value);


    // I know the dollar value of the LP, so then I just need to know how many MIL i have paired in there to get market price?

    // 1) 50k DAI x 5k MIL = $10/MIL --> x * y = k or $50k = k
    // 2) 50k DAI x 7k MIL = $7.1/MIL --> x * y = k or $50k = k
        
    function getTotalValue;

    function marketPrice(uint256 _id) public view override returns (uint256) {
        return (currentControlVariable(_id) * debtRatio(_id)) / (10**metadata[_id].quoteDecimals);
    }


    // 1) Get value from LP, check if it's above backing price, get incrmeental difference, 
    // then take top 5% of premium difference, else, list it at NAV.







    
    
    
    
    // -- Transfer ownership functinons --
    // Line 149 and functions below it in Treausury.sol of wonderland

    // Now need to mint them our veMIL tokens to hold until they can redeem
    // When they deposit, we need to mint them _amount is veMIL
    // Have a diff bonding discount rate for LP bonds than for MIL bonds




}