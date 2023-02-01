// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./2_Ownable.sol";

contract Permissions is Ownable {
    // STATE VARIABLES
    mapping(address => bool) public permissions;
    mapping(uint => address) permitted;
    uint count;

    // CONSTRUCTOR
    constructor() {
        super;
        permissions[msg.sender] = true;
    }

    // MODIFIERS


    // FUNCTIONS
    function grantPermission(address _permitted) public isOwner {
        permissions[_permitted] = true;
        permitted[count] = _permitted;
        count++;
    }

    function removePermission(address _permitted) public isOwner {
        permissions[_permitted] = false;
    }

    function getPermittedDoctors() public view isOwner returns(address[] memory, uint){
        address[] memory _permitted = new address[](count);
        uint counter = 0;
        for (uint i = 0; i < count; ++i) {
            if (permissions[permitted[i]]) {
                _permitted[counter] = permitted[i];
                counter++;
            }
        }
        return (_permitted, counter);
    }

}
