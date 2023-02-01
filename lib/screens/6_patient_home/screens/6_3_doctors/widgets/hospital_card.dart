import 'package:dapp_ehr_1/constants.dart';
import 'package:dapp_ehr_1/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web3dart/web3dart.dart';

import 'doctor_card.dart';

class HospitalCard extends StatelessWidget {
  const HospitalCard(this.hospital, {super.key});

  final EthereumAddress hospital;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return FutureBuilder(
      future: user.hospitalGetBiodata(
          hospitalRecordAddressByDoctor: hospital.toString()),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          List<dynamic> biodata = snapshot.data;
          return Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 24),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: kColor.withOpacity(.2),
                  ),
                  padding: const EdgeInsets.all(kSpacingUnit),
                  child: Text(
                    "${biodata[0]}, ${biodata[1]}",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                sizedBoxV(4),
                FutureBuilder(
                  future: user.hospitalGetApprovedDoctors(
                    hospitalRecordAddressByPatient: hospital.toString(),
                  ),
                  builder: (_, snapshot2) {
                    if (snapshot2.connectionState == ConnectionState.done) {
                      List<EthereumAddress> doctors = snapshot2.data!;
                      // print(doctors);
                      return doctors.isNotEmpty
                          ? Column(
                              children: doctors
                                  .map((doctor) => DoctorCard(doctor))
                                  .toList(),
                            )
                          : Text("No doctors found for ${biodata[0]}");
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ],
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
