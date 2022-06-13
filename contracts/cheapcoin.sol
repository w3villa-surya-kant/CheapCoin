// SPDX-License-Identifier: None
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract CheapCoin is ERC20, Ownable {
    // address public admin = msg.sender;
    uint256 public Max_Supply;
    //uint Tokens_sold = 0;
    // uint256 public tokens_minted;

    struct balanceStruct {
        uint256 balance;
        bool exist;
    }

    address[] public users;
    mapping(address => balanceStruct) public userBalances;

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

    function burn(uint256 amount) external onlyOwner {
        _burn(msg.sender, amount);
    }

    function _afterTokenTransfer(address from, address to) internal virtual {
        uint256 fromBalance = balanceOf(from);
        uint256 toBalance = balanceOf(to);
        if (userBalances[from].exist == false) {
            users.push(from);
            userBalances[from].exist = true;
            userBalances[from].balance = fromBalance;
        } else {
            userBalances[from].balance = fromBalance;
        }
        if (userBalances[from].exist == false) {
            users.push(to);
            userBalances[to].exist = true;
            userBalances[to].balance = toBalance;
        } else {
            userBalances[to].balance = toBalance;
        }
    }
}
