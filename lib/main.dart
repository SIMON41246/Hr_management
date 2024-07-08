import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mobile_app_rh/absence_employee_page.dart';
import 'package:mobile_app_rh/add_employee_wizard.dart';
import 'package:mobile_app_rh/conge_request_page.dart';
import 'package:mobile_app_rh/edit_employee_wizard.dart';
import 'package:mobile_app_rh/home_page_view.dart';
import 'package:mobile_app_rh/list_conge_employe_page.dart';
import 'package:mobile_app_rh/login_view.dart';
import 'firebase_options.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      '/add-employee': (context) => AddEmployeeWizard(),
      '/edit-employee': (context) => EditEmployeeWizard(),
      '/conge-employee': (context) => CongeRequestPage(),
      '/absence-employee': (context) => AbsenceFormPage(),
      '/liste-conge-employe': (context) => ListeCongeEmploye(),
      // Ajoute d'autres routes si nécessaire
    },
    );
  }
}

