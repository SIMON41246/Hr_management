import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditPersonalInfoPage extends StatefulWidget {
  final Function onNext;

  EditPersonalInfoPage({required this.onNext});

  @override
  _EditPersonalInfoPageState createState() => _EditPersonalInfoPageState();
}

class _EditPersonalInfoPageState extends State<EditPersonalInfoPage> {
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
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildCard(
              title: "Nom",
              child: _buildTextField(_nameController, "Nom", Icons.person),
            ),
            _buildCard(
              title: "Prénom",
              child: _buildTextField(_surnameController, "Prénom", Icons.person),
            ),
            _buildCard(
              title: "CIN",
              child: _buildTextField(_cinController, "CIN", Icons.credit_card),
            ),
            _buildCard(
              title: "Date de naissance",
              child: _buildDateField(_dobController, "Date de naissance", Icons.calendar_today),
            ),
            _buildCard(
              title: "Email",
              child: _buildTextField(_emailController, "Email", Icons.email),
            ),
            _buildCard(
              title: "Téléphone",
              child: _buildTextField(_phoneController, "Téléphone", Icons.phone),
            ),
            _buildCard(
              title: "Ville",
              child: _buildTextField(_cityController, "Ville", Icons.location_city),
            ),
            _buildCard(
              title: "RIB",
              child: _buildTextField(_ribController, "RIB", Icons.account_balance),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                widget.onNext();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 174, 17, 6),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Icon(Icons.arrow_forward),
            ),
          ],
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
