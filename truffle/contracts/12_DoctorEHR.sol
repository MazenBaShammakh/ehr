// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./1_Library.sol";
import "./5_Doctor.sol";

contract DoctorEHR {
    // STATE VARIABLES
    mapping(address => bool) public hasDoctorRecord;
    mapping(address => address) public doctorRecord;
    address public patientEhr;
    address public hospitalEhr;
    address public doctorEhr;

    function setPatientEhr(address _addr) public {
        patientEhr = _addr;
    }

    function setHospitalEhr(address _addr) public {
        hospitalEhr = _addr;
    }

    function setDoctorEhr(address _addr) public {
        doctorEhr = _addr;
    }

    // CONSTRUCTOR

    // MODIFIERS
    // modifier notHospital() {
    //     require(hasHospitalRecord[tx.origin] == false, 
    //         "You already have a hospital record");
    //     _;
    // }

    modifier notDoctor() {
        require(hasDoctorRecord[tx.origin] == false, 
            "You already have a doctor record");
        _;
    }

    // FUNCTIONS
    function addDoctorRecord(
        string memory _firstName, 
        string memory _lastName, 
        string memory _id, 
        uint _dateOfBirth, 
        Library.Sex _sex
    ) public payable notDoctor returns(address) {
        Doctor _doctor = new Doctor(_firstName, _lastName, _id, _dateOfBirth, _sex);
        address doctorAddress = address(_doctor);

        hasDoctorRecord[tx.origin] = true;
        doctorRecord[tx.origin] = doctorAddress;

        return doctorAddress;
    }
}
