// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./1_Library.sol";
// import "./2_Ownable.sol";
import "./4_Hospital.sol";
import "./7_HealthData.sol";
import "./8_MedicalReport.sol";
import "./13_PatientEHR.sol";
import "./12_DoctorEHR.sol";
import "./10_User.sol";

contract Doctor is User {
    // STATE VARIABLES
    // connected smart contracts & values
    address public hospital;
    mapping(address => bool) patients; // true if patient grants permission
    address[] patientsAddress;
    address doctorEhr;


    // CONSTRUCTOR
    constructor(
        string memory _firstName,
        string memory _lastName,
        string memory _id,
        uint _dateOfBirth,
        Library.Sex _sex
    ) User(_firstName, _lastName, _id, _dateOfBirth, _sex, Library.User.Doctor) {
        doctorEhr = msg.sender;
    }

    // MODIFIERS
    modifier isPatient() {
        address contractAddress = DoctorEHR(doctorEhr).patientEhr(); // ! assign after deploying EHR 
        require(PatientEHR(contractAddress).hasPatientRecord(tx.origin) == true, "You are not a patient");
        _;
    }

    modifier permittedAccess(address _patient) {
        require(patients[_patient] == true, "You don't have access to patient's medical report");
        _;
    }

    // FUNCTIONS
    function setHospital (address _hospital) public payable isOwner {
        if(hospital != address(0)) {
            // remove from old Hospital
            Hospital(hospital).removeDoctor();
        }

        // add to Hospital
        hospital = _hospital;
        Hospital(hospital).addDoctor();
    }

    function getPatients() public view isOwner returns(address[] memory, uint) {
        address[] memory _patients = new address[](patientsAddress.length);
        uint count = 0;
        for (uint i = 0; i < patientsAddress.length; ++i) {
            if (patients[patientsAddress[i]]) {
                _patients[count] = patientsAddress[i];
                count++;
            }
        }
        return (_patients, count);
    }

    function addPatient() public isPatient {
        patients[msg.sender] = true;
        patientsAddress.push(msg.sender);
    }

    function removePatient() public isPatient {
        patients[msg.sender] = false;
    }

    function addMedicalReport(
        address _patient,
        string memory _diagnostic,
        string[] memory _medicine, 
        uint[] memory _numDays, 
        uint[] memory _perDay
    ) public payable isOwner permittedAccess(_patient) returns(address) {
        MedicalReport _medicalReport = new MedicalReport(_patient, _diagnostic, _medicine, _numDays, _perDay);
        address _medicalReportAddress = address(_medicalReport);
        
        Patient(_patient).addMedicalReport(_medicalReportAddress);
        
        return _medicalReportAddress;
    }

    function getPatientMedicalReports(address _patient) public view isOwner returns(address[] memory) {
        address[] memory _medicalReports = Patient(_patient).getMedicalReports();
        return _medicalReports;
    }

    function getMedicalReportDetails(address _medicalReport) public view isOwner returns(
        uint,
        string memory,
        Library.Prescription[] memory
    ) {
        (uint _dateTime, string memory _diagnostic, Library.Prescription[] memory _prescriptions) = MedicalReport(_medicalReport).getMedicalReportDetails();
        return (_dateTime, _diagnostic, _prescriptions);
    }

    function getHealthData(address _patient) public view isOwner returns(
        uint, 
        uint, 
        Library.BloodType, 
        bool, 
        bool
    ) {
        address _healthData = Patient(_patient).healthData();
        return HealthData(_healthData).getHealthData();
    }

    function setHealthData(
        address _patient,
        uint _height, 
        uint _weight, 
        Library.BloodType _bloodType, 
        bool _isSmoker, 
        bool _hasAllergy
    ) public isOwner {
        address _healthData = Patient(_patient).healthData();
        HealthData(_healthData).setHealthData(_height, _weight, _bloodType, _isSmoker, _hasAllergy);
    }
}
