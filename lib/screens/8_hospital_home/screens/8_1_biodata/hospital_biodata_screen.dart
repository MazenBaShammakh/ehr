import 'package:flutter/material.dart';

import './widgets/body.dart';

class HospitalBiodataScreen extends StatelessWidget {
  const HospitalBiodataScreen({super.key});

  static const routeName = "/hospital-biodata";

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}