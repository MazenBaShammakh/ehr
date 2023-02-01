// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./1_Library.sol";
import "./4_Hospital.sol";
import "./5_Doctor.sol";
import "./6_Patient.sol";

contract EHR {
    // STATE VARIABLES
    mapping(address => bool) public hasHospitalRecord;
    mapping(address => bool) public hasDoctorRecord;
    mapping(address => bool) public hasPatientRecord;
    mapping(address => address) public hospitalRecord;
    mapping(address => address) public doctorRecord;
    mapping(address => address) public patientRecord;
    mapping(uint => address) public hospitalRecords;
    uint public count;

    // CONSTRUCTOR

    // MODIFIERS
    modifier notHospital() {
        require(hasHospitalRecord[tx.origin] == false, 
            "You already have a hospital record");
        _;
    }

    modifier notDoctor() {
        require(hasDoctorRecord[tx.origin] == false, 
            "You already have a doctor record");
        _;
    }

     modifier notPatient() {
        require(hasPatientRecord[tx.origin] == false, 
            "You already have a patient record");
        _;
    }

    // FUNCTIONS
    function addHospitalRecord(
        string memory _name,
        string memory _location,
        string memory _id
    ) public payable notPatient notDoctor returns(address) {
        Hospital _hospital = new Hospital(_name, _location, _id);
        address hospitalAddress = address(_hospital);

        hasHospitalRecord[tx.origin] = true;
        hospitalRecord[tx.origin] = hospitalAddress;

        // hospitalRecords[count] = hospitalAddress;
        count++;

        return hospitalAddress;
    }

    function addDoctorRecord(
        string memory _firstName, 
        string memory _lastName, 
        string memory _id, 
        uint _dateOfBirth, 
        Library.Sex _sex
    ) public payable notDoctor notHospital returns(address) {
        Doctor _doctor = new Doctor(_firstName, _lastName, _id, _dateOfBirth, _sex);
        address doctorAddress = address(_doctor);

        hasDoctorRecord[tx.origin] = true;
        doctorRecord[tx.origin] = doctorAddress;

        return doctorAddress;
    }
    
    function addPatientRecord(
        string memory _firstName, 
        string memory _lastName, 
        string memory _id, 
        uint _dateOfBirth, 
        Library.Sex _sex
    ) public payable notPatient notHospital returns(address) {
        Patient _patient = new Patient(_firstName, _lastName, _id, _dateOfBirth, _sex);
        address patientAddress = address(_patient);

        hasPatientRecord[tx.origin] = true;
        patientRecord[tx.origin] = patientAddress;

        return patientAddress;
    }

}
