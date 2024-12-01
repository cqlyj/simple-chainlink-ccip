// SPDX-License-Identifier: MIT

import {Script} from "forge-std/Script.sol";
import {TokenTransfer} from "src/TokenTransfer.sol";

pragma solidity 0.8.26;

contract DeployTokenTransfer is Script {
    TokenTransfer public tokenTransfer;
    address constant SEPOLIA_ROUTER =
        0x0BF3dE8c5D3e8A2B34D2BEeB17ABfCeBaf363A59;
    address constant SEPOLIA_LINK = 0x779877A7B0D9E8603169DdbD7836e478b4624789;

    function run() public {
        vm.startBroadcast();
        tokenTransfer = new TokenTransfer(SEPOLIA_ROUTER, SEPOLIA_LINK);
        vm.stopBroadcast();
    }
}
