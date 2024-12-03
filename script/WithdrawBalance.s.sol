// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {Script, console} from "forge-std/Script.sol";
import {TokenTransfer} from "src/TokenTransfer.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

contract WithdrawBalance is Script {
    TokenTransfer public tokenTransfer;
    address public constant BENEFICIARY =
        0xFB6a372F2F51a002b390D18693075157A459641F;

    function withdrawBalance(address mostRecentlyDeployed) public {
        tokenTransfer = TokenTransfer(payable(mostRecentlyDeployed));

        vm.startBroadcast();
        tokenTransfer.withdraw(BENEFICIARY);
        vm.stopBroadcast();
    }

    function run() public {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "TokenTransfer",
            block.chainid
        );

        console.log("Most recently deployed address: ", mostRecentlyDeployed);
        withdrawBalance(mostRecentlyDeployed);
    }
}
