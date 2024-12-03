// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {Script, console} from "forge-std/Script.sol";
import {TokenTransfer} from "src/TokenTransfer.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

contract TransferTokenPayNative is Script {
    TokenTransfer public tokenTransfer;
    uint64 public constant AMOY_SELECTOR = 16281711391670634445;
    address public constant RECEIVER =
        0xFB6a372F2F51a002b390D18693075157A459641F;
    address public constant TOKEN_ADDRESS =
        0xFd57b4ddBf88a4e07fF4e34C487b99af2Fe82a05;
    uint256 public constant AMOUNT = 1e16; // 0.01

    function transferToken(address mostRecentlyDeployed) public {
        tokenTransfer = TokenTransfer(payable(mostRecentlyDeployed));

        vm.startBroadcast();
        tokenTransfer.transferTokensPayNative(
            AMOY_SELECTOR,
            RECEIVER,
            TOKEN_ADDRESS,
            AMOUNT
        );
        vm.stopBroadcast();

        console.log("Tokens transferred to ", RECEIVER);
    }

    function run() public {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "TokenTransfer",
            block.chainid
        );

        console.log("Most recently deployed address: ", mostRecentlyDeployed);
        transferToken(mostRecentlyDeployed);
    }
}
