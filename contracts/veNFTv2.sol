//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2; // This is for returning an array of structs. 

// -- For veNFT logic --
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/presets/ERC721PresetMinterPauserAutoId.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract veNFTv2 is ERC721PresetMinterPauserAutoId {
    
    mapping( uint => Info ) public nftInfo;

    string public baseURI = "http://localhost:3001/ido/"; // CHANGE UPON DEPLOYMENT
    
    struct Info {
        uint lockerId;
        address tokenLocked;
        uint amount;
        uint expiryDate;
    }

    constructor() public ERC721PresetMinterPauserAutoId("Locked Voting MIL", "veMIL", baseURI) { }

    function mintNFT(
        address wallet, 
        string memory tokenURI, 
        uint _lockerId, 
        ERC20 _token,
        uint _amount, 
        uint _lockUpTime
    ) public {
        
        mint(wallet);

        nftInfo[ newItemId ] = Info({ 
            lockerId: _lockerId,
            tokenLocked: _token,
            amount: _amount,
            expiryDate: uint32(block.timestamp + _lockUpTime)
        });
    }
    // where is string memory tokenURI coming from?



    function status(uint _tokenId) public view returns (Info) {
        return nftInfo[ _tokenId ];  // Reading that you can only return primitives?
    }

    function isExpired(uint _tokenId) public view returns (bool) {
        if (uint32(block.timestamp) > nftInfo[ _tokenId ].expiryDate) {
            return true;
        } else {
            return false;
        }
    }
}

