import 'package:flutter/material.dart';

import './widgets/body.dart';

class EthAccountScreen extends StatelessWidget {
  const EthAccountScreen({super.key});

  static const routeName = "/eth-account";

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}
