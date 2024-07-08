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
        title: const Text("Demande de congé",
        style: TextStyle(color: Colors.white),),
        backgroundColor: const Color.fromARGB(255, 174, 17, 6),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildCard(
                title: "Nom et Prénom",
                child: _buildTextField(_nameController, "Nom et Prénom", Icons.person),
              ),
              _buildCard(
                title: "Date de la demande",
                child: _buildDateField(_requestDateController, "Date de la demande", Icons.calendar_today),
              ),
              _buildCard(
                title: "Début de congé",
                child: _buildDateField(_startDateController, "Début de congé", Icons.calendar_today),
              ),
              _buildCard(
                title: "Fin de congé",
                child: _buildDateField(_endDateController, "Fin de congé", Icons.calendar_today),
              ),
              _buildCard(
                title: "Type de congé demandé",
                child: _buildLeaveTypeRadioButtons(),
              ),
              _buildCard(
                title: "Motif de la demande",
                child: _buildTextField(_reasonController, "Motif de la demande", Icons.edit),
              ),
              _buildCard(
                title: "Rémunération",
                child: _buildCompensationRadioButtons(),
              ),
              _buildCard(
                title: "Commentaire",
                child: _buildTextField(_commentController, "Commentaire", Icons.comment),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Submit action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 174, 17, 6),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Enregistrer",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
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

  Widget _buildCard({required String title, required Widget child}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      margin: const EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
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
        ),
      ],
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
    );
  }

  Widget _buildCompensationRadioButtons() {
    return Column(
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
        _buildRadioButton("Pas de rémunération", _compensation, (value) {
          setState(() {
            _compensation = value!;
          });
        }),
      ],
    );
  }

  Widget _buildRadioButton(String value, String groupValue, ValueChanged<String?> onChanged) {
    return RadioListTile<String>(
      title: Text(value),
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
    );
  }
}
