import 'package:dapp_ehr_1/constants.dart';
import 'package:dapp_ehr_1/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:web3dart/web3dart.dart';

class MedicalReportCard extends StatelessWidget {
  const MedicalReportCard(
    this.medicalReport, {
    super.key,
    required this.isDoctor,
  });

  final EthereumAddress medicalReport;
  final bool isDoctor;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return FutureBuilder(
      future: isDoctor
          ? user.doctorGetMedicalReportDetails(medicalReport)
          : user.patientGetMedicalReportDetails(medicalReport),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          dynamic details = snapshot.data;
          DateTime dateTime =
              DateTime.fromMillisecondsSinceEpoch(details[0].toInt());
          String diagnostic = details[1];
          List<dynamic> prescription = details[2]; // only 1
          // print(prescription.runtimeType);
          // print(prescription[0]);
          dynamic medicine =
              prescription.isNotEmpty ? prescription[0][0] : "No medicine";
          int numDays =
              prescription.isNotEmpty ? prescription[0][1].toInt() : 0;
          int perDay = prescription.isNotEmpty ? prescription[0][2].toInt() : 0;
          // return Text(details.toString());
          return Container(
            padding: const EdgeInsets.all(kSpacingUnit * 2),
            margin: const EdgeInsets.only(bottom: kSpacingUnit * 4),
            decoration: BoxDecoration(
              border: Border.all(
                color: kColor.withOpacity(.2),
              ),
              borderRadius: BorderRadius.circular(kSpacingUnit*2),
            ),
            child: Column(
              children: [
                Text(
                  DateFormat('EEE, dd-MM-yyyy').format(dateTime),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                ),
                sizedBoxV(2),
                Text(
                  diagnostic,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                sizedBoxV(2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      medicine,
                      style: const TextStyle(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    sizedBoxH(1),
                    Text(
                      numDays.toString(),
                      style: const TextStyle(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    sizedBoxH(1),
                    Text(
                      perDay.toString(),
                      style: const TextStyle(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
