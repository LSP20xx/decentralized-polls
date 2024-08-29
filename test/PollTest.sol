// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/Test.sol";
import "../src/VotingToken.sol";
import "../src/Poll.sol";
import "../src/PollFactory.sol";

contract PollTest is Test {
    VotingToken public token;
    Poll public poll;
    PollFactory public pollFactory;

    function setUp() public {
        token = new VotingToken(1000);
        pollFactory = new PollFactory();

        string;
        options[0] = "Option 1";
        options[1] = "Option 2";

        pollFactory.createPoll("Test Question", options, address(token));
        poll = pollFactory.polls(0);
    }

    function testVote() public {
        token.mint(address(this), 10);
        token.approve(address(poll), 10);

        poll.vote(0);
        assertEq(poll.getOptions()[0].voteCount, 10);
    }

    function testGetWinningOption() public {
        token.mint(address(this), 10);
        token.approve(address(poll), 10);

        poll.vote(0);
        assertEq(poll.getWinningOption(), "Option 1");
    }
}
