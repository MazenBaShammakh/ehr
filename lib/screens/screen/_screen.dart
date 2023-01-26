import 'package:flutter/material.dart';

import './widgets/body.dart';

class Screen extends StatelessWidget {
  const Screen({super.key});

  static const routeName = "/";

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}