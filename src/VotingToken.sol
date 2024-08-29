// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract VotingToken is ERC20 {
    constructor(uint256 initialSupply) ERC20("VotingToken", "VOTE") {
        _mint(msg.sender, initialSupply);
    }

    function mint(address to, uint256 amount) public {
        _mint(to, amount);
    }
}
