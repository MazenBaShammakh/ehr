import 'package:flutter/material.dart';

import './widgets/body.dart';

class NewHospitalScreen extends StatelessWidget {
  const NewHospitalScreen({super.key});

  static const routeName = "/new-hospital";

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}