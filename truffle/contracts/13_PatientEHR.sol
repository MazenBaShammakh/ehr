// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./1_Library.sol";
import "./6_Patient.sol";

contract PatientEHR {
    // STATE VARIABLES
    mapping(address => bool) public hasPatientRecord;
    mapping(address => address) public patientRecord;

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

    // modifier notDoctor() {
    //     require(hasDoctorRecord[tx.origin] == false, 
    //         "You already have a doctor record");
    //     _;
    // }

     modifier notPatient() {
        require(hasPatientRecord[tx.origin] == false, 
            "You already have a patient record");
        _;
    }

    // FUNCTIONS
    function addPatientRecord(
        string memory _firstName, 
        string memory _lastName, 
        string memory _id, 
        uint _dateOfBirth, 
        Library.Sex _sex
    ) public payable notPatient returns(address) {
        Patient _patient = new Patient(_firstName, _lastName, _id, _dateOfBirth, _sex);
        address patientAddress = address(_patient);

        hasPatientRecord[tx.origin] = true;
        patientRecord[tx.origin] = patientAddress;

        return patientAddress;
    }

}
