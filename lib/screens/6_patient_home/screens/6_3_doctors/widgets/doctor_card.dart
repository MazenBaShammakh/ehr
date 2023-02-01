import 'package:dapp_ehr_1/constants.dart';
import 'package:dapp_ehr_1/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web3dart/web3dart.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard(this.doctor, {super.key});

  final EthereumAddress doctor;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return FutureBuilder(
      future: user.patientIsDoctorPermitted(doctor),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          bool isPermitted = snapshot.data!;
          return Container(
            padding: const EdgeInsets.all(kSpacingUnit * 2),
            margin: const EdgeInsets.only(bottom: kSpacingUnit * 2),
            decoration: BoxDecoration(
              border: Border.all(
                color: kColor.withOpacity(.2),
              ),
              borderRadius: BorderRadius.circular(kSpacingUnit * 2),
            ),
            child: Row(
              children: [
                Text(
                  doctor.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () async {
                    final _user = Provider.of<User>(context, listen: false);
                    if (isPermitted) {
                      // remove
                      await _user
                          .patientRemoveDoctor(doctor);
                    } else {
                      // grant
                      await _user
                          .patientAddDoctor(doctor);
                    }
                  },
                  child: Text(
                    isPermitted ? "Remove permission" : "Grant permission",
                    style: const TextStyle(color: Colors.white),
                  ),
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
