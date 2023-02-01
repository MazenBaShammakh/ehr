import 'package:flutter/material.dart';

import './widgets/body.dart';

class PatientMedicalReportsScreen extends StatelessWidget {
  const PatientMedicalReportsScreen({super.key});

  static const routeName = "/patient-medical-reports";

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}