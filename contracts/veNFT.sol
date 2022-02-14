//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2; // This is for returning an array of structs. 

// -- For veNFT logic --
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract veNFT is ERC721 {
    
    mapping(uint => Info) public nftInfo;
    
    Struct Info {
        lockerId uint;
        tokenLocked address;
        amount uint;
        expiryDate uint;
        lastTime uint;
    }

    using Counters for Counters.Counter;
    Counters.Counter private _tokensIds;

    constructor() public ERC721(, ) { } // EDIT

    function mintNFT(address wallet, string memory tokenURI, uint _lockerId, ERC20 _token, uint _amount, uint lockUpTime) public returns (uint256) {
        _tokensIds.increment();
        uint newItemId = _tokensIds.current();
        _mint(wallet, newItemId);
        _setTokenURI(newItemId, tokenURI);

        nftInfo[ newItemId ] = Info({ 
            lockerId: _lockerId,
            tokenLocked: _token,
            amount: _amount,
            expiryDate: uint32(block.timestamp + lockUpTime),
            lastTime: uint32(block.timestamp)
        });

        return newItemId;
    }

    // write another function public view returns bool if token id is expired

    // where is string memory tokenURI coming from?

    function status(uint _tokenId) public view returns (Info) {
        return nftInfo[ _tokenId ]; 
    }
}

