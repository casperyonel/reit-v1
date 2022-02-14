//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2; // This is for returning an array of structs. 

// -- For veNFT logic --
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract veNFT is ERC721 {
    
    
    Struct Info {
        lockerId uint;
        tokenLocked address;
        amount uint;
        expiryDate uint;
    }
    
    
    using Counters for Counters.Counter;
    Counters.Counter private _tokensIds;

    constructor() public ERC721(, ) { }

    function mintNFT(address wallet, string memory tokenURI) public returns (uint256) {
        
        // I would use a struct and a mapping of the unique token id to the strict object
        info = Info ({
            lockerId: _lockerId,
            tokenLocked: _token,
            amount: _amount,
            expiryDate: block.timestamp + lockUpTime
        });

        _tokensIds.increment();

        uint newItemId = _tokensIds.current();
        _mint(wallet, newItemId);
        _setTokenURI(newItemId, tokenURI);

        return newItemId;
    }

    // write another function public view returns bool if token id is expired

}

