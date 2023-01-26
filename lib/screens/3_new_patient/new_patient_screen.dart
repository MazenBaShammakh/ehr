import 'package:flutter/material.dart';

import './widgets/body.dart';

class NewPatientScreen extends StatelessWidget {
  const NewPatientScreen({super.key});

  static const routeName = "/new-patient";

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}