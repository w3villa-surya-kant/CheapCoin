// SPDX-License-Identifier: None
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract CheapCoin is ERC20 {

    address public admin = msg.sender;
    uint public Max_Supply ;
    //uint Tokens_sold = 0;
    uint public tokens_minted;
    constructor(uint256 initialSupply) ERC20("Cheap", "CHP") {
        _mint(msg.sender, initialSupply);
        Max_Supply = initialSupply + 10000;
        tokens_minted = initialSupply;
    }

    function mint(address to, uint256 amount) external {
        //require(msg.sender == admin, "only admin");
        require(Max_Supply > tokens_minted + amount,"Insufficient supply");
        _mint(to, amount);
    }

    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
    }
}
