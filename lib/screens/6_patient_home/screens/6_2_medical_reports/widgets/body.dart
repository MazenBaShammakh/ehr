import 'package:dapp_ehr_1/constants.dart';
import 'package:dapp_ehr_1/providers/user.dart';
import 'package:dapp_ehr_1/screens/6_patient_home/screens/6_2_medical_reports/widgets/medical_report_card.dart';
import 'package:dapp_ehr_1/screens/default_body.dart';
import 'package:dapp_ehr_1/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web3dart/web3dart.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final Map<String, dynamic>? doctorView =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    print(doctorView);
    return FutureBuilder(
      future: doctorView != null && doctorView["isDoctor"]
          ? user.doctorGetPatientMedicalReports(
              doctorView["patient"] as EthereumAddress)
          : user.patientGetMedicalReports(),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          List<dynamic>? medicalReports = snapshot.data;
          print(medicalReports);
          return DefaultBody(
            title: "Your medical reports",
            content: Column(
              children: [
                if (doctorView != null && doctorView["isDoctor"]) ...[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        DoctorNewMedicalReport.routeName,
                        arguments: doctorView["patient"] as EthereumAddress,
                      );
                    },
                    child: Text("Add new medical report"),
                  ),
                  sizedBoxV(4),
                ],
                if (medicalReports != null) ...[
                  ...medicalReports
                      .map(
                        (mr) => MedicalReportCard(mr as EthereumAddress,
                            isDoctor: doctorView == null ? false : true),
                      )
                      .toList(),
                ],
                if (medicalReports == null)
                  const Center(child: Text("No medical reports yet")),
              ],
            ),
          );
        }
        return const Center(child: Text("loading"));
      },
    );
  }
}
