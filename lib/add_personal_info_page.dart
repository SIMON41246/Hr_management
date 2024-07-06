import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddPersonalInfoPage extends StatefulWidget {
  final Function onNext;

  AddPersonalInfoPage({required this.onNext});

  @override
  _AddPersonalInfoPageState createState() => _AddPersonalInfoPageState();
}

class _AddPersonalInfoPageState extends State<AddPersonalInfoPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _cinController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _ribController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildTextField(_nameController, "Nom", Icons.person),
              SizedBox(height: 10),
              _buildTextField(_surnameController, "Prénom", Icons.person),
              SizedBox(height: 10),
              _buildTextField(_cinController, "CIN", Icons.credit_card),
              SizedBox(height: 10),
              _buildDateField(_dobController, "Date de naissance", Icons.calendar_today),
              SizedBox(height: 10),
              _buildTextField(_emailController, "Email", Icons.email),
              SizedBox(height: 10),
              _buildTextField(_phoneController, "Téléphone", Icons.phone),
              SizedBox(height: 10),
              _buildTextField(_cityController, "Ville", Icons.location_city),
              SizedBox(height: 10),
              _buildTextField(_ribController, "RIB", Icons.account_balance),
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
}
