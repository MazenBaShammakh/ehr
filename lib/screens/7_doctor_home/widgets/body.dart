import 'package:dapp_ehr_1/constants.dart';
import 'package:dapp_ehr_1/providers/user.dart';
import 'package:dapp_ehr_1/screens/7_doctor_home/screens/6_1_biodata/doctor_biodata_screen.dart';
import 'package:dapp_ehr_1/screens/7_doctor_home/screens/6_2_hospital/doctor_hospital_screen.dart';
import 'package:dapp_ehr_1/screens/7_doctor_home/screens/6_3_patients/doctor_patients_screen.dart';
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
    // TODO: implement initState
    final user = Provider.of<User>(context, listen: false);
    user.doctorRecord().then((address) {
      user.doctorRecordAddress = address.toString();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context, listen: true);
    return DefaultBody(
      title: "Welcome to your doctor dashboard",
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
                  .pushNamed(DoctorBiodataScreen.routeName);
            },
          ),
          sizedBoxH(4),
          OptionCard(
            child: defaultOptionCardChild(
              icon: Icons.local_hospital,
              text: "Hospital",
            ),
            onTap: () {
              Navigator.of(context)
                  .pushNamed(DoctorHospitalScreen.routeName);
            },
          ),
          sizedBoxH(4),
          OptionCard(
            child: defaultOptionCardChild(
              icon: Icons.sick,
              text: "Patients",
            ),
            onTap: () {
              Navigator.of(context)
                  .pushNamed(DoctorPatientsScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
