import 'package:flutter/material.dart';
import 'widgets/body.dart';

class DoctorNewMedicalReport extends StatelessWidget {
  const DoctorNewMedicalReport({super.key});

  static const routeName = "/doctor-new-medical-report";

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}