import 'package:dapp_ehr_1/constants.dart';
import 'package:dapp_ehr_1/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web3dart/web3dart.dart';

class HospitalCard extends StatelessWidget {
  const HospitalCard(this.hospital, {super.key});

  final EthereumAddress hospital;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return FutureBuilder(
      future: user.hospitalGetBiodata(
          hospitalRecordAddressByDoctor: hospital.toString()),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          List<dynamic> biodata = snapshot.data;
          return Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 24),
            padding: const EdgeInsets.all(kSpacingUnit * 2),
            decoration: BoxDecoration(
              border: Border.all(
                color: kColor.withOpacity(.2),
              ),
              borderRadius: BorderRadius.circular(kSpacingUnit * 2),
            ),
            child: Column(
              children: [
                Text(
                  "${biodata[0]}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                sizedBoxV(2),
                Text(
                  "${biodata[1]}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                sizedBoxV(2),
                Text(
                  "${biodata[2]}",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                ),
                SelectableText(
                  "$hospital",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        }
        return Center(child: Text("loading hospital details"));
      },
    );
  }
}
