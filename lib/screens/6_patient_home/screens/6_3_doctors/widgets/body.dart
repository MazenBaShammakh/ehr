import 'package:dapp_ehr_1/providers/user.dart';
import 'package:dapp_ehr_1/screens/6_patient_home/screens/6_3_doctors/widgets/hospital_card.dart';
import 'package:dapp_ehr_1/screens/default_body.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web3dart/web3dart.dart';

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
        future: user.getHospitals(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            List<EthereumAddress>? hospitals = snapshot.data;
            // print(hospitals);
            return DefaultBody(
              title: "Looking for a doctor",
              content: Column(
                children: hospitals != null ? hospitals.map((hospital) => HospitalCard(hospital)).toList() : [],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}
