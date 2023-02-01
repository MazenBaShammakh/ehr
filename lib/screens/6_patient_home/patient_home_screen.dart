import 'package:flutter/material.dart';

import './widgets/body.dart';

class PatientHomeScreen extends StatelessWidget {
  const PatientHomeScreen({super.key});

  static const routeName = "/patient-home";

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}