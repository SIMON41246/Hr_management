import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AbsenceFormPage extends StatefulWidget {
  @override
  _AbsenceFormPageState createState() => _AbsenceFormPageState();
}

class _AbsenceFormPageState extends State<AbsenceFormPage> {
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();

  String _absenceType = "retard";

  @override
  void initState() {
    super.initState();
    _absenceType = "retard";
    _fromController.text = "";
    _toController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulaire d\'absence', style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromARGB(255, 174, 17, 6),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoCard('Nom', 'Doe'),
            SizedBox(height: 10),
            _buildInfoCard('Prénom', 'John'),
            SizedBox(height: 10),
            _buildInfoCard('Date de naissance', '1990-01-01'),
            SizedBox(height: 10),
            _buildInfoCard('CIN', 'F784524'),
            SizedBox(height: 10),
            _buildInfoCard('Téléphone', '123-456-7890'),
            SizedBox(height: 10),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Type d'absence",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    RadioListTile(
                      title: Text("Retard"),
                      value: "retard",
                      groupValue: _absenceType,
                      onChanged: (String? value) {
                        setState(() {
                          _absenceType = value!;
                          _fromController.clear();
                          _toController.clear();
                        });
                      },
                    ),
                    RadioListTile(
                      title: Text("Abandon de poste"),
                      value: "abandon",
                      groupValue: _absenceType,
                      onChanged: (String? value) {
                        setState(() {
                          _absenceType = value!;
                          _fromController.clear();
                          _toController.clear();
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            _buildDateTimeField(_fromController, _absenceType == "retard" ? "Du (heure et minute)" : "Du (jour, mois, année)"),
            SizedBox(height: 10),
            _buildDateTimeField(_toController, _absenceType == "retard" ? "Jusqu'à (heure et minute)" : "Jusqu'à (jour, mois, année)"),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Soumettre l'absence
                },
                style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 174, 17, 6),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  "Soumettre",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String label, String value) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 4,
      child: ListTile(
        title: Text(label),
        subtitle: Text(value),
      ),
    );
  }

  Widget _buildDateTimeField(TextEditingController controller, String labelText) {
    return TextField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        hintText: labelText,
        prefixIcon: Icon(Icons.calendar_today),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      onTap: () async {
        if (_absenceType == "retard") {
          TimeOfDay? pickedTime = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          );
          if (pickedTime != null) {
            setState(() {
              controller.text = pickedTime.format(context);
            });
          }
        } else {
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
        }
      },
    );
  }
}
