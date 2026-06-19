// SPDX-License-Identifier: MIT
pragma solidity ^0.8.35;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract Raise is Ownable {
    error RaiseOwnableUnauthorizedAccount(address caller, address owner);

    constructor() Ownable(msg.sender) {}

    function fund() public {}

    function withdraw() public onlyOwner {}

    /**
     * @dev Throws if the sender is not the owner.
     * @dev Overrides Ownable's owner check to use a contract-specific custom error.
     */
    function _checkOwner() internal view override {
        if (owner() != _msgSender()) {
            revert RaiseOwnableUnauthorizedAccount(_msgSender(), owner());
        }
    }
}
