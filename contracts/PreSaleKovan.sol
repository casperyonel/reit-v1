//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2; // This is for returning an array of structs. 

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract PreSaleKovan {
    
    // -- Accepted ERC20 for IDO --
    ERC20 public constant dai = ERC20(0x4F96Fe3b7A6Cf9725f59d353F723c1bDb64CA6Aa); // Kovan DAI Address

    // -- Struct will be used to update user price after referral program --
     struct UserStruct {
        address userAddress;
        uint userPrice;
    }

    event newInvestor(address investor, uint purchaseAmount);
    event totalAmountPurchased(uint amount);

    UserStruct[] public users;
    mapping(address => bool) knownUser;
    mapping(address => uint) purchaseAmount;

    // -- Purchase options -- 
    uint classA = 500 * 10 ** 18;
    uint classB = 1000 * 10 ** 18;

    uint public totalPurchased;

    function purchaseIDO(uint _amount) external {
        require(!knownUser[msg.sender], "User already purchased IDO");
        require(_amount == classA || _amount == classB, "Purchase amount is not 500 or 1000");

        dai.transferFrom(msg.sender, address(this), _amount);

        addUser(msg.sender);
        
        totalPurchased += _amount;
        knownUser[msg.sender] = true;
        purchaseAmount[msg.sender] = _amount;

        emit newInvestor(msg.sender, _amount);
    }

    function addUser(address _user) internal returns (bool success) {
        require(!knownUser[_user], "User already exists");
        
        UserStruct memory newUserStruct;
        newUserStruct.userAddress = _user;
        users.push(newUserStruct);

        knownUser[_user] = true;
        return true; 
    }

    function getTotalAmount() external returns (uint TotalPurchased) {
        emit totalAmountPurchased(totalPurchased);
        return totalPurchased; 
    }

    function userCheck(address _user) external view returns (bool userExists) {
        require(knownUser[_user], "User does not exist");
        return true;
    }

    function getAllUsers() external view returns (UserStruct[] memory) {
        return users;
    }
}