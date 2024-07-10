import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app_rh/data/models/user.dart';
import 'package:uuid/uuid.dart';

import '../data/repositories/user_controller.dart';

class AddPersonalInfoPage extends StatefulWidget {
  AddPersonalInfoPage();

  @override
  _AddPersonalInfoPageState createState() => _AddPersonalInfoPageState();
}

class _AddPersonalInfoPageState extends State<AddPersonalInfoPage> {
  UserController userController = Get.put(UserController());
  String _contractType = "CDI";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildTextField(
                  userController.nameController, "Nom", Icons.person),
              SizedBox(height: 10),
              _buildTextField(
                  userController.surnameController, "Prénom", Icons.person),
              SizedBox(height: 10),
              _buildTextField(
                  userController.cinController, "CIN", Icons.credit_card),
              SizedBox(height: 10),
              _buildDateField(userController.dobController, "Date de naissance",
                  Icons.calendar_today),
              SizedBox(height: 10),
              _buildTextField(
                  userController.emailController, "Email", Icons.email),
              SizedBox(height: 10),
              _buildTextField(
                  userController.phoneController, "Téléphone", Icons.phone),
              SizedBox(height: 10),
              _buildTextField(
                  userController.cityController, "Ville", Icons.location_city),
              SizedBox(height: 10),
              _buildTextField(
                  userController.ribController, "RIB", Icons.account_balance),
              SizedBox(height: 20),
              Divider(),

              //-------------------------------------  Professional Info  ------------------------------------------

              _buildTextField(
                  userController.degreeController, "Diplôme", Icons.school),
              SizedBox(height: 10),
              _buildTextField(
                  userController.positionController, "Poste", Icons.work),
              SizedBox(height: 10),
              _buildContractTypeSection(),
              if (_contractType == "CDI")
                _buildDateField(userController.startDateController,
                    "Date de début", Icons.calendar_today),
              if (_contractType == "CDD") ...[
                _buildDateField(userController.startDateController,
                    "Date de début", Icons.calendar_today),
                _buildDateField(userController.endDateController, "Date de fin",
                    Icons.calendar_today),
              ],
              SizedBox(height: 10),
              _buildTextField(userController.salaryController, "Salaire",
                  Icons.attach_money),
              SizedBox(height: 20),
              _buildWorkTimeSection(),
              SizedBox(height: 20),
              Divider(),

              //-------------------------------------  UPLOAD FILES Info  ------------------------------------------
              _buildFilePicker(
                "Piéce justificative (image.png)",
                userController.selectUserImage,
              ),
              const SizedBox(height: 20),
              _buildFilePicker(
                "Diplômes (diplomes.pdf)",
                userController.selectDiplomeFile,
              ),
              const SizedBox(height: 20),
              _buildFilePicker(
                "CV (cv.pdf)",
                userController.selectCvFile,
              ),
              const SizedBox(height: 20),
              _buildFilePicker(
                "Rib (image.png)",
                userController.selectRibFile,
              ),
              const SizedBox(height: 20),
              _buildFilePicker(
                "Contrat (contrat.pdf)",
                userController.selectContratFile,
              ),
              const SizedBox(height: 20),
              _buildFilePicker(
                "CIN (cin.pdf)",
                userController.selectCinFile,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => userController
                    .addUser(), // Call the method with parentheses
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Retour",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String hintText, IconData icon) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  Widget _buildDateField(
      TextEditingController controller, String hintText, IconData icon) {
    return TextField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null) {
          setState(() {
            controller.text = DateFormat('yyyy-MM-dd').format(pickedDate);
          });
        }
      },
    );
  }

  Widget _buildTimeField(
      TextEditingController controller, String hintText, IconData icon) {
    return TextField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      onTap: () async {
        TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        if (pickedTime != null) {
          setState(() {
            controller.text = pickedTime.format(context);
          });
        }
      },
    );
  }

  Widget _buildContractTypeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Type de contrat",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            Expanded(
              child: RadioListTile(
                title: Text("CDI"),
                value: "CDI",
                groupValue: _contractType,
                onChanged: (String? newValue) {
                  setState(() {
                    _contractType = newValue!;
                  });
                },
              ),
            ),
            Expanded(
              child: RadioListTile(
                title: Text("CDD"),
                value: "CDD",
                groupValue: _contractType,
                onChanged: (String? newValue) {
                  setState(() {
                    _contractType = newValue!;
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWorkTimeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Horaire de travail",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        _buildTimeField(userController.workStartTimeController,
            "Horaire de début", Icons.schedule),
        _buildTimeField(userController.workEndTimeController, "Horaire de fin",
            Icons.schedule),
        _buildTextField(
            userController.breakTimeController, "Temps de pause", Icons.timer),
      ],
    );
  }

  Widget _buildFilePicker(String label, Function() onPressed) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 174, 17, 6),
            ),
            child: Row(
              children: [
                const Icon(Icons.upload_file, color: Colors.white),
                const SizedBox(width: 5),
                Text(
                  label == null ? "" : "Change file",
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
