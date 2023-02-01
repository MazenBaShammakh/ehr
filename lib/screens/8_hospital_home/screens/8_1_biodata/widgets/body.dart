import 'package:dapp_ehr_1/constants.dart';
import 'package:dapp_ehr_1/providers/user.dart';
import 'package:dapp_ehr_1/screens/default_body.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController idController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    final user = Provider.of<User>(context, listen: false);
    user.hospitalGetBiodata().then((biodata) {
      List<dynamic> _biodata = biodata as List<dynamic>;
      nameController.text = _biodata[0] as String;
      locationController.text = _biodata[1] as String;
      idController.text = _biodata[2] as String;
    });
    super.initState();
  }

  Widget input(
      {required String label, required TextEditingController controller}) {
    return constraint40(
      TextField(
        controller: controller,
        decoration: InputDecoration(
          label: Text(label),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultBody(
      title: "Your biodata",
      content: Column(
        children: [
          input(
            label: "Name",
            controller: nameController,
          ),
          sizedBoxV(2),
          input(
            label: "Location",
            controller: locationController,
          ),
          sizedBoxV(2),
          input(
            label: "ID",
            controller: idController,
          ),
          sizedBoxV(4),
          ElevatedButton(
            onPressed: () async {
              final user = Provider.of<User>(context, listen: false);

              await user
                  .hospitalSetBiodata(
                    nameController.text,
                    locationController.text,
                    idController.text
                  )
                  .then((value) {print("biodata updated");});
            },
            child: Text("Update biodata"),
          ),
        ],
      ),
    );
  }
}
