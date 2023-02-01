import 'package:dapp_ehr_1/constants.dart';
import 'package:dapp_ehr_1/providers/user.dart';
import 'package:dapp_ehr_1/screens/6_patient_home/screens/6_1_biodata/patient_biodata_screen.dart';
import 'package:dapp_ehr_1/screens/6_patient_home/screens/6_2_medical_reports/patient_medical_reports_screen.dart';
import 'package:dapp_ehr_1/screens/6_patient_home/screens/6_3_doctors/patient_doctors_screen.dart';
import 'package:dapp_ehr_1/screens/default_body.dart';
import 'package:dapp_ehr_1/widgets/option_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    final user = Provider.of<User>(context, listen: false);
    user.patientRecord().then((address) {
      user.patientRecordAddress = address.toString();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context, listen: true);
    return DefaultBody(
      title: "Welcome to your patient dashboard",
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          OptionCard(
            child: defaultOptionCardChild(
              icon: Icons.info,
              text: "Biodata",
            ),
            onTap: () {
              Navigator.of(context)
                  .pushNamed(PatientBiodataScreen.routeName);
            },
          ),
          sizedBoxH(4),
          OptionCard(
            child: defaultOptionCardChild(
              icon: Icons.document_scanner,
              text: "Reports",
            ),
            onTap: () {
              Navigator.of(context)
                  .pushNamed(PatientMedicalReportsScreen.routeName);
            },
          ),
          sizedBoxH(4),
          OptionCard(
            child: defaultOptionCardChild(
              icon: Icons.vaccines,
              text: "Doctors",
            ),
            onTap: () {
              Navigator.of(context)
                  .pushNamed(PatientDoctorsScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
