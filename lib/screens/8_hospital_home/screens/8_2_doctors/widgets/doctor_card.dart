import 'package:dapp_ehr_1/constants.dart';
import 'package:dapp_ehr_1/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web3dart/web3dart.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard(this.doctor, {super.key, required this.approved});

  final EthereumAddress doctor;
  final bool approved;

  @override
  Widget build(BuildContext context) {
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
      child: Row(
        children: [
          Text(doctor.toString(), style: TextStyle(fontWeight: FontWeight.bold,),),
          Spacer(),
          if (!approved)
            ElevatedButton(
              onPressed: () async {
                final user = Provider.of<User>(context, listen: false);
                await user
                    .hospitalApproveDoctor(doctor)
                    .then((value) => print("doctor approved"));
              },
              child: Text("Approve doctor"),
            ),
        ],
      ),
    );
    // return FutureBuilder(
    //   future: user.hospitalGetBiodata(
    //       hospitalRecordAddressByDoctor: hospital.toString()),
    //   builder: (_, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.done) {
    //       List<dynamic> biodata = snapshot.data;
    //       return Container(
    //         width: double.infinity,
    //         margin: const EdgeInsets.only(bottom: 24),
    //         child: Column(
    //           children: [
    //             Text("Hospital: ${biodata[0]}"),
    //             Text("Location: ${biodata[1]}"),
    //             Text("ID: ${biodata[2]}"),
    //             SelectableText("Address: $hospital")
    //           ],
    //         ),
    //       );
    //     }
    //     return Center(child: Text("loading hospital details"));
    //   },
    // );
  }
}
