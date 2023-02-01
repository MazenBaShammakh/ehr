import 'package:dapp_ehr_1/config.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class User extends ChangeNotifier {
  //! WEB3 CONFIG
  late Client httpClient;
  late Web3Client ethClient;
  final String blockchainUrl =
  "https://sepolia.infura.io/v3/a6ab5f5f86dd42e2ae5aa65b5ed535be";
  // final String blockchainUrl = "http://127.0.0.1:7545";

  User() {
    httpClient = Client();
    ethClient = Web3Client(blockchainUrl, httpClient);
  }

  //* get deployed contract
  Future<DeployedContract> getContract(String contractName,
      {String? contractAddress}) async {
    String abiFile =
        await rootBundle.loadString("assets/contracts/$contractName.json");
    String contractAddressFinal =
        contractAddress ?? contractAddresses[contractName] as String;
    final contract = DeployedContract(
        ContractAbi.fromJson(abiFile, contractName),
        EthereumAddress.fromHex(contractAddressFinal));

    return contract;
  }

  //* call function (view-only)
  Future<List<dynamic>> callFunction(
      {required String functionName,
      required String contractName,
      String? contractAddress,
      List<dynamic> params = const []}) async {
    // interact with functions that don't require state modification (view)
    final contract =
        await getContract(contractName, contractAddress: contractAddress);
    final function = contract.function(functionName);
    final result = await ethClient.call(
      sender: _cred!.address,
      contract: contract,
      function: function,
      params: params,
    );
    return result;
  }

  //! ACCOUNT DETAILS
  EthereumAddress? _myAddress;
  // String? _privateKey;
  Credentials? _cred;

  set privateKey(String? pk) {
    // _privateKey = pk;
    _cred = EthPrivateKey.fromHex(pk!);
    _myAddress = _cred!.address;
    notifyListeners();
  }

  EthereumAddress? get address => _myAddress;
  EthereumAddress? _patientEhr;
  EthereumAddress? _doctorEhr;
  EthereumAddress? _hospitalEhr;

  Future<void> getPatientEhr() async {
    final patientEhr = await callFunction(
      functionName: "patientEhr",
      contractName: "EHR",
      params: [],
    );

    _patientEhr = patientEhr[0] as EthereumAddress;
  }

  Future<void> getDoctorEhr() async {
    final doctorEhr = await callFunction(
      functionName: "doctorEhr",
      contractName: "EHR",
      params: [],
    );

    _doctorEhr = doctorEhr[0] as EthereumAddress;
  }

  Future<void> getHospitalEhr() async {
    final hospitalEhr = await callFunction(
      functionName: "hospitalEhr",
      contractName: "EHR",
      params: [],
    );

    _hospitalEhr = hospitalEhr[0] as EthereumAddress;
  }

  //! EHR
  //* check if user has patient record
  Future<bool> hasPatientRecord() async {
    final patientEhr = await callFunction(
      functionName: "patientEhr",
      contractName: "EHR",
      params: [],
    );

    final result = await callFunction(
      functionName: "hasPatientRecord",
      contractName: "PatientEHR",
      params: [address],
      contractAddress: patientEhr[0].toString(),
    );

    // print(result[0]);
    return result[0] as bool;
  }

  //* check if user has doctor record
  Future<bool> hasDoctorRecord() async {
    final doctorEhr = await callFunction(
      functionName: "doctorEhr",
      contractName: "EHR",
      params: [],
    );

    final result = await callFunction(
        functionName: "hasDoctorRecord",
        contractName: "DoctorEHR",
        params: [address],
        contractAddress: doctorEhr[0].toString());

    return result[0] as bool;
  }

  //* check if user has hospital record
  Future<bool> hasHospitalRecord() async {
    final hospitalEhr = await callFunction(
      functionName: "hospitalEhr",
      contractName: "EHR",
      params: [],
    );

    final result = await callFunction(
        functionName: "hasHospitalRecord",
        contractName: "HospitalEHR",
        params: [address],
        contractAddress: hospitalEhr[0].toString());

    return result[0] as bool;
  }

  //* get user's patient record address
  Future<EthereumAddress> patientRecord() async {
    final patientEhr = await callFunction(
      functionName: "patientEhr",
      contractName: "EHR",
      params: [],
    );

    final result = await callFunction(
        functionName: "patientRecord",
        contractName: "PatientEHR",
        params: [address],
        contractAddress: patientEhr[0].toString());

    return result[0] as EthereumAddress;
  }

  //* get user's doctor record address
  Future<EthereumAddress> doctorRecord() async {
    final doctorEhr = await callFunction(
      functionName: "doctorEhr",
      contractName: "EHR",
      params: [],
    );

    final result = await callFunction(
        functionName: "doctorRecord",
        contractName: "DoctorEHR",
        params: [address],
        contractAddress: doctorEhr[0].toString());

    return result[0] as EthereumAddress;
  }

  //* get user's hospital record address
  Future<EthereumAddress> hospitalRecord() async {
    final hospitalEhr = await callFunction(
      functionName: "hospitalEhr",
      contractName: "EHR",
      params: [],
    );

    final result = await callFunction(
        functionName: "hospitalRecord",
        contractName: "HospitalEHR",
        params: [address],
        contractAddress: hospitalEhr[0].toString());

    return result[0] as EthereumAddress;
  }

  //* create new patient record for user
  Future<void> addPatientRecord(
      String firstName, String lastName, String id, int dob, int sex) async {
    final contract = await getContract(
      "PatientEHR",
      contractAddress: _patientEhr.toString(),
    );
    final function = contract.function("addPatientRecord");
    await ethClient.sendTransaction(
      _cred!,
      Transaction.callContract(
        contract: contract,
        function: function,
        parameters: [
          firstName,
          lastName,
          id,
          BigInt.from(dob),
          BigInt.from(sex)
        ],
      ),
    );
  }

  //* create new doctor record for user
  Future<void> addDoctorRecord(
      String firstName, String lastName, String id, int dob, int sex) async {
    final contract = await getContract(
      "DoctorEHR",
      contractAddress: _doctorEhr.toString(),
    );
    final function = contract.function("addDoctorRecord");
    await ethClient.sendTransaction(
      _cred!,
      Transaction.callContract(
        contract: contract,
        function: function,
        parameters: [
          firstName,
          lastName,
          id,
          BigInt.from(dob),
          BigInt.from(sex)
        ],
      ),
    );
  }

  //* create new hospital record for user
  Future<void> addHospitalRecord(
      String name, String location, String id) async {
    final contract = await getContract(
      "HospitalEHR",
      contractAddress: _hospitalEhr.toString(),
    );
    final function = contract.function("addHospitalRecord");
    await ethClient.sendTransaction(
      _cred!,
      Transaction.callContract(
        contract: contract,
        function: function,
        parameters: [name, location, id],
      ),
    );
  }

  //* get list of all hospitals (for fetching approved doctors)
  //! not implemented in EHR contract
  Future<List<EthereumAddress>?> getHospitals() async {
    final result = await callFunction(
      functionName: "getCount",
      contractName: "HospitalEHR",
      params: [],
      contractAddress: _hospitalEhr.toString(),
    );
    // int count = (result[0] as BigInt).toInt();

    List<EthereumAddress> hospitals = [];

    for (int i = 0; i < result[0].toInt(); i++) {
      final result = await callFunction(
        functionName: "hospitalRecords",
        contractName: "HospitalEHR",
        params: [BigInt.from(i)],
        contractAddress: _hospitalEhr.toString(),
      );
      hospitals.add(result[0] as EthereumAddress);
    }

    return hospitals;
  }

  //! PATIENT PROFILE
  String? _patientRecordAddress;

  set patientRecordAddress(String? address) {
    _patientRecordAddress = address;
    notifyListeners();
  }

  String? get patientRecordAddress {
    return _patientRecordAddress;
  }

  //* get all medical reports addresses
  Future<List<dynamic>?> patientGetMedicalReports() async {
    final result = await callFunction(
      functionName: "getMedicalReports",
      contractName: "Patient",
      params: [],
      contractAddress: patientRecordAddress,
    );

    return result[0];
  }

  //* get patient's biodata
  Future<dynamic> patientGetBiodata() async {
    final result = await callFunction(
      functionName: "getBiodata",
      contractName: "Patient",
      params: [],
      contractAddress: patientRecordAddress,
    );

    return result;
  }

  //* set patient's biodata
  Future<dynamic> patientSetBiodata(
      String firstName, String lastName, String id, int dob, int sex) async {
    final contract =
        await getContract("Patient", contractAddress: patientRecordAddress);
    final function = contract.function("setBiodata");
    await ethClient.sendTransaction(
      _cred!,
      Transaction.callContract(
        contract: contract,
        function: function,
        parameters: [
          firstName,
          lastName,
          id,
          BigInt.from(dob),
          BigInt.from(sex)
        ],
      ),
    );
  }

  //* grant access to doctor's profile
  Future<void> patientAddDoctor(EthereumAddress doctor) async {
    final contract = await getContract(
      "Patient",
      contractAddress: patientRecordAddress,
    );
    final function = contract.function("addDoctor");
    await ethClient.sendTransaction(
      _cred!,
      Transaction.callContract(
        contract: contract,
        function: function,
        parameters: [doctor],
      ),
    );
  }

  //* remove access from doctor's profile
  Future<void> patientRemoveDoctor(EthereumAddress doctor) async {
    final contract = await getContract(
      "Patient",
      contractAddress: patientRecordAddress,
    );
    final function = contract.function("removeDoctor");
    await ethClient.sendTransaction(
      _cred!,
      Transaction.callContract(
        contract: contract,
        function: function,
        parameters: [doctor],
      ),
    );
  }

  //* get medical report details given its address
  Future<dynamic> patientGetMedicalReportDetails(
      EthereumAddress medicalReport) async {
    final result = await callFunction(
      functionName: "getMedicalReportDetails",
      contractName: "Patient",
      params: [medicalReport],
      contractAddress: patientRecordAddress,
    );

    return result;
  }

  //* get patient's health data
  Future<dynamic> patientGetHealthData() async {
    final result = await callFunction(
      functionName: "getHealthData",
      contractName: "Patient",
      params: [],
      contractAddress: patientRecordAddress,
    );


    return result[0];
  }

  //* check if a particular doctor is granted access to patient's profile
  //? Permissions contract
  Future<bool> patientIsDoctorPermitted(EthereumAddress doctor) async {
    final result1 = await callFunction(
      functionName: "permissions",
      contractName: "Patient",
      params: [],
      contractAddress: patientRecordAddress,
    );

    String permissions = result1[0].toString();

    final result2 = await callFunction(
      functionName: "permissions",
      contractName: "Permissions",
      params: [doctor],
      contractAddress: permissions,
    );

    return result2[0] as bool;
  }

  //* get the list of permitted doctors
  //! not implemented in Permissions
  //? Permissions contract
  Future<dynamic> patientGetPermittedDoctors() async {}

  //! DOCTOR PROFILE
  String? _doctorRecordAddress;

  set doctorRecordAddress(String? address) {
    _doctorRecordAddress = address;
    notifyListeners();
  }

  String? get doctorRecordAddress {
    return _doctorRecordAddress;
  }

  //* get doctor's biodata
  Future<dynamic> doctorGetBiodata() async {
    final result = await callFunction(
      functionName: "getBiodata",
      contractName: "Doctor",
      params: [],
      contractAddress: doctorRecordAddress,
    );

    return result;
  }

  //* set doctor's biodata
  Future<dynamic> doctorSetBiodata(
      String firstName, String lastName, String id, int dob, int sex) async {
    final contract =
        await getContract("Doctor", contractAddress: doctorRecordAddress);
    final function = contract.function("setBiodata");
    await ethClient.sendTransaction(
      _cred!,
      Transaction.callContract(
        contract: contract,
        function: function,
        parameters: [
          firstName,
          lastName,
          id,
          BigInt.from(dob),
          BigInt.from(sex)
        ],
      ),
    );
  }

  Future<EthereumAddress?> doctorGetHospital() async {
    final result = await callFunction(
      functionName: "hospital",
      contractName: "Doctor",
      params: [],
      contractAddress: doctorRecordAddress,
    );

    return result[0] as EthereumAddress;
  }

  //* set doctor's hospital
  Future<dynamic> doctorSetHospital(EthereumAddress hospital) async {
    final contract =
        await getContract("Doctor", contractAddress: doctorRecordAddress);
    final function = contract.function("setHospital");
    await ethClient.sendTransaction(
      _cred!,
      Transaction.callContract(
        contract: contract,
        function: function,
        parameters: [hospital],
      ),
    );
  }

  //* get all patients addresses
  Future<List<dynamic>> doctorGetPatients() async {
    final result = await callFunction(
      functionName: "getPatients",
      contractName: "Doctor",
      params: [],
      contractAddress: doctorRecordAddress,
    );

    return result[0];
  }

  //* get a patient's medical report addresses
  Future<List<dynamic>> doctorGetPatientMedicalReports(
      EthereumAddress patient) async {
    final result = await callFunction(
      functionName: "getPatientMedicalReports",
      contractName: "Doctor",
      params: [patient],
      contractAddress: doctorRecordAddress,
    );

    return result[0];
  }

  //* get medical report details given its address
  Future<dynamic> doctorGetMedicalReportDetails(
      EthereumAddress medicalReport) async {
    final result = await callFunction(
      functionName: "getMedicalReportDetails",
      contractName: "Doctor",
      params: [medicalReport],
      contractAddress: doctorRecordAddress,
    );

    return result;
  }

  //* get patient's health data
  Future<dynamic> doctorGetHealthData(EthereumAddress patient) async {
    final result = await callFunction(
      functionName: "getHealthData",
      contractName: "Doctor",
      params: [patient],
      contractAddress: doctorRecordAddress,
    );

    return result[0];
  }

  //* set patient's health data
  Future<dynamic> doctorSetHealthData(EthereumAddress patient, int height,
      int weight, int bloodType, bool isSmoker, bool hasAllergy) async {
    final contract =
        await getContract("Doctor", contractAddress: doctorRecordAddress);
    final function = contract.function("setHealthData");
    await ethClient.sendTransaction(
      _cred!,
      Transaction.callContract(
        contract: contract,
        function: function,
        parameters: [
          patient,
          BigInt.from(height),
          BigInt.from(weight),
          BigInt.from(bloodType),
          isSmoker,
          hasAllergy
        ],
      ),
    );
  }

  //* add medical report to patient
  Future<dynamic> doctorAddMedicalReport(
      EthereumAddress patient,
      String diagnostic,
      List<String> medicine,
      List<int> numDays,
      List<int> perDay) async {
    final contract =
        await getContract("Doctor", contractAddress: doctorRecordAddress);
    final function = contract.function("addMedicalReport");

    //! implement logic
    List<BigInt> numDaysBI = [];
    List<BigInt> perDayBI = [];

    for (int i = 0; i < medicine.length; ++i) {
      numDaysBI.add(BigInt.from(numDays[i]));
      perDayBI.add(BigInt.from(perDay[i]));
    }

    await ethClient.sendTransaction(
      _cred!,
      Transaction.callContract(
        contract: contract,
        function: function,
        parameters: [patient, diagnostic, medicine, numDaysBI, perDayBI],
      ),
    );
  }

  //! HOSPITAL PROFILE
  String? _hospitalRecordAddress;

  set hospitalRecordAddress(String? address) {
    _hospitalRecordAddress = address;
    notifyListeners();
  }

  String? get hospitalRecordAddress {
    return _hospitalRecordAddress;
  }

  //* get hospital's biodata
  Future<dynamic> hospitalGetBiodata({String? hospitalRecordAddressByDoctor}) async {
    final result = await callFunction(
      functionName: "getBiodata",
      contractName: "Hospital",
      params: [],
      contractAddress: hospitalRecordAddressByDoctor ?? hospitalRecordAddress,
    );

    return result;
  }

  //* set hospital's biodata
  Future<dynamic> hospitalSetBiodata(
      String name, String location, String id) async {
    final contract =
        await getContract("Hospital", contractAddress: hospitalRecordAddress);
    final function = contract.function("setBiodata");
    await ethClient.sendTransaction(
      _cred!,
      Transaction.callContract(
        contract: contract,
        function: function,
        parameters: [name, location, id],
      ),
    );
  }

  //* get all approved doctors
  Future<List<EthereumAddress>?> hospitalGetApprovedDoctors({String? hospitalRecordAddressByPatient}) async {
    final result = await callFunction(
      functionName: "getApprovedDoctors",
      contractName: "Hospital",
      params: [],
      contractAddress: hospitalRecordAddressByPatient ?? hospitalRecordAddress,
    );

    List<EthereumAddress> doctors = [];
    for (int i = 0; i < result[1].toInt(); i++) {
      doctors.add(result[0][i]);
    }
    return doctors;
  }

  //* get all pending doctors
  Future<List<EthereumAddress>> hospitalGetPendingDoctors() async {
    final result = await callFunction(
      functionName: "getPendingDoctors",
      contractName: "Hospital",
      params: [],
      contractAddress: hospitalRecordAddress,
    );

    List<EthereumAddress> doctors = [];
    for (int i = 0; i < result[1].toInt(); i++) {
      doctors.add(result[0][i]);
    }

    return doctors;
  }

  //* approve a doctor
  Future<dynamic> hospitalApproveDoctor(EthereumAddress doctor) async {
    final contract =
        await getContract("Hospital", contractAddress: hospitalRecordAddress);
    final function = contract.function("approveDoctor");
    await ethClient.sendTransaction(
      _cred!,
      Transaction.callContract(
        contract: contract,
        function: function,
        parameters: [doctor],
      ),
    );
  }
}

// Future<void> vote(bool voteAlpha) async {
  //   //obtain private key for write operation
  //   Credentials key = EthPrivateKey.fromHex(
  //       "0x31104231120256ff4391727504d0af06c999faeb4eda52d6bf58bcb12b0c0d18");
  //   //obtain our contract from abi in json file
  //   final contract = await getContract("Flutter");
  //   // extract function from json file
  //   final function = contract.function(
  //     voteAlpha ? "voteAlpha" : "voteBeta",
  //   );
  //   //send transaction using our private key, function and contract
  //   await ethClient.sendTransaction(
  //       key,
  //       Transaction.callContract(
  //           contract: contract, function: function, parameters: []),
  //       chainId: 11155111);
  // }
