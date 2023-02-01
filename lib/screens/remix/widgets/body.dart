import 'package:dapp_ehr_1/constants.dart';
import 'package:dapp_ehr_1/providers/user.dart';
import 'package:dapp_ehr_1/screens/default_body.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web3dart/credentials.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController pkController = TextEditingController();
  TextEditingController pFirstNameController = TextEditingController();
  TextEditingController pLastNameController = TextEditingController();
  TextEditingController pIdController = TextEditingController();
  TextEditingController pDOBController = TextEditingController();
  TextEditingController pSexController = TextEditingController();
  TextEditingController dFirstNameController = TextEditingController();
  TextEditingController dLastNameController = TextEditingController();
  TextEditingController dIdController = TextEditingController();
  TextEditingController dDOBController = TextEditingController();
  TextEditingController dSexController = TextEditingController();
  TextEditingController hNameController = TextEditingController();
  TextEditingController hLocationController = TextEditingController();
  TextEditingController hIdController = TextEditingController();
  TextEditingController pAddDoctor = TextEditingController();
  bool? hasPatientRecord;
  bool? hasDoctorRecord;
  bool? hasHospitalRecord;
  EthereumAddress? patientRecord;
  EthereumAddress? doctorRecord;
  EthereumAddress? hospitalRecord;
  dynamic patientBiodata;
  dynamic permittedDoctors;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return DefaultBody(
      title: "Remix Simulation",
      content: Column(
        // children: [
        //   Row(
        //     children: [
        //       Expanded(
        //         child: TextField(
        //           controller: pkController,
        //           decoration: const InputDecoration(
        //             label: Text("Private key"),
        //           ),
        //           obscureText: true,
        //         ),
        //       ),
        //       ElevatedButton(
        //         onPressed: () {
        //           if (pkController.text.length != 64) {
        //             showDialog(
        //               context: context,
        //               builder: (_) => AlertDialog(
        //                 title: const Text("Invalid private key"),
        //                 content: const Text(
        //                     "Ethereum private key must be 64 hexa-decimal characters"),
        //                 actions: [
        //                   TextButton(
        //                     onPressed: () => Navigator.of(context).pop(),
        //                     child: const Text("Ok"),
        //                   ),
        //                 ],
        //               ),
        //             );
        //           } else {
        //             final user = Provider.of<User>(
        //               context,
        //               listen: false,
        //             );
        //             user.privateKey = pkController.text;
        //           }
        //         },
        //         child: Text("Get address"),
        //       )
        //     ],
        //   ),
        //   sizedBoxV(2),
        //   Text("Address: ${user.address}"),
        //   sizedBoxV(4),
        //   Row(
        //     children: [
        //       Expanded(
        //         child: Row(
        //           children: [
        //             ElevatedButton(
        //               onPressed: () async {
        //                 final _user = Provider.of<User>(context, listen: false);
        //                 bool result = await user.hasPatientRecord();
        //                 setState(() {
        //                   hasPatientRecord = result;
        //                 });
        //               },
        //               child: Text("Has Patient Record"),
        //             ),
        //             sizedBoxH(2),
        //             Text(
        //               hasPatientRecord == true
        //                   ? "You are a patient"
        //                   : hasPatientRecord == false
        //                       ? "You are not a patient"
        //                       : "Unknown",
        //             ),
        //           ],
        //         ),
        //       ),
        //       Expanded(
        //         child: Row(
        //           children: [
        //             ElevatedButton(
        //               onPressed: () async {
        //                 final _user = Provider.of<User>(context, listen: false);
        //                 EthereumAddress result = await user.patientRecord();
        //                 user.patientRecordAddress = result.toString();
        //                 setState(() {
        //                   patientRecord = result;
        //                 });
        //               },
        //               child: Text("My Patient Record"),
        //             ),
        //             sizedBoxH(2),
        //             Flexible(
        //               child: Text(
        //                 patientRecord.toString(),
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        //   sizedBoxV(2),
        //   Row(
        //     children: [
        //       Expanded(
        //         child: Row(
        //           children: [
        //             ElevatedButton(
        //               onPressed: () async {
        //                 final _user = Provider.of<User>(context, listen: false);
        //                 bool result = await user.hasDoctorRecord();
        //                 setState(() {
        //                   hasDoctorRecord = result;
        //                 });
        //               },
        //               child: Text("Has Doctor Record"),
        //             ),
        //             sizedBoxH(2),
        //             Text(
        //               hasDoctorRecord == true
        //                   ? "You are a doctor"
        //                   : hasDoctorRecord == false
        //                       ? "You are not a doctor"
        //                       : "Unknown",
        //             ),
        //           ],
        //         ),
        //       ),
        //       Expanded(
        //         child: Row(
        //           children: [
        //             ElevatedButton(
        //               onPressed: () async {
        //                 final _user = Provider.of<User>(context, listen: false);
        //                 EthereumAddress result = await user.doctorRecord();
        //                 setState(() {
        //                   doctorRecord = result;
        //                 });
        //               },
        //               child: Text("My Doctor Record"),
        //             ),
        //             sizedBoxH(2),
        //             Flexible(
        //               child: Text(
        //                 doctorRecord.toString(),
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        //   sizedBoxV(2),
        //   Row(
        //     children: [
        //       Expanded(
        //         child: Row(
        //           children: [
        //             ElevatedButton(
        //               onPressed: () async {
        //                 final _user = Provider.of<User>(context, listen: false);
        //                 bool result = await user.hasHospitalRecord();
        //                 setState(() {
        //                   hasHospitalRecord = result;
        //                 });
        //               },
        //               child: Text("Has Hospital Record"),
        //             ),
        //             sizedBoxH(2),
        //             Text(
        //               hasHospitalRecord == true
        //                   ? "You are a hospital"
        //                   : hasHospitalRecord == false
        //                       ? "You are not a hospital"
        //                       : "Unknown",
        //             ),
        //           ],
        //         ),
        //       ),
        //       Expanded(
        //         child: Row(children: [
        //           ElevatedButton(
        //             onPressed: () async {
        //               final _user = Provider.of<User>(context, listen: false);
        //               EthereumAddress result = await user.hospitalRecord();
        //               setState(() {
        //                 hospitalRecord = result;
        //               });
        //             },
        //             child: Text("My Hospital Record"),
        //           ),
        //           sizedBoxH(2),
        //           Flexible(
        //             child: Text(
        //               hospitalRecord.toString(),
        //             ),
        //           ),
        //         ]),
        //       ),
        //     ],
        //   ),
        //   sizedBoxV(4),
        //   Row(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Expanded(
        //         child: Column(
        //           children: [
        //             Text("New Patient",
        //                 style: TextStyle(
        //                   fontWeight: FontWeight.bold,
        //                   fontSize: 24,
        //                 )),
        //             TextField(
        //               controller: pFirstNameController,
        //               decoration: InputDecoration(label: Text("First Name")),
        //             ),
        //             TextField(
        //               controller: pLastNameController,
        //               decoration: InputDecoration(label: Text("Last Name")),
        //             ),
        //             TextField(
        //               controller: pIdController,
        //               decoration: InputDecoration(label: Text("ID")),
        //             ),
        //             TextField(
        //               controller: pDOBController,
        //               decoration: InputDecoration(label: Text("DOB epoch")),
        //             ),
        //             TextField(
        //               controller: pSexController,
        //               decoration: InputDecoration(label: Text("Sex 0-1")),
        //             ),
        //             sizedBoxV(2),
        //             ElevatedButton(
        //               onPressed: () async {
        //                 final _user = Provider.of<User>(context, listen: false);
        //                 await _user.addPatientRecord(
        //                   pFirstNameController.text,
        //                   pLastNameController.text,
        //                   pIdController.text,
        //                   int.parse(pDOBController.text),
        //                   int.parse(pSexController.text),
        //                 );
        //               },
        //               child: Text("Create"),
        //             ),
        //           ],
        //         ),
        //       ),
        //       sizedBoxH(4),
        //       Expanded(
        //         child: Column(
        //           children: [
        //             Text("New Doctor",
        //                 style: TextStyle(
        //                   fontWeight: FontWeight.bold,
        //                   fontSize: 24,
        //                 )),
        //             TextField(
        //               controller: dFirstNameController,
        //               decoration: InputDecoration(label: Text("First Name")),
        //             ),
        //             TextField(
        //               controller: dLastNameController,
        //               decoration: InputDecoration(label: Text("Last Name")),
        //             ),
        //             TextField(
        //               controller: dIdController,
        //               decoration: InputDecoration(label: Text("ID")),
        //             ),
        //             TextField(
        //               controller: dDOBController,
        //               decoration: InputDecoration(label: Text("DOB epoch")),
        //             ),
        //             TextField(
        //               controller: dSexController,
        //               decoration: InputDecoration(label: Text("Sex 0-1")),
        //             ),
        //             sizedBoxV(2),
        //             ElevatedButton(
        //               onPressed: () async {
        //                 final _user = Provider.of<User>(context, listen: false);
        //                 await _user.addDoctorRecord(
        //                   dFirstNameController.text,
        //                   dLastNameController.text,
        //                   dIdController.text,
        //                   int.parse(dDOBController.text),
        //                   int.parse(dSexController.text),
        //                 );
        //               },
        //               child: Text("Create"),
        //             ),
        //           ],
        //         ),
        //       ),
        //       sizedBoxH(4),
        //       Expanded(
        //         child: Column(
        //           children: [
        //             Text("New Hospital",
        //                 style: TextStyle(
        //                   fontWeight: FontWeight.bold,
        //                   fontSize: 24,
        //                 )),
        //             TextField(
        //               controller: hNameController,
        //               decoration: InputDecoration(label: Text("Name")),
        //             ),
        //             TextField(
        //               controller: hLocationController,
        //               decoration: InputDecoration(label: Text("Location")),
        //             ),
        //             TextField(
        //               controller: hIdController,
        //               decoration: InputDecoration(label: Text("ID")),
        //             ),
        //             sizedBoxV(2),
        //             ElevatedButton(
        //               onPressed: () async {
        //                 final _user = Provider.of<User>(context, listen: false);
        //                 await _user.addHospitalRecord(
        //                   hNameController.text,
        //                   hLocationController.text,
        //                   hIdController.text,
        //                 );
        //               },
        //               child: Text("Create"),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        //   sizedBoxV(8),
        //   Column(
        //     children: [
        //       Text("Patient Profile"),
        //       Text(patientRecord.toString()),
        //       Row(
        //         children: [
        //           Expanded(
        //             child: Column(
        //               children: [
        //                 ElevatedButton(
        //                   onPressed: () async {
        //                     final _user =
        //                         Provider.of<User>(context, listen: false);
        //                     dynamic result = await user.getBiodata();
        //                     setState(() {
        //                       patientBiodata = result;
        //                     });
        //                   },
        //                   child: Text("Get Biodata"),
        //                 ),
        //                 Text(patientBiodata.toString()),
        //               ],
        //             ),
        //           ),
        //           Expanded(
        //             child: Column(
        //               children: [
        //                 TextField(
        //                   controller: pFirstNameController,
        //                   decoration:
        //                       InputDecoration(label: Text("First Name")),
        //                 ),
        //                 TextField(
        //                   controller: pLastNameController,
        //                   decoration: InputDecoration(label: Text("Last Name")),
        //                 ),
        //                 TextField(
        //                   controller: pIdController,
        //                   decoration: InputDecoration(label: Text("ID")),
        //                 ),
        //                 TextField(
        //                   controller: pDOBController,
        //                   decoration: InputDecoration(label: Text("DOB epoch")),
        //                 ),
        //                 TextField(
        //                   controller: pSexController,
        //                   decoration: InputDecoration(label: Text("Sex 0-1")),
        //                 ),
        //                 sizedBoxV(2),
        //                 ElevatedButton(
        //                   onPressed: () async {
        //                     final _user =
        //                         Provider.of<User>(context, listen: false);
        //                     await _user.setBiodata(
        //                       pFirstNameController.text,
        //                       pLastNameController.text,
        //                       pIdController.text,
        //                       int.parse(pDOBController.text),
        //                       int.parse(pSexController.text),
        //                     );
        //                   },
        //                   child: Text("Set Biodata"),
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ],
        //       ),
        //       Row(
        //         children: [
        //           Expanded(
        //             child: Column(
        //               children: [
        //                 ElevatedButton(
        //                   onPressed: () async {
        //                     final _user =
        //                         Provider.of<User>(context, listen: false);
        //                     dynamic result = await user.isDoctorPermitted(EthereumAddress.fromHex(pAddDoctor.text));
        //                     setState(() {
        //                       permittedDoctors = result;
        //                     });
        //                   },
        //                   child: Text("Get Permitted Doctors"),
        //                 ),
        //                 Text(permittedDoctors.toString()),
        //               ],
        //             ),
        //           ),
        //           Expanded(
        //             child: Column(
        //               children: [
        //                 TextField(
        //                   controller: pAddDoctor,
        //                   decoration:
        //                       InputDecoration(label: Text("Doctor Address")),
        //                 ),
        //                 sizedBoxV(2),
        //                 ElevatedButton(
        //                   onPressed: () async {
        //                     final _user =
        //                         Provider.of<User>(context, listen: false);
        //                     EthereumAddress doctor =
        //                         EthereumAddress.fromHex(pAddDoctor.text);
        //                     await _user.addDoctor(doctor);
        //                   },
        //                   child: Text("Add Doctor"),
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ],
        //       )
        //     ],
        //   ),
        // ],
      
      ),
    );
  }
}
