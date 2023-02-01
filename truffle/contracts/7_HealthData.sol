// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./1_Library.sol";
import "./2_Ownable.sol";
import "./6_Patient.sol";
import "./9_Permissions.sol";

contract HealthData is Ownable {
    // STATE VARIABLES
    uint height; // in cm
    uint weight; // in grams
    Library.BloodType bloodType;
    bool isSmoker;
    bool hasAllergy;
    address patient;

    // CONSTRUCTOR
    constructor() {
        patient = msg.sender;
    }

    // MODIFIERS
    modifier permittedAccess() {
        address permissions = Patient(patient).permissions();
        // msg.sender -> doctor & patient contracts
        require(Permissions(permissions).permissions(msg.sender) == true, 
            "You don't have permission to add or view health data & medical report");
        _;
    }

    // FUNCTIONS
    function getHealthData() public view permittedAccess returns(
        uint, 
        uint, 
        Library.BloodType, 
        bool, 
        bool
    ) {
        return (height, weight, bloodType, isSmoker, hasAllergy);
    }

    function setHealthData(
        uint _height, 
        uint _weight, 
        Library.BloodType _bloodType, 
        bool _isSmoker, 
        bool _hasAllergy
    ) public permittedAccess {
        // if (height != _height) 
        height = _height;
        // if (weight != _weight) 
        weight = _weight;
        // if (bloodType != _bloodType) 
        bloodType = _bloodType;
        // if (isSmoker != _isSmoker) 
        isSmoker = _isSmoker;
        // if (hasAllergy != _hasAllergy) 
        hasAllergy = _hasAllergy;
    }

}
