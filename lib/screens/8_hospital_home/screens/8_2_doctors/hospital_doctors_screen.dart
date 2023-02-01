import 'package:flutter/material.dart';

import './widgets/body.dart';

class HospitalDoctorsScreen extends StatelessWidget {
  const HospitalDoctorsScreen({super.key});

  static const routeName = "/hospital-doctors";

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}