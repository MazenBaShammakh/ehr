import 'package:dapp_ehr_1/constants.dart';
import 'package:dapp_ehr_1/screens/6_patient_home/screens/6_2_medical_reports/patient_medical_reports_screen.dart';
import 'package:flutter/material.dart';
import 'package:web3dart/web3dart.dart';

class PatientCard extends StatelessWidget {
  const PatientCard(this.patient, {super.key});

  final EthereumAddress patient;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          PatientMedicalReportsScreen.routeName,
          arguments: {
            "isDoctor": true,
            "patient": patient,
          },
        );
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 24),
        padding: const EdgeInsets.all(kSpacingUnit * 2),
        decoration: BoxDecoration(
          border: Border.all(
            color: kColor.withOpacity(.2),
          ),
          borderRadius: BorderRadius.circular(kSpacingUnit * 2),
        ),
        child: Row(
          children: [
            Text(
              patient.toString(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Icon(Icons.chevron_right, color: kColor),
          ],
        ),
      ),
    );
  }
}
