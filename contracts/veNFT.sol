//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2; // This is for returning an array of structs. 

// -- For veNFT logic --
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract veNFT is ERC721 {
    
    mapping(uint => Info) public nftInfo;
    
    struct Info {
        lockerId uint;
        tokenLocked address;
        amount uint;
        expiryDate uint;
    }

    using Counters for Counters.Counter;
    Counters.Counter private _tokensIds;

    constructor() public ERC721(, ) { } // EDIT

    function mintNFT(
        address wallet, 
        string memory tokenURI, 
        uint _lockerId, 
        ERC20 _token, 
        uint _amount, 
        uint _lockUpTime
    ) public returns (uint256) {
        _tokensIds.increment();
        uint newItemId = _tokensIds.current();
        _mint(wallet, newItemId);
        _setTokenURI(newItemId, tokenURI);

        nftInfo[ newItemId ] = Info({ 
            lockerId: _lockerId,
            tokenLocked: _token,
            amount: _amount,
            expiryDate: uint32(block.timestamp + _lockUpTime)
        });

        return newItemId;
    }
    // where is string memory tokenURI coming from?

    function status(uint _tokenId) public view returns (Info) {
        return nftInfo[ _tokenId ]; 
    }

    function isExpired(uint _tokenId) public view returns (bool) {
        if (uint32(block.timestamp) > nftInfo[ _tokenId ].expiryDate) {
            return true;
        } else {
            return false;
        }
    }
}

