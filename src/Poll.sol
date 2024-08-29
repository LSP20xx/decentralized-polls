// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./VotingToken.sol";

contract Poll {
    struct Option {
        string name;
        uint256 voteCount;
    }

    string public question;
    Option[] public options;
    mapping(address => bool) public hasVoted;
    VotingToken public votingToken;

    constructor(string memory _question, string[] memory _options, address tokenAddress) {
        question = _question;
        votingToken = VotingToken(tokenAddress);

        for (uint256 i = 0; i < _options.length; i++) {
            options.push(Option({name: _options[i], voteCount: 0}));
        }
    }

    function vote(uint256 optionIndex) public {
        require(!hasVoted[msg.sender], "You have already voted.");
        require(optionIndex < options.length, "Invalid option.");

        uint256 voterBalance = votingToken.balanceOf(msg.sender);
        require(voterBalance > 0, "You need VotingTokens to vote.");

        options[optionIndex].voteCount += voterBalance;
        hasVoted[msg.sender] = true;

        votingToken.transferFrom(msg.sender, address(this), voterBalance);
    }

    function getOptions() public view returns (Option[] memory) {
        return options;
    }

    function getWinningOption() public view returns (string memory winner) {
        uint256 winningVoteCount = 0;
        for (uint256 i = 0; i < options.length; i++) {
            if (options[i].voteCount > winningVoteCount) {
                winningVoteCount = options[i].voteCount;
                winner = options[i].name;
            }
        }
    }
}
