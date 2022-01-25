//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2; // This is for returning an array of structs. 
// pragma abicoderv2; // Or this?

import "hardhat/console.sol";

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract PreSale {
    // using SafeERC20 for ERC20;
    // using Address for address;

    // uint constant ETHdecimals = 10 ** 18;
    // uint constant Rdecimals = 10 ** 9;
    // uint public constant MAX_SOLD = 7000 * Rdecimals;
    // uint public constant PRICE = 5 * ETHdecimals / Rdecimals;
    // // Need min presale per account for R
    // // Need max presale per account for R

    // address public dev;
    // ERC20 MIM;

    // uint public sold;
    // address public R;
    // bool canClaim;
    // bool privateSale;
    // mapping(address => uint256) public invested;
    // mapping(address => bool) public claimed;
    // mapping(address => bool) public approvedBuyers;

    // constructor() {
    //     ETH = ERC20(0x130966628846BFd36ff31a822705796e8cb8C18D);
    //     dev = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;
    // }

    // modifier onlyEOA() {
    //     require(msg.sender == tx.origin, "!EOA");
    //     _;
    // }

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

    function getUserIndexPosition(address userAddress) external view returns (uint indexPosition) {
        require(knownUser[userAddress] == true, "User is not in the contract"); 
        return users.indexOf(userAddress);
    }

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

    // Solidity will now allow us to return an array of structs, so here we creat and return an array of addresses and array of IDO prices;
    // function getAllUsers() external returns (address[] memory, uint[] memory) {
    //     address[] memory userAddresses = new address[](users.length); // Need to delcare length of array since stored in memory.
    //     uint[] memory userPrices = new uint[](users.length);
        
    //     for (uint i = 0; i < users.length; i++) {
    //         userAddresses[i] = users[i].userAddress;
    //         userPrices[i] = users[i].userPrice;
    //     }
    //     return (userAddresses, userPrices); // Will need to convert these 2 arrays into a single array on frontend. 
    // }

    // OR

    // Returns an array of structs, with experimental decleration:
    function getAllUsers() external returns (UserStruct[] memory) {
        return users;
    }














    // /* Approving buyers into new whitelist */
    // function _approveBuyer(address newBuyer_) internal onlyOwner() returns (bool) {
    //     approvedBuyers[newBuyer_] = true;
    //     return approvedBuyers[newBuyer_];
    // }

    // // Outside admin calling on contract to call on function above to approve buyer of IDO:
    // function approveBuyer(address newBuyer_) external onlyOwner() returns (bool) {
    //     return _approveBuyer(newBuyer_);
    // }

    // function _deapproveBuyer(address newBuyer_) internal onlyOwner() returns (bool) {
    //     approvedBuyers[newBuyer_] = false;
    //     return approvedBuyers[newBuyer_];
    // }

    // // Outside admin calling on contract to call on function above to approve buyer of IDO:
    // function deapproveBuyer(address newBuyer_) external onlyOwner() returns (bool) {
    //     return _deapproveBuyer(newBuyer_);
    // }

}