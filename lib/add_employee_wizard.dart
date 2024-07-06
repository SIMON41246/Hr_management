import 'package:flutter/material.dart';
import 'package:mobile_app_rh/add_personal_info_page.dart';
import 'package:mobile_app_rh/add_professional_info_page.dart';
import 'package:mobile_app_rh/add_upload_files_page.dart';
import 'package:mobile_app_rh/home_page_view.dart';

class AddEmployeeWizard extends StatefulWidget {
  @override
  _AddEmployeeWizardState createState() => _AddEmployeeWizardState();
}

class _AddEmployeeWizardState extends State<AddEmployeeWizard> {
  int _currentStep = 0;

  void _onNext() {
    setState(() {
      _currentStep += 1;
    });
  }

  void _onBack() {
    setState(() {
      _currentStep -= 1;
    });
  }

  void _onSubmit() {
    // Votre logique de soumission ici
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage()), // Remplacez HomePage par votre page d'accueil
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ajouter un Employé",
        style: TextStyle(color: Colors.white),),
       
        backgroundColor: Color.fromARGB(255, 174, 17, 6),
      ),
      body: _currentStep == 0
          ? AddPersonalInfoPage(onNext: _onNext)
          : _currentStep == 1
              ? AddProfessionalInfoPage(onNext: _onNext, onBack: _onBack)
              : UploadFilesPage(onSubmit: _onSubmit, onBack: _onBack),
    );
  }
}
