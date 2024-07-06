import 'package:flutter/material.dart';
import 'package:mobile_app_rh/edit_personal_info_page.dart';
import 'package:mobile_app_rh/edit_professional_info_page.dart';
import 'package:mobile_app_rh/edit_upload_download_files_page.dart';
import 'package:mobile_app_rh/home_page_view.dart';

class EditEmployeeWizard extends StatefulWidget {
  @override
  _EditEmployeeWizardState createState() => _EditEmployeeWizardState();
}

class _EditEmployeeWizardState extends State<EditEmployeeWizard> {
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
      MaterialPageRoute(builder: (context) => HomePage()), // Remplacez HomePage par page d'accueil
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editer un Employé",
        style: TextStyle(color: Colors.white),),
       
        backgroundColor: Color.fromARGB(255, 174, 17, 6),
      ),
      body: _currentStep == 0
          ? EditPersonalInfoPage(onNext: _onNext)
          : _currentStep == 1
              ? EditProfessionalInfoPage(onNext: _onNext, onBack: _onBack)
              : UploadDownloadFilesPage(onSubmit: _onSubmit, onBack: _onBack),
    );
  }
}
