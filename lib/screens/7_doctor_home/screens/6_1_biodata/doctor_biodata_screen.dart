import 'package:flutter/material.dart';

import './widgets/body.dart';

class DoctorBiodataScreen extends StatelessWidget {
  const DoctorBiodataScreen({super.key});

  static const routeName = "/doctor-biodata";

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}