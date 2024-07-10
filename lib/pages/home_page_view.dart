import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/repositories/user_controller.dart';

class HomePage extends StatelessWidget {
  final List<Map<String, String>> employees = [
    {
      'nom': 'Doe',
      'prenom': 'John',
      'email': 'john.doe@example.com',
      'telephone': '123-456-7890',
      'cin': 'F784524',
      'ville': 'Paris',
      'poste': 'Développeur'
    },
    {
      'nom': 'Smith',
      'prenom': 'Jane',
      'email': 'jane.smith@example.com',
      'telephone': '098-765-4321',
      'cin': 'F784524',
      'ville': 'Lyon',
      'poste': 'Designer'
    },
    // Ajoutez plus de données fictives ici pour les tests
  ];
  final UserController userController = Get.put(UserController());

  void _showDeleteConfirmation(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation de suppression'),
          content: Text('Voulez-vous vraiment supprimer cet employé ?'),
          actions: <Widget>[
            TextButton(
              child: Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Supprimer', style: TextStyle(color: Colors.red)),
              onPressed: () {
                // Supprimez l'employé de la liste
                Navigator.of(context).pop();
                // Rafraîchissez la page ou mettez à jour l'état pour refléter les changements
              },
            ),
          ],
        );
      },
    );
  }

  void _navigateToHome(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  void _navigateToAbsenceInfo(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AbsenceInfoPage(employees)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 174, 17, 6),
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            onPressed: () {
              _navigateToHome(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              showSearch(
                context: context,
                delegate:
                    EmployeeSearchDelegate(employees, _showDeleteConfirmation),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 174, 17, 6),
              ),
              accountName:
                  Text('User Name', style: TextStyle(color: Colors.white)),
              accountEmail: Text('user.email@example.com',
                  style: TextStyle(color: Colors.white)),
              currentAccountPicture: CircleAvatar(
                radius: 40.0,
                // Remplacez par l'image de l'utilisateur
              ),
            ),
            ListTile(
              leading: Icon(Icons.event_note, color: Colors.blue),
              title: Text('Informations de congé'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/liste-conge-employe');
              },
            ),
            ListTile(
              leading: Icon(
                Icons.info,
                color: Colors.blue,
              ),
              title: Text('Liste des absences'),
              onTap: () {
                Navigator.pushNamed(context, '/liste_absence_employe');
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app, color: Colors.red),
              title: Text('Log out', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: userController.users.length,
        itemBuilder: (context, index) {
          final user = userController.users[index];

          return Card(
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 4,
            child: Column(
              children: [
                ListTile(
                  title: Center(
                    child: CircleAvatar(
                      radius: 30.0,
                      backgroundColor: Colors.grey.shade200,
                      child: Icon(Icons.person, color: Colors.grey.shade700),
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.0),
                      Text('${user.nom} ${user.prenom}',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('Email: ${user.email}'),
                      Text('Téléphone: ${user.telephone}'),
                      Text('Ville: ${user.ville}'),
                      Text('Poste: ${user.poste}'),
                    ],
                  ),
                  onTap: () {
                    // Action lorsque l'on clique sur un employé
                  },
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        Navigator.pushNamed(context, '/edit-employee');
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.event_busy, color: Colors.blue),
                      onPressed: () {
                        Navigator.pushNamed(context, '/absence-employee');
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.event, color: Colors.blue),
                      onPressed: () {
                        Navigator.pushNamed(context, '/conge-employee');
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        _showDeleteConfirmation(context, index);
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add-employee');
        },
        backgroundColor: Color.fromARGB(255, 174, 17, 6),
        child: Icon(Icons.person_add_alt_1, color: Colors.white),
      ),
    );
  }
}

class AbsenceInfoPage extends StatelessWidget {
  final List<Map<String, String>> employees;

  AbsenceInfoPage(this.employees);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informations de congé',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromARGB(255, 174, 17, 6),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: AbsenceList(employees),
    );
  }
}

class AbsenceList extends StatefulWidget {
  final List<Map<String, String>> employees;

  AbsenceList(this.employees);

  @override
  _AbsenceListState createState() => _AbsenceListState();
}

class _AbsenceListState extends State<AbsenceList> {
  late List<Map<String, String>> filteredEmployees;

  @override
  void initState() {
    super.initState();
    filteredEmployees = widget.employees;
  }

  void _filterEmployees(String query) {
    setState(() {
      filteredEmployees = widget.employees
          .where((employee) => '${employee['nom']} ${employee['prenom']}'
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Rechercher...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onChanged: _filterEmployees,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredEmployees.length,
            itemBuilder: (context, index) {
              final employee = filteredEmployees[index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 4,
                child: Column(
                  children: [
                    ListTile(
                      title: Text('${employee['nom']} ${employee['prenom']}',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Type d\'absence: ${employee['type_absence']}'),
                          Text('Du: ${employee['du']}'),
                          Text('Jusqu\'à: ${employee['jusqu_a']}'),
                        ],
                      ),
                      onTap: () {
                        // Action lorsque l'on clique sur une demande de congé
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class EmployeeSearchDelegate extends SearchDelegate {
  final List<Map<String, String>> employees;
  final Function(BuildContext, int) showDeleteConfirmation;

  EmployeeSearchDelegate(this.employees, this.showDeleteConfirmation);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildEmployeeList();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildEmployeeList();
  }

  Widget _buildEmployeeList() {
    final filteredEmployees = employees
        .where((employee) => '${employee['nom']} ${employee['prenom']}'
            .toLowerCase()
            .contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: filteredEmployees.length,
      itemBuilder: (context, index) {
        final employee = filteredEmployees[index];
        return ListTile(
          title: Text('${employee['nom']} ${employee['prenom']}'),
          subtitle: Text("employee['email']"),
          onTap: () {
            // Action lorsqu'un employé est sélectionné
          },
          trailing: IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              showDeleteConfirmation(context, index);
            },
          ),
        );
      },
    );
  }
}
