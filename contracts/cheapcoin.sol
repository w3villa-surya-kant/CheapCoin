// SPDX-License-Identifier: None
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract CheapCoin is ERC20, Ownable {

    address public admin = msg.sender;
    uint256 public Max_Supply;
    //uint Tokens_sold = 0;
    // uint256 public tokens_minted;
    
    address[] public users;
    mapping (address => uint) public userBalances;


    constructor(uint256 initialSupply) ERC20("Cheap", "CHP") {
        Max_Supply = 10000 * (10**18);
        require(
            initialSupply < Max_Supply,
            "Initial Supply should be smaller than Max Supply"
        );
        _mint(msg.sender, initialSupply);
        // tokens_minted = initialSupply;
    }



    function mint(address to, uint256 amount) external onlyOwner {
        //require(msg.sender == admin, "only admin");
        require(Max_Supply > totalSupply() + amount, "Insufficient supply");
        _mint(to, amount);
    }

    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
    }
}
