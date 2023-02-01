// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./1_Library.sol";
import "./2_Ownable.sol";
import "./12_DoctorEHR.sol";
import "./11_HospitalEHR.sol";

contract Hospital is Ownable {
    // STATE VARIABLES
    // biodata
    string name;
    string location;
    string id;
    // connected values
    mapping(address => Library.DoctorStatus) doctors; // Pending -> Approved -> Removed
    address[] doctorsAddress;
    address hospitalEhr;

    // CONSTRUCTOR
    constructor(
        string memory _name,
        string memory _location,
        string memory _id
    ) {
        // biodata
        name = _name;
        location = _location;
        id = _id;
        hospitalEhr = msg.sender;
    }

    // MODIFIERS
    modifier isDoctor() {
        address contractAddress = HospitalEHR(hospitalEhr).doctorEhr(); // ! assign after deploying EHR 
        require(DoctorEHR(contractAddress).hasDoctorRecord(tx.origin) == true, "You are not a doctor");
        _;
    }

    modifier addedDoctor() {
        // msg.sender -> doctor contract
        require(doctors[msg.sender] != Library.DoctorStatus.Unknown, "Doctor is not added previously");
        require(doctors[msg.sender] != Library.DoctorStatus.Removed, "Doctor is already removed");
        _;
    }

    // FUNCTIONS
    function getBiodata() public view returns(
        string memory, 
        string memory, 
        string memory
    ) {
        return (name, location, id);
    }

    function setBiodata(
        string memory _name,
        string memory _location,
        string memory _id
    ) public isOwner {
        // if (name != _name) 
        name = _name;
        // if (location != location) 
        location = _location;
        // if (id != _id) 
        id = _id;
    }

    function getApprovedDoctors() public view returns(address[] memory, uint) {
        address[] memory _doctors = new address[](doctorsAddress.length);
        uint count = 0;
        for (uint i = 0; i < doctorsAddress.length; ++i) {
            if (doctors[doctorsAddress[i]] == Library.DoctorStatus.Approved) {
                _doctors[count] = doctorsAddress[i];
                count++;
            }
        }
        return (_doctors, count);
    }

    function getPendingDoctors() public view returns(address[] memory, uint) {
        address[] memory _doctors = new address[](doctorsAddress.length);
        uint count = 0;
        for (uint i = 0; i < doctorsAddress.length; ++i) {
            if (doctors[doctorsAddress[i]] == Library.DoctorStatus.Pending) {
                _doctors[count] = doctorsAddress[i];
                count++;
            }
        }
        return (_doctors, count);
    }

    function addDoctor() public isDoctor {
        // msg.sender -> doctor contract
        doctors[msg.sender] = Library.DoctorStatus.Pending;
        doctorsAddress.push(msg.sender);
    }

    function removeDoctor() public isDoctor addedDoctor {
        // msg.sender -> doctor contract
        doctors[msg.sender] = Library.DoctorStatus.Removed;
    }

    function approveDoctor(address _doctor) public isOwner {
        doctors[_doctor] = Library.DoctorStatus.Approved;
    }
}
