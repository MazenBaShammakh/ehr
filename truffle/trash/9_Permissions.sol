// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./2_Ownable.sol";

contract Permissions is Ownable {
    // STATE VARIABLES
    mapping(address => bool) public permissions;

    // CONSTRUCTOR
    constructor() {
        super;
        permissions[msg.sender] = true;
    }

    // MODIFIERS


    // FUNCTIONS
    function grantPermission(address _permitted) public isOwner {
        permissions[_permitted] = true;
    }

    function removePermission(address _permitted) public isOwner {
        permissions[_permitted] = false;
    }

}
