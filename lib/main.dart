import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mobile_app_rh/pages/add_personal_info_page.dart';
import 'package:mobile_app_rh/pages/conge_request_page.dart';
import 'package:mobile_app_rh/pages/firebase_options.dart';
import 'package:mobile_app_rh/pages/home_page_view.dart';
import 'package:mobile_app_rh/pages/add_employee_wizard.dart';
import 'package:mobile_app_rh/pages/edit_employee_wizard.dart';

import 'pages/absence_employee_page.dart';
import 'pages/list_absence_employe_page.dart';
import 'pages/list_conge_employe_page.dart';
import 'pages/login_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      routes: {
        '/login': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/add-employee': (context) => AddPersonalInfoPage(),
        '/edit-employee': (context) => EditEmployeeWizard(),
        '/conge-employee': (context) => CongeRequestPage(),
        '/absence-employee': (context) => AbsenceFormPage(),
        '/liste-conge-employe': (context) => ListeCongeEmploye(),
        '/liste_absence_employe': (context) => ListeAbsenceEmploye(),
        // Ajoute d'autres routes si nécessaire
      },
    );
  }
}
