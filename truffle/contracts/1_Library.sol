// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library Library {
    // ENUMS
    enum BloodType { A, B, AB, O }
    enum Sex { Male, Female }
    enum User { Patient, Doctor, Hospital }
    enum DoctorStatus { Unknown, Approved, Pending, Removed }

    // STRUCTS
    struct Prescription {
        string medicine;
        uint numDays;
        uint perDay;
    }


}
