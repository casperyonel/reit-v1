//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2; // This is for returning an array of structs. 
// pragma abicoderv2; // Or this?

import "hardhat/console.sol";

contract PreSale {

    struct UserStruct {
        address userAddress;
        uint userPrice;
    }

    UserStruct[] public users;
    mapping(address => bool) knownUser;

    
    function newUser(address userAddress, uint userPrice) external returns (uint userIndexPosition) {
        require(knownUser[userAddress] == false, "User already uploaded");
        UserStruct memory newUserStruct;
        newUserStruct.userAddress = userAddress;
        newUserStruct.userPrice = userPrice;
        knownUser[userAddress] = true;
        users.push(newUserStruct);
        return users.length;
    } // Do we want this to be public? Probably not...OnlyAdmin (which is msg.sender = owner from OG transaction)
    // I think when we call the function payable, at the end we call this function to add to users array. 
    // That way you MUST buy the IDO to be able to be added to what we reference for minting R. 

    function updateUserPrice(uint indexPosition, address userAddress, uint newUserPrice) public returns (bool success) {
        require(knownUser[userAddress] == true, "User is not in contract");
        require(users[indexPosition] == users.indexOf(userAddress), "indexPosition and userAddress arguments do not match");
        require(users[indexPosition] != newUserPrice, "This is already the user price");
        users[indexPosition].userPrice = newUserPrice;
        return true;
    }
 
    function getUserCount() external view returns (uint usersArrayLength) {
        return users.length;
    }

    function isUserInContract(address userAddress) external returns (bool isIndeed) {
        return knownUser[userAddress];
    }

    function getAllUsers() external returns (UserStruct[] memory) {
        return users;
    }

    function purchaseIDO(string class) external 

}