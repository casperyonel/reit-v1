//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2; // This is for returning an array of structs. 
// pragma abicoderv2; // Or this?

import "hardhat/console.sol";

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract PreSale {

    // Convert to MIM?
    uint classA = 500; 
    uint classB = 1000;

    uint totalPurchased;

    constructor(address _DAI) {
        require(_DAI != address(0));
        acceptedToken[_DAI] = true;   
    }

    struct UserStruct {
        address userAddress;
        uint userPrice;
    }

    UserStruct[] public users;
    mapping(address => bool) knownUser;
    mapping(address => uint) purchaseAmount; // Should only be 500 or 1000 MIM. 
    mapping(address => bool) acceptedToken; // Set accepted token var in constructor, and then point that token var to true in this map. 
    
    function newUser(address userAddress, uint userPrice) external returns (uint userIndexPosition) {
        require(!knownUser[userAddress], "User already uploaded");
        UserStruct memory newUserStruct;
        newUserStruct.userAddress = userAddress;
        newUserStruct.userPrice = userPrice;
        knownUser[userAddress] = true;
        users.push(newUserStruct);
        return users.length;
    } // Do we want this to be public? Probably not...OnlyAdmin (which is msg.sender = owner from OG transaction)
    // I think when we call the function payable, at the end we call this function to add to users array. 
    // That way you MUST buy the IDO to be able to be added to what we reference for minting R. 

    // function updateUserPrice(uint indexPosition, address userAddress, uint newUserPrice) public returns (bool success) {
    //     require(knownUser[userAddress], "User is not in contract");
    //     require(users[indexPosition] == users.indexOf(userAddress), "indexPosition and userAddress arguments do not match");
    //     require(users[indexPosition] != newUserPrice, "This is already the user price");
    //     users[indexPosition].userPrice = newUserPrice;
    //     return true;
    // } // DELETE THIS FUNCTION. 
 
    function getUserCount() external view returns (uint usersArrayLength) {
        return users.length;
    }

    function isUserInContract(address userAddress) external view returns (bool isIndeed) {
        return knownUser[userAddress];
    }

    function getAllUsers() external view returns (UserStruct[] memory) {
        return users;
    }

    function purchaseIDO(uint _amount, address _token) external returns (uint totalContractBalance) {
        require(acceptedToken[_token], "Token not accepted");
        require(!knownUser[msg.sender], "User has already purchased IDO");
        require((_amount == 500 || _amount == 1000), "Argument was not 500 or 1000 MIM");

        IERC20(_token).approve(msg.sender, _amount);

        IERC20(_token).transferFrom(msg.sender, address(this), _amount);
        
        totalPurchased += _amount;
        knownUser[msg.sender] = true;
        purchaseAmount[msg.sender] = _amount;

        return address(this).balance; 
    }

// Based on above, I think we need 2 newUser functions. 1 to store users that purchase IDO, and amount purchased. 
// 2 for AFTER IDO to know how much to mint that user once we send the contract the price data per each address in user purchase array. 
// So, first have function to accept payments, and store those users in an array
// then have a map that points a map of that user address to true if purchased
// then create a function that requires that to be true for adding an address and purchase price (for mint function)

    /*
    PAY INTO THE CONTRACT LOGIC:
    1. ensure sufficient funds in msg.sender with msg.balance?
    2. Ensure mapping address => bool is false (hasn't contributed already)
    3. Ensure IDO timestamp is still ongoing? (do this later with an enum)
    3. Add user to users Struct
    4. set mapping = true for knownUser
    5. set mapping = amount for purchaseAmount

    */

    // function mintR() 

    /* 
    MINT/WITHDRAW LOGIC:
    1. Only admin can request this (look into purpose of multi sig)
    2. Arithmetic around userPrice and wei and mintable R
    3. Need to define how much R to mint?
    */ 


    function getBalanceOfIDO() public view returns (uint totalBalance) {
        return address(this).balance;
    }
}