import 'package:flutter/material.dart';

import './widgets/body.dart';

class EHRHomeScreen extends StatelessWidget {
  const EHRHomeScreen({super.key});

  static const routeName = "/ehr-home";

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}