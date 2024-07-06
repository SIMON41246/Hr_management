import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditProfessionalInfoPage extends StatefulWidget {
  final Function onNext;
  final Function onBack;

  EditProfessionalInfoPage({required this.onNext, required this.onBack});

  @override
  _EditProfessionalInfoPageState createState() => _EditProfessionalInfoPageState();
}

class _EditProfessionalInfoPageState extends State<EditProfessionalInfoPage> {
  final TextEditingController _degreeController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _workStartTimeController = TextEditingController();
  final TextEditingController _workEndTimeController = TextEditingController();
  final TextEditingController _breakTimeController = TextEditingController();

  String _contractType = "CDI";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildTextField(_degreeController, "Diplôme", Icons.school),
              SizedBox(height: 10),
              _buildTextField(_positionController, "Poste", Icons.work),
              SizedBox(height: 10),
              _buildContractTypeSection(),
              if (_contractType == "CDI") _buildDateField(_startDateController, "Date de début", Icons.calendar_today),
              if (_contractType == "CDD") ...[
                _buildDateField(_startDateController, "Date de début", Icons.calendar_today),
                _buildDateField(_endDateController, "Date de fin", Icons.calendar_today),
              ],
              SizedBox(height: 10),
              _buildTextField(_salaryController, "Salaire", Icons.attach_money),
              SizedBox(height: 20),
              _buildWorkTimeSection(),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  widget.onNext();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 174, 17, 6),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Icon(Icons.arrow_forward),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  widget.onBack();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  "Back",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText, IconData icon) {
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

  Widget _buildDateField(TextEditingController controller, String hintText, IconData icon) {
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

  Widget _buildTimeField(TextEditingController controller, String hintText, IconData icon) {
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
        _buildTimeField(_workStartTimeController, "Horaire de début", Icons.schedule),
        _buildTimeField(_workEndTimeController, "Horaire de fin", Icons.schedule),
        _buildTextField(_breakTimeController, "Temps de pause", Icons.timer),
      ],
    );
  }
}
