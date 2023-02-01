// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./1_Library.sol";
import "./6_Patient.sol";
import "./9_Permissions.sol";

contract MedicalReport {
    // STATE VARIABLES
    // doctor & patient
    address doctor;
    address patient;
    // medical report data
    uint dateTime;
    string diagnostic;
    Library.Prescription[] prescriptions;

    // CONSTRUCTOR
    constructor(
        address _patient, 
        string memory _diagnostic, 
        string[] memory _medicine, 
        uint[] memory _numDays, 
        uint[] memory _perDay
    ) {
        // doctor = tx.origin;
        // msg.sender -> doctor contract
        doctor = msg.sender;
        patient = _patient;

        dateTime = block.timestamp;
        diagnostic = _diagnostic;

        if(_medicine.length == _numDays.length 
            && _medicine.length == _perDay.length) {
                for (uint i = 0; i < _medicine.length; ++i) {
                    Library.Prescription memory _prescription = 
                        Library.Prescription(_medicine[i], _numDays[i], _perDay[i]);
                    prescriptions.push(_prescription);
                }
            }
    }

    // MODIFIERS
    modifier permittedAccess() {
        address permissions = Patient(patient).permissions();
        // msg.sender -> doctor or patient contract
        require(Permissions(permissions).permissions(msg.sender) == true, 
            "You don't have permission to access this medical report");
        _;
    }

    // FUNCTIONS
    function getMedicalReportDetails() public view permittedAccess returns(
        uint,
        string memory,
        Library.Prescription[] memory
    ) {
        return (dateTime, diagnostic, prescriptions);
    }

}
