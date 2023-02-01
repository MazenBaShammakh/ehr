import 'package:flutter/material.dart';

import './widgets/body.dart';

class RemixScreen extends StatelessWidget {
  const RemixScreen({super.key});

  static const routeName = "/";

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}