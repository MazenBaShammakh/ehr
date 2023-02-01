// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./12_DoctorEHR.sol";
import "./13_PatientEHR.sol";
import "./11_HospitalEHR.sol";

contract EHR {
    address public doctorEhr;
    address public hospitalEhr;
    address public patientEhr;

    constructor() {
        DoctorEHR _doctorEhr = new DoctorEHR();
        PatientEHR _patientEhr = new PatientEHR();
        HospitalEHR _hospitalEhr = new HospitalEHR();

        doctorEhr = address(_doctorEhr);
        patientEhr = address(_patientEhr);
        hospitalEhr = address(_hospitalEhr);

        _doctorEhr.setHospitalEhr(hospitalEhr);
        _doctorEhr.setPatientEhr(patientEhr);
        _doctorEhr.setDoctorEhr(doctorEhr);

        _patientEhr.setHospitalEhr(hospitalEhr);
        _patientEhr.setDoctorEhr(doctorEhr);
        _patientEhr.setPatientEhr(patientEhr);

        _hospitalEhr.setDoctorEhr(doctorEhr);
        _hospitalEhr.setPatientEhr(patientEhr);
        _hospitalEhr.setHospitalEhr(hospitalEhr);
    }
}