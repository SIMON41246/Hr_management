import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CongeRequestPage extends StatefulWidget {
  @override
  _CongeRequestPageState createState() => _CongeRequestPageState();
}

class _CongeRequestPageState extends State<CongeRequestPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _requestDateController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();

  String _leaveType = "Congé payé";
  String _compensation = "Congé payé";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("demande de congé"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildTextField(_nameController, "Nom et Prénom", Icons.person),
              _buildDateField(_requestDateController, "Date de la demande", Icons.calendar_today),
              _buildDateField(_startDateController, "Début de congé", Icons.calendar_today),
              _buildDateField(_endDateController, "Fin de congé", Icons.calendar_today),
              SizedBox(height: 10),
              _buildLeaveTypeRadioButtons(),
              SizedBox(height: 10),
              _buildTextField(_reasonController, "Motif de la demande", Icons.edit),
              SizedBox(height: 10),
              _buildCompensationRadioButtons(),
              SizedBox(height: 10),
              _buildTextField(_commentController, "Commentaire", Icons.comment),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Submit action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 174, 17, 6),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  "Enregistrer",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
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

  Widget _buildLeaveTypeRadioButtons() {
    return Column(
      children: [
        Text("Type de congé demandé"),
        Row(
          children: [
            _buildRadioButton("Congé payé", _leaveType, (value) {
              setState(() {
                _leaveType = value!;
              });
            }),
            _buildRadioButton("Congé maladie", _leaveType, (value) {
              setState(() {
                _leaveType = value!;
              });
            }),
          ],
        ),
        Row(
          children: [
            _buildRadioButton("Congé parental", _leaveType, (value) {
              setState(() {
                _leaveType = value!;
              });
            }),
            _buildRadioButton("Congé sans solde", _leaveType, (value) {
              setState(() {
                _leaveType = value!;
              });
            }),
          ],
        ),
        Row(
          children: [
            _buildRadioButton("Congé sabbatique", _leaveType, (value) {
              setState(() {
                _leaveType = value!;
              });
            }),
            _buildRadioButton("Autre", _leaveType, (value) {
              setState(() {
                _leaveType = value!;
              });
            }),
          ],
        ),
      ],
    );
  }

  Widget _buildCompensationRadioButtons() {
    return Column(
      children: [
        Text("Rémunération"),
        Row(
          children: [
            _buildRadioButton("Congé payé", _compensation, (value) {
              setState(() {
                _compensation = value!;
              });
            }),
            _buildRadioButton("Congé maladie", _compensation, (value) {
              setState(() {
                _compensation = value!;
              });
            }),
          ],
        ),
        Row(
          children: [
            _buildRadioButton("Pas de rémunération", _compensation, (value) {
              setState(() {
                _compensation = value!;
              });
            }),
          ],
        ),
      ],
    );
  }

  Widget _buildRadioButton(String value, String groupValue, ValueChanged<String?> onChanged) {
    return Expanded(
      child: RadioListTile<String>(
        title: Text(value),
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
      ),
    );
  }
}
