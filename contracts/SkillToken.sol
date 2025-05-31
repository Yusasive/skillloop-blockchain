// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SkillToken is ERC20, Ownable {
    uint256 public constant FAUCET_AMOUNT = 100 * 10**18;

    mapping(address => bool) public hasClaimed;

    constructor() ERC20("SkillToken", "SKL") Ownable(msg.sender) {
        _mint(msg.sender, 1000000 * 10**18); 
    }

    function faucet() external {
        require(!hasClaimed[msg.sender], "Faucet already used");
        hasClaimed[msg.sender] = true;
        _mint(msg.sender, FAUCET_AMOUNT);
    }

    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }
}
