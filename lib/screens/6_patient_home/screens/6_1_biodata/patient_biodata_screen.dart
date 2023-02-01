import 'package:flutter/material.dart';

import './widgets/body.dart';

class PatientBiodataScreen extends StatelessWidget {
  const PatientBiodataScreen({super.key});

  static const routeName = "/patient-biodata";

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}