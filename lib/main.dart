import 'package:dapp_ehr_1/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'constants.dart';

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
          primarySwatch: kMaterialColor,
        ),
        // home: const Scaffold(),
        initialRoute: EthAccountScreen.routeName,
        routes: {
          RemixScreen.routeName: (_) => const RemixScreen(),
          EthAccountScreen.routeName: (_) => const EthAccountScreen(),
          EHRHomeScreen.routeName: (_) => const EHRHomeScreen(),
          UserTypeScreen.routeName: (_) => const UserTypeScreen(),
          NewPatientScreen.routeName: (_) => const NewPatientScreen(),
          NewDoctorScreen.routeName: (_) => const NewDoctorScreen(),
          NewHospitalScreen.routeName: (_) => const NewHospitalScreen(),
          DoctorHomeScreen.routeName: (_) => const DoctorHomeScreen(),
          DoctorBiodataScreen.routeName: (_) => const DoctorBiodataScreen(),
          DoctorHospitalScreen.routeName: (_) => const DoctorHospitalScreen(),
          DoctorPatientsScreen.routeName: (_) => const DoctorPatientsScreen(),
          DoctorNewMedicalReport.routeName: (_) => const DoctorNewMedicalReport(),
          PatientHomeScreen.routeName: (_) => const PatientHomeScreen(),
          PatientBiodataScreen.routeName: (_) => const PatientBiodataScreen(),
          PatientMedicalReportsScreen.routeName: (_) => const PatientMedicalReportsScreen(),
          PatientDoctorsScreen.routeName: (_) => const PatientDoctorsScreen(),
          HospitalHomeScreen.routeName: (_) => const HospitalHomeScreen(),
          HospitalBiodataScreen.routeName: (_) => const HospitalBiodataScreen(),
          HospitalDoctorsScreen.routeName: (_) => const HospitalDoctorsScreen(),
        }
      ),
    );
  }
}
