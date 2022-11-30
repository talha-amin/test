// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";


contract MyToken is ERC721, ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
     mapping(uint => string) _tokenURIs;
     bool private _isRevealed = false;
     string private _preRevealURI = "gateway.pinata.cloud/ipfs/QmcftHRoQ2G5qvdkMZFUEcByqXdtvkKuztSfZcMSWwbuw9";
     IERC20 public _tokencontract;
    uint maxsupply = 3;
    uint price = 1000000000 wei;
    Counters.Counter private _tokenIdCounter;

    constructor(address tokencontract) ERC721("MyToken", "MTK") {
        _tokencontract = IERC20(tokencontract);

    }

    function safeMint(address to, string memory uri) public onlyOwner {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _tokencontract.transferFrom(msg.sender,address(this), price);
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
    }
    
     function _baseURI() internal view override returns (string memory) {
        return _preRevealURI;
    }

    function reveal(string memory baseURI) public onlyOwner{
            _preRevealURI = baseURI;
            _isRevealed = true;
    }
    // The following functions are overrides required by Solidity.

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    //  function tokenURI(uint256 _tokenId) public view override(ERC721, ERC721URIStorage) returns(string memory) {
    //     require(_exists(_tokenId), "ERC721Metadata: URI query for nonexistent token");
    //     return bytes(_tokenURIs[_tokenId]).length > 0 ?
    //         string(abi.encodePacked(_tokenURIs[_tokenId],"/",Strings.toString(_tokenId),".json")) : "";
    // }
    
     function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {   
        if(!_isRevealed){
            return _preRevealURI;
        }
        return super.tokenURI(tokenId);
    }
}
