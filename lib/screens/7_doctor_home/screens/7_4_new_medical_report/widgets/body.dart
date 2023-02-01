import 'package:dapp_ehr_1/constants.dart';
import 'package:dapp_ehr_1/providers/user.dart';
import 'package:dapp_ehr_1/screens/default_body.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web3dart/credentials.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController diagnosticController = TextEditingController();
  TextEditingController medicineController = TextEditingController();
  TextEditingController numDaysController = TextEditingController();
  TextEditingController perDayController = TextEditingController();

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
    final EthereumAddress patient =
        ModalRoute.of(context)!.settings.arguments as EthereumAddress;
    return DefaultBody(
      title: "Add a new medical report",
      content: Column(
        children: [
          input(
            label: "Diagnostic",
            controller: diagnosticController,
          ),
          sizedBoxV(2),
          constraint40(
            Row(
              children: [
                Expanded(
                  child: input(
                    label: "Medicine",
                    controller: medicineController,
                  ),
                ),
                sizedBoxH(2),
                Expanded(
                  child: input(
                    label: "# Days",
                    controller: numDaysController,
                  ),
                ),
                sizedBoxH(2),
                Expanded(
                  child: input(
                    label: "Per Day",
                    controller: perDayController,
                  ),
                ),
              ],
            ),
          ),
          sizedBoxV(3),
          ElevatedButton(
            onPressed: () async {
              final user = Provider.of<User>(context, listen: false);
              await user.doctorAddMedicalReport(
                patient,
                diagnosticController.text,
                [medicineController.text],
                [int.parse(numDaysController.text)],
                [int.parse(perDayController.text)],
              ).then((value) => Navigator.of(context).pop());
            },
            child: Text("Add report"),
          ),
        ],
      ),
    );
  }
}
