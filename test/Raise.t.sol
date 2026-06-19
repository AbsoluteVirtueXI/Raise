// SPDX-License-Identifier: MIT
pragma solidity ^0.8.35;

import {Test} from "forge-std/Test.sol";
import {Raise} from "src/Raise.sol";
import {DeployRaiseScript} from "script/DeployRaise.s.sol";

contract RaiseTest is Test {
    Raise public raise;
    address public deployer;
    uint256 public deployerKey;
    address public alice = makeAddr("alice Raise");
    address public bob = makeAddr("bob Raise");
    address public charlie = makeAddr("charlie Raise");
    uint256 public constant STARTING_BALANCE = 10 ether;

    function setUp() public {
        (deployer, deployerKey) = makeAddrAndKey("deployer Raise");
        vm.deal(deployer, STARTING_BALANCE);
        vm.deal(alice, STARTING_BALANCE);
        vm.deal(bob, STARTING_BALANCE);
        vm.deal(charlie, STARTING_BALANCE);
        DeployRaiseScript deployRaiseScript = new DeployRaiseScript();
        raise = deployRaiseScript.runForTest(deployerKey);
    }

    function test_deployerIsOwner() public view {
        assertEq(raise.owner(), deployer);
    }
}
