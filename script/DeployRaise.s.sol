// SPDX-License-Identifier: MIT
pragma solidity ^0.8.35;

import {Script} from "forge-std/Script.sol";
import {Raise} from "src/Raise.sol";

contract DeployRaiseScript is Script {
    function run() public returns (Raise) {
        vm.startBroadcast();
        Raise raise = new Raise();
        vm.stopBroadcast();
        return raise;
    }

    function runForTest(uint256 privateKey) public returns (Raise) {
        vm.startBroadcast(privateKey);
        Raise raise = new Raise();
        vm.stopBroadcast();
        return raise;
    }
}
