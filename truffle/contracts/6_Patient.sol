// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./1_Library.sol";
import "./5_Doctor.sol";
import "./7_HealthData.sol";
import "./8_MedicalReport.sol";
import "./9_Permissions.sol";
import "./12_DoctorEHR.sol";
import "./13_PatientEHR.sol";
import "./10_User.sol";

contract Patient is User {
    // STATE VARIABLES

    // connected smart contracts
    address public healthData;
    address[] medicalReports;
    address public permissions;
    address patientEhr;


    // CONSTRUCTOR
    constructor(
        string memory _firstName,
        string memory _lastName,
        string memory _id,
        uint _dateOfBirth,
        Library.Sex _sex
    ) User(_firstName, _lastName, _id, _dateOfBirth, _sex, Library.User.Patient) {
        // connected smart contracts
        HealthData _healthData = new HealthData();
        healthData = address(_healthData);

        Permissions _permissions = new Permissions();
        permissions = address(_permissions);

        patientEhr = msg.sender;
    }


    // MODIFIERS
    modifier permittedAccess() {
        // msg.sender -> doctor or patient contract
        require(Permissions(permissions).permissions(msg.sender) == true, 
            "You don't have permission to access health data & medical report");
        _;
    }

    modifier isDoctor() {
        address contractAddress = PatientEHR(patientEhr).doctorEhr(); // ! assign after deploying EHR 
        require(DoctorEHR(contractAddress).hasDoctorRecord(tx.origin) == true, "You are not a doctor");
        _;
    }

    // FUNCTIONS
    function getMedicalReports() public view returns(address[] memory) {
        return medicalReports;
    }

    function addMedicalReport(
        // address _patient,
        // string memory _diagnostic,
        // string[] memory _medicine, 
        // uint[] memory _numDays, 
        // uint[] memory _perDay
        address _medicalReportAddress
    ) public payable permittedAccess isDoctor {
        // MedicalReport _medicalReport = new MedicalReport(_patient, _diagnostic, _medicine, _numDays, _perDay);
        // address _medicalReportAddress = address(_medicalReport);
        
        medicalReports.push(_medicalReportAddress);
        // return _medicalReportAddress;
    }

    function addDoctor(address _doctor) public payable isOwner {
        // grant permission
        Permissions(permissions).grantPermission(_doctor);
        Doctor(_doctor).addPatient();
    }

    function removeDoctor(address _doctor) public payable isOwner {
        // remove permission
        Permissions(permissions).removePermission(_doctor);
        Doctor(_doctor).removePatient();
    }

    function getMedicalReportDetails(address _medicalReport) public view isOwner returns(
        uint,
        string memory,
        Library.Prescription[] memory
    ) {
        (uint _dateTime, string memory _diagnostic, Library.Prescription[] memory _prescriptions) = MedicalReport(_medicalReport).getMedicalReportDetails();
        return (_dateTime, _diagnostic, _prescriptions);
    }

    function getHealthData() public view isOwner returns(
        uint, 
        uint, 
        Library.BloodType, 
        bool, 
        bool
    ) {
        return HealthData(healthData).getHealthData();
    }

}
