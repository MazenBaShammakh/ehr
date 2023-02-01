// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./1_Library.sol";
import "./4_Hospital.sol";
// import "./5_Doctor.sol";
// import "./6_Patient.sol";

contract HospitalEHR {
    // STATE VARIABLES
    mapping(address => bool) public hasHospitalRecord; // address is hospital?
    mapping(address => address) public hospitalRecord; // address of associated hospital record
    mapping(uint => address) public hospitalRecords;
    uint public count;

    function getCount() public view returns(uint) {
        return count;
    }

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
    modifier notHospital() {
        require(hasHospitalRecord[tx.origin] == false, 
            "You already have a hospital record");
        _;
    }

    // FUNCTIONS
    function addHospitalRecord(
        string memory _name,
        string memory _location,
        string memory _id
    ) public payable notHospital returns(address) {
        Hospital _hospital = new Hospital(_name, _location, _id);
        address hospitalAddress = address(_hospital);

        hasHospitalRecord[tx.origin] = true;
        hospitalRecord[tx.origin] = hospitalAddress;

        hospitalRecords[count] = hospitalAddress;
        count++;

        return hospitalAddress;
    }

}
