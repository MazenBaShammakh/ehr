import 'package:dapp_ehr_1/constants.dart';
import 'package:dapp_ehr_1/providers/user.dart';
import 'package:dapp_ehr_1/screens/default_body.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web3dart/web3dart.dart';

import 'hospital_card.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController hospitalController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    final user = Provider.of<User>(context, listen: false);
    user.doctorGetHospital().then((hospital) {
      hospitalController.text = hospital.toString();
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
    final user = Provider.of<User>(context);
    return DefaultBody(
      title: "Your hospital",
      content: Column(
        children: [
          input(
            label: "Hospital",
            controller: hospitalController,
          ),
          sizedBoxV(2),
          ElevatedButton(
            onPressed: () async {
              final user = Provider.of<User>(context, listen: false);

              await user
                  .doctorSetHospital(
                EthereumAddress.fromHex(hospitalController.text),
              )
                  .then((value) {
                print("hospital updated");
              });
            },
            child: Text("Set hospital"),
          ),
          sizedBoxV(4),
          FutureBuilder(
            future: user.getHospitals(),
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                List<EthereumAddress>? hospitals = snapshot.data;
                return hospitals!.isNotEmpty 
                    ? Column(
                        children: hospitals
                            .map((hospital) => HospitalCard(hospital))
                            .toList(),
                      )
                    : Text("No hospitals found");
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }
}
