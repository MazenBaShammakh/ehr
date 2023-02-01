import 'package:dapp_ehr_1/constants.dart';
import 'package:dapp_ehr_1/providers/user.dart';
import 'package:dapp_ehr_1/screens/2_user_type/user_type_screen.dart';
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
    user.getHospitalEhr();
    user.getDoctorEhr();
    user.getPatientEhr();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultBody(
      title: "Do you have an EHR record?",
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          OptionCard(
            child: defaultOptionCardChild(
              icon: Icons.person,
              text: "Yes",
            ),
            onTap: () {
              Navigator.of(context).pushNamed(
                UserTypeScreen.routeName,
                arguments: {"isNew": false},
              );
            },
          ),
          sizedBoxH(4),
          OptionCard(
            child: defaultOptionCardChild(
              icon: Icons.person_add,
              text: "No",
            ),
            onTap: () {
              Navigator.of(context).pushNamed(
                UserTypeScreen.routeName,
                arguments: {"isNew": true},
              );
            },
          ),
        ],
      ),
    );
  }
}
