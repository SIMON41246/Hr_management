import 'package:flutter/material.dart';
import 'package:mobile_app_rh/pages/add_personal_info_page.dart';

import 'home_page_view.dart';

class AddEmployeeWizard extends StatefulWidget {
  @override
  _AddEmployeeWizardState createState() => _AddEmployeeWizardState();
}

class _AddEmployeeWizardState extends State<AddEmployeeWizard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Ajouter un Employé",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color.fromARGB(255, 174, 17, 6),
        ),
        body: AddPersonalInfoPage());
  }
}
