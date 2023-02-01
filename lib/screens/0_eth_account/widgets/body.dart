import 'package:dapp_ehr_1/constants.dart';
import 'package:dapp_ehr_1/providers/user.dart';
import 'package:dapp_ehr_1/screens/1_ehr_home/ehr_home_screen.dart';
import 'package:dapp_ehr_1/screens/default_body.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late TextEditingController pkController;

  @override
  void initState() {
    pkController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultBody(
      title: "Register your Ethereum account",
      content: Column(
        children: [
          Container(
            constraints: const BoxConstraints(maxWidth: kSpacingUnit * 40),
            child: TextField(
              controller: pkController,
              decoration: const InputDecoration(
                label: Text("Private key"),
              ),
              obscureText: true,
            ),
          ),
          sizedBoxV(4),
          ElevatedButton(
            onPressed: () {
              if (pkController.text.length != 64) {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text("Invalid private key"),
                    content: const Text("Ethereum private key must be 64 hexa-decimal characters"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text("Ok"),
                      ),
                    ],
                  ),
                );
              } else {
                final user = Provider.of<User>(
                  context,
                  listen: false,
                );
                user.privateKey = pkController.text;
                Navigator.of(context).pushNamed(EHRHomeScreen.routeName);
              }
            },
            child: const Text("Proceed to EHR"),
          ),
        ],
      ),
    );
  }
}
