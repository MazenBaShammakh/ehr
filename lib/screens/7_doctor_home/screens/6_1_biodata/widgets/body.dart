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
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  DateTime? dob;
  Sex sex = Sex.male;

  @override
  void initState() {
    // TODO: implement initState
    final user = Provider.of<User>(context, listen: false);
    user.doctorGetBiodata().then((biodata) {
      List<dynamic> _biodata = biodata as List<dynamic>;
      firstNameController.text = _biodata[0] as String;
      lastNameController.text = _biodata[1] as String;
      idController.text = _biodata[2] as String;
      dob = DateTime.fromMillisecondsSinceEpoch((_biodata[3] as BigInt).toInt());
      dobController.text = DateFormat('yyyy-MM-dd').format(dob!);
      sex = _biodata[4] == 0 ? Sex.male : Sex.female;
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
            label: "First Name",
            controller: firstNameController,
          ),
          sizedBoxV(2),
          input(
            label: "Last Name",
            controller: lastNameController,
          ),
          sizedBoxV(2),
          input(
            label: "National ID",
            controller: idController,
          ),
          sizedBoxV(2),
          constraint40(
            TextField(
              readOnly: true,
              controller: dobController,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime(2000),
                  firstDate: DateTime(1920),
                  lastDate: DateTime.now(),
                );

                if (pickedDate != null) {
                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                  dob = pickedDate;
                  setState(() {
                    dobController.text = formattedDate;
                  });
                } else {
                  setState(() {
                    dobController.text = "Date of Birth";
                  });
                }
              },
            ),
          ),
          sizedBoxV(2),
          constraint40(
            SizedBox(
              width: double.infinity,
              child: DropdownButton(
                value: sex,
                isExpanded: true,
                items: Sex.values
                    .map(
                      (_sex) => DropdownMenuItem(
                        child: Text(_sex.name[0].toUpperCase() +
                            _sex.name.substring(1)),
                        value: _sex,
                      ),
                    )
                    .toList(),
                onChanged: (value) => setState(() {
                  sex = value!;
                }),
              ),
            ),
          ),
          sizedBoxV(4),
          ElevatedButton(
            onPressed: () async {
              final user = Provider.of<User>(context, listen: false);

              await user
                  .doctorSetBiodata(
                    firstNameController.text,
                    lastNameController.text,
                    idController.text,
                    dob!.millisecondsSinceEpoch,
                    sex.index,
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
