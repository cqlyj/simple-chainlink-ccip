// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {Script, console} from "forge-std/Script.sol";
import {TokenTransfer} from "src/TokenTransfer.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

contract FundContractWithNativeEth is Script {
    TokenTransfer public tokenTransfer;
    uint256 public constant AMOUNT = 1e16; // 0.01

    function fundContractWithNativeEth(address mostRecentlyDeployed) public {
        tokenTransfer = TokenTransfer(payable(mostRecentlyDeployed));

        vm.startBroadcast();
        payable(address(tokenTransfer)).transfer(AMOUNT);
        vm.stopBroadcast();
    }

    function run() public {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "TokenTransfer",
            block.chainid
        );

        console.log("Most recently deployed address: ", mostRecentlyDeployed);
        fundContractWithNativeEth(mostRecentlyDeployed);
    }
}
