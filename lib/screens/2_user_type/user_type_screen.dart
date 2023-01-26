import 'package:flutter/material.dart';

import './widgets/body.dart';

class UserTypeScreen extends StatelessWidget {
  const UserTypeScreen({super.key});

  static const routeName = "/user-type";

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}