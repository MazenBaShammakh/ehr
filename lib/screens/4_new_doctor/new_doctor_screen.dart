import 'package:flutter/material.dart';

import './widgets/body.dart';

class NewDoctorScreen extends StatelessWidget {
  const NewDoctorScreen({super.key});

  static const routeName = "/new-doctor";

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}