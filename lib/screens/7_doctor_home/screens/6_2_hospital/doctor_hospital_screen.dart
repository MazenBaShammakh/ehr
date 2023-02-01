import 'package:flutter/material.dart';

import './widgets/body.dart';

class DoctorHospitalScreen extends StatelessWidget {
  const DoctorHospitalScreen({super.key});

  static const routeName = "/doctor-hospital";

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}