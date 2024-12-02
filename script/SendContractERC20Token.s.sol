// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {Script, console} from "forge-std/Script.sol";
import {TokenTransfer} from "src/TokenTransfer.sol";
import {IERC20} from "@chainlink/contracts/src/v0.8/vendor/openzeppelin-solidity/v4.8.3/contracts/token/ERC20/IERC20.sol";
import {SafeERC20} from "@chainlink/contracts/src/v0.8/vendor/openzeppelin-solidity/v4.8.3/contracts/token/ERC20/utils/SafeERC20.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

contract SendContractERC20Token is Script {
    using SafeERC20 for IERC20;

    TokenTransfer public tokenTransfer;
    address public constant SEPOLIA_CCIP_BnM =
        0xFd57b4ddBf88a4e07fF4e34C487b99af2Fe82a05;
    uint256 public constant AMOUNT = 1e16; // 0.01

    function sendERC20ToContract(address mostRecentlyDeployed) public {
        tokenTransfer = TokenTransfer(payable(mostRecentlyDeployed));
        IERC20 token = IERC20(SEPOLIA_CCIP_BnM);

        vm.startBroadcast();
        token.approve(address(tokenTransfer), AMOUNT);
        token.safeTransfer(address(mostRecentlyDeployed), AMOUNT);
        vm.stopBroadcast();
    }

    function run() public {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "TokenTransfer",
            block.chainid
        );

        console.log("Most recently deployed address: ", mostRecentlyDeployed);
        sendERC20ToContract(mostRecentlyDeployed);
    }
}
