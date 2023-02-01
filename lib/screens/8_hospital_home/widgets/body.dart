import 'package:dapp_ehr_1/constants.dart';
import 'package:dapp_ehr_1/providers/user.dart';
import 'package:dapp_ehr_1/screens/8_hospital_home/screens/8_1_biodata/hospital_biodata_screen.dart';
import 'package:dapp_ehr_1/screens/8_hospital_home/screens/8_2_doctors/hospital_doctors_screen.dart';
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
    user.hospitalRecord().then((address) {
      user.hospitalRecordAddress = address.toString();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context, listen: true);
    return DefaultBody(
      title: "Welcome to your hospital dashboard",
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          OptionCard(
            child: defaultOptionCardChild(
              icon: Icons.info,
              text: "Biodata",
            ),
            onTap: () {
              Navigator.of(context).pushNamed(HospitalBiodataScreen.routeName);
            },
          ),
          sizedBoxH(4),
          OptionCard(
            child: defaultOptionCardChild(
              icon: Icons.vaccines,
              text: "My Doctors",
            ),
            onTap: () {
              Navigator.of(context).pushNamed(HospitalDoctorsScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
