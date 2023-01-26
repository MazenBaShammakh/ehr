import 'package:dapp_ehr_1/constants.dart';
import 'package:dapp_ehr_1/screens/default_body.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController dobController = TextEditingController();
  DateTime? dob;
  Sex sex = Sex.male;

  @override
  void initState() {
    // TODO: implement initState
    dobController.text = "Date of Birth";
    super.initState();
  }

  Widget input({required String label}) {
    return constraint40(
      TextField(
        decoration: InputDecoration(
          label: Text(label),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultBody(
      title: "Fill in your details",
      content: Column(
        children: [
          input(
            label: "First Name",
          ),
          sizedBoxV(2),
          input(
            label: "Last Name",
          ),
          sizedBoxV(2),
          input(
            label: "National ID",
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
                        child: Text(_sex.name[0].toUpperCase() + _sex.name.substring(1)),
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
          sizedBoxV(3),
          ElevatedButton(onPressed: (){}, child: Text("Register"),),
        ],
      ),
    );
  }
}
