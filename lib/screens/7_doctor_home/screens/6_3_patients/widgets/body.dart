import 'package:dapp_ehr_1/providers/user.dart';
import 'package:dapp_ehr_1/screens/default_body.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web3dart/web3dart.dart';

import 'patient_card.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return FutureBuilder(
        future: user.doctorGetPatients(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            List<dynamic>? patients = snapshot.data;
            List<dynamic>? updatedPatients = patients!.toSet().toList();
            // print("patients $patients");
            // print("updatedPatients $updatedPatients");
            return DefaultBody(
              title: "These are your patients",
              content: Column(
                children: patients != null
                    ? updatedPatients.map((patient) => PatientCard(patient)).toList()
                    : [Center(child: Text("No patients yet"))],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}
