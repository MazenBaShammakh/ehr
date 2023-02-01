import 'package:flutter/material.dart';

import './widgets/body.dart';

class PatientDoctorsScreen extends StatelessWidget {
  const PatientDoctorsScreen({super.key});

  static const routeName = "/patient-doctors";

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}