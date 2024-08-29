// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./Poll.sol";

contract PollFactory {
    Poll[] public polls;

    event PollCreated(address pollAddress, string question);

    function createPoll(string memory question, string[] memory options, address tokenAddress) public {
        Poll newPoll = new Poll(question, options, tokenAddress);
        polls.push(newPoll);
        emit PollCreated(address(newPoll), question);
    }

    function getAllPolls() public view returns (Poll[] memory) {
        return polls;
    }
}
