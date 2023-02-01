import 'package:dapp_ehr_1/constants.dart';
import 'package:dapp_ehr_1/providers/user.dart';
import 'package:dapp_ehr_1/screens/3_new_patient/new_patient_screen.dart';
import 'package:dapp_ehr_1/screens/4_new_doctor/new_doctor_screen.dart';
import 'package:dapp_ehr_1/screens/5_new_hospital/new_hospital_screen.dart';
import 'package:dapp_ehr_1/screens/6_patient_home/patient_home_screen.dart';
import 'package:dapp_ehr_1/screens/7_doctor_home/doctor_home_screen.dart';
import 'package:dapp_ehr_1/screens/8_hospital_home/hospital_home_screen.dart';
import 'package:dapp_ehr_1/screens/default_body.dart';
import 'package:dapp_ehr_1/widgets/option_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, bool> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, bool>;
    bool isNew = args["isNew"]!;

    return DefaultBody(
      title: "Who are you?",
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          OptionCard(
            child: defaultOptionCardChild(
              icon: Icons.sick,
              text: "Patient",
            ),
            onTap: () async {
              final user = Provider.of<User>(context, listen: false);
              bool hasPatientRecord = await user.hasPatientRecord();
              if (!hasPatientRecord) {
                Navigator.of(context).pushNamed(NewPatientScreen.routeName);
              } else if(hasPatientRecord) {
                Navigator.of(context)
                    .pushNamed(PatientHomeScreen.routeName);
              }
            },
          ),
          sizedBoxH(4),
          OptionCard(
            child: defaultOptionCardChild(
              icon: Icons.vaccines,
              text: "Doctor",
            ),
            onTap: () async {
              // check if user really doesn't have this user type record
              final user = Provider.of<User>(context, listen: false);
              bool hasDoctorRecord = await user.hasDoctorRecord();
              if (!hasDoctorRecord) {
                Navigator.of(context).pushNamed(NewDoctorScreen.routeName);
              } else if (hasDoctorRecord) {
                Navigator.of(context).pushNamed(DoctorHomeScreen.routeName);
              }
            },
          ),
          sizedBoxH(4),
          OptionCard(
            child: defaultOptionCardChild(
              icon: Icons.local_hospital,
              text: "Hospital",
            ),
            onTap: () async {
              // check if user really doesn't have this user type record
              final user = Provider.of<User>(context, listen: false);
              bool hasHospitalRecord = await user.hasHospitalRecord();
              if (!hasHospitalRecord) {
                Navigator.of(context).pushNamed(NewHospitalScreen.routeName);
              } else if (hasHospitalRecord) {
                Navigator.of(context).pushNamed(HospitalHomeScreen.routeName);
              }
            },
          ),
        ],
      ),
    );
  }
}
