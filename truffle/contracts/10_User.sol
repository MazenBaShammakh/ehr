// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./1_Library.sol";
import "./2_Ownable.sol";

contract User is Ownable {
    string firstName;
    string lastName;
    string id;
    uint dateOfBirth;
    Library.Sex sex;
    Library.User user;

    constructor(
        string memory _firstName,
        string memory _lastName,
        string memory _id,
        uint _dateOfBirth,
        Library.Sex _sex,
        Library.User _user
    ) {
        firstName = _firstName;
        lastName = _lastName;
        id = _id;
        dateOfBirth = _dateOfBirth;
        sex = _sex;
        user = _user;
    }

    function getBiodata() public view returns(
        string memory, 
        string memory, 
        string memory, 
        uint, 
        Library.Sex
    ) {
        return (firstName, lastName, id, dateOfBirth, sex);
    }

    function setBiodata(
        string memory _firstName,
        string memory _lastName,
        string memory _id,
        uint _dateOfBirth,
        Library.Sex _sex
    ) public isOwner {
        firstName = _firstName;
        lastName = _lastName;
        id = _id;
        dateOfBirth = _dateOfBirth;
        sex = _sex;
    }

}