// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyToken is ERC20, Ownable {
    constructor() ERC20("MyToken", "MTK") {
        
    }

    function mint() public onlyOwner {
        _mint(msg.sender,1000000000000);
    }

     function decimals() public view virtual override returns (uint8) {
        return 10;
    }


}
