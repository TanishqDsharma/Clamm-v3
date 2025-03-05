// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.19;

import {ERC20}  from "../../lib/solmate/src/tokens/ERC20.sol";

contract ERC20mock is ERC20{

    constructor(string memory name_, 
                string memory symbol_, 
                uint8 _decimals) ERC20 (name_,symbol_,_decimals){

    }

    function mint(address to, uint256 amount) public {
        _mint(to, amount);
    }

}