// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract NFT is ERC721Enumerable, Ownable {
  using Strings for uint256;
using Counters for Counters.Counter;

  string public baseURI;
  string public baseExtension = ".json";
  uint256 public cost = 5000000000 wei; // 0.5 for 10 decimal token
  uint256 public maxSupply = 3;
  bool public revealed = false;
  string public notRevealedUri;
    IERC20 public _tokencontract;
  Counters.Counter private _tokenIdCounter;

  constructor(address tokencontract ,string memory _initBaseURI,
    string memory _initNotRevealedUri) ERC721("MyToken", "MTK") {
        _tokencontract = IERC20(tokencontract);
         setBaseURI(_initBaseURI);
         setNotRevealedURI(_initNotRevealedUri);
         _tokenIdCounter.increment();

    }

  
  function _baseURI() internal view virtual override returns (string memory) {
    return baseURI;
  }


  function mint() public {

        for (uint256 i = 1; i <= maxSupply; i++) {
        uint256 tokenId = _tokenIdCounter.current();
        _tokencontract.transferFrom(msg.sender,address(this), cost);
        _safeMint(msg.sender, tokenId);
        _tokenIdCounter.increment();
        }
  }

  function tokenURI(uint256 tokenId)
    public
    view
    virtual
    override
    returns (string memory)
  {
    require(
      _exists(tokenId),
      "ERC721Metadata: URI query for nonexistent token"
    );
    
    if(revealed == false) {
        return notRevealedUri;
    }

    string memory currentBaseURI = _baseURI();
    return bytes(currentBaseURI).length > 0
        ? string(abi.encodePacked(currentBaseURI,"/",tokenId.toString(),baseExtension))
        : "";
  }

  function reveal() public onlyOwner {
      revealed = true;
  }
  
  
  function setNotRevealedURI(string memory _notRevealedURI) public onlyOwner {
    notRevealedUri = _notRevealedURI;
  }

  function setBaseURI(string memory _newBaseURI) public onlyOwner {
    baseURI = _newBaseURI;
  }

  function setBaseExtension(string memory _newBaseExtension) public onlyOwner {
    baseExtension = _newBaseExtension;
  }
}
