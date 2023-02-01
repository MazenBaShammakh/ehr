import 'package:flutter/material.dart';

import './widgets/body.dart';

class HospitalHomeScreen extends StatelessWidget {
  const HospitalHomeScreen({super.key});

  static const routeName = "/hospital-home";

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}