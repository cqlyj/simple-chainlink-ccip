// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {Script, console} from "forge-std/Script.sol";
import {TokenTransfer} from "src/TokenTransfer.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

contract AllowAmoyChain is Script {
    TokenTransfer public tokenTransfer;
    uint64 public constant AMOY_SELECTOR = 16281711391670634445;

    function allowAmoyChain(address mostRecentlyDeployed) public {
        tokenTransfer = TokenTransfer(payable(mostRecentlyDeployed));

        vm.startBroadcast();
        tokenTransfer.allowlistDestinationChain(AMOY_SELECTOR, true);
        vm.stopBroadcast();

        console.log("chain selector: ", AMOY_SELECTOR, " is allowed.");
    }

    function run() public {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "TokenTransfer",
            block.chainid
        );

        console.log("Most recently deployed address: ", mostRecentlyDeployed);
        allowAmoyChain(mostRecentlyDeployed);
    }
}
