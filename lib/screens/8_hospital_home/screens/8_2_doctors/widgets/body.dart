import 'package:dapp_ehr_1/constants.dart';
import 'package:dapp_ehr_1/providers/user.dart';
import 'package:dapp_ehr_1/screens/default_body.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web3dart/web3dart.dart';

import 'doctor_card.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return DefaultBody(
      title: "Your list of doctors",
      content: Column(
        children: [
          const Text(
            "Approved Doctors",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          sizedBoxV(2),
          FutureBuilder(
            future: user.hospitalGetApprovedDoctors(),
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                List<EthereumAddress>? doctors = snapshot.data;
                return doctors!.isNotEmpty
                    ? Column(
                        children: doctors
                            .map((doctor) => DoctorCard(doctor, approved: true))
                            .toList(),
                      )
                    : const Text("No approved doctors");
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
          sizedBoxV(4),
          const Text(
            "Pending Doctors",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          sizedBoxV(2),
          FutureBuilder(
            future: user.hospitalGetPendingDoctors(),
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                List<EthereumAddress> doctors = snapshot.data!;
                return doctors.isNotEmpty
                    ? Column(
                        children: doctors
                            .map(
                                (doctor) => DoctorCard(doctor, approved: false))
                            .toList(),
                      )
                    : const Text("No pending doctors");
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }
}
