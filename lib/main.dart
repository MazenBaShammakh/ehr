import 'package:dapp_ehr_1/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import "./screens/screens.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => User(), 
      child: MaterialApp(
        title: 'EHR',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        // home: const Scaffold(),
        initialRoute: EthAccountScreen.routeName,
        routes: {
          EthAccountScreen.routeName: (_) => const EthAccountScreen(),
          EHRHomeScreen.routeName: (_) => const EHRHomeScreen(),
          UserTypeScreen.routeName: (_) => const UserTypeScreen(),
          NewPatientScreen.routeName: (_) => const NewPatientScreen(),
        }
      ),
    );
  }
}
