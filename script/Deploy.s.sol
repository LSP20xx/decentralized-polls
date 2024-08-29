// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/Script.sol";
import "../src/VotingToken.sol";
import "../src/PollFactory.sol";

contract Deploy is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);

        VotingToken token = new VotingToken(1000);

        PollFactory pollFactory = new PollFactory();

        string;
        options[0] = "Option 1";
        options[1] = "Option 2";

        pollFactory.createPoll(
            "What's your favorite option?",
            options,
            address(token)
        );

        vm.stopBroadcast();
    }
}
