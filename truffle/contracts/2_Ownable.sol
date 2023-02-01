// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Ownable {
    // STATE VARIABLES
    address owner;

    // CONSTRUCTOR
    constructor() {
        owner = tx.origin;
    }

    // MODIFIERS
    modifier isOwner() {
        require(owner == tx.origin, "You are not the owner");
        _;
    }

    // FUNCTIONS

}
