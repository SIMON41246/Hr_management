import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final List<Map<String, String>> employees = [
    {
      'nom': 'Doe',
      'prenom': 'John',
      'email': 'john.doe@example.com',
      'telephone': '123-456-7890',
      'Cin': 'F784524',
      'ville': 'Paris',
      'poste': 'Développeur'
    },
    {
      'nom': 'Smith',
      'prenom': 'Jane',
      'email': 'jane.smith@example.com',
      'telephone': '098-765-4321',
      'Cin': 'F784524',
      'ville': 'Lyon',
      'poste': 'Designer'
    },
    // Ajoutez plus de données fictives ici pour les tests
  ];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 174, 17, 6),
        actions: [
          IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            onPressed: () {
              // Naviguer vers la page d'accueil
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
          ),
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              showSearch(
                context: context,
                delegate: EmployeeSearchDelegate(employees),
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
              accountName: Text('User Name', style: TextStyle(color: Colors.white)),
              accountEmail: Text('user.email@example.com', style: TextStyle(color: Colors.white)),
              currentAccountPicture: CircleAvatar(
                radius: 40.0,
                 // Remplacez par l'image de l'utilisateur
              ),
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app, color: Colors.red),
              title: Text('Log out', style: TextStyle(color: Colors.red)),
              onTap: () {
                // Déconnexion et retour à la page de login
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: employees.length,
        itemBuilder: (context, index) {
          final employee = employees[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 4,
            child: ListTile(
              title: Text('${employee['nom']} ${employee['prenom']}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Email: ${employee['email']}'),
                  Text('Téléphone: ${employee['telephone']}'),
                  Text('Ville: ${employee['ville']}'),
                  Text('Poste: ${employee['poste']}'),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.blue),
                    onPressed: () {
                      // Action de modification
                      Navigator.pushNamed(context, '/edit-employee');
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.event_busy, color: Colors.blue),
                    onPressed: () {
                      // Action de modification
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
              onTap: () {
                // Action lorsque l'on clique sur un employé
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Naviguer vers la page d'ajout d'employé
         Navigator.pushNamed(context, '/add-employee');
        },
        backgroundColor: Color.fromARGB(255, 174, 17, 6),
        child: Icon(Icons.person_add_alt_1, color: Colors.white),
      ),
    );
  }
}

// Effectuer une recherche des employés
class EmployeeSearchDelegate extends SearchDelegate {
  final List<Map<String, String>> employees;

  EmployeeSearchDelegate(this.employees);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear, color: Colors.white),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back, color: Colors.white),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = employees.where((employee) {
      final fullName = '${employee['nom']} ${employee['prenom']}';
      return fullName.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final employee = results[index];
        return ListTile(
          title: Text('${employee['nom']} ${employee['prenom']}'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Email: ${employee['email']}'),
              Text('Téléphone: ${employee['telephone']}'),
              Text('Ville: ${employee['ville']}'),
              Text('Poste: ${employee['poste']}'),
            ],
          ),
          onTap: () {
            // Action lorsque l'on clique sur un employé
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = employees.where((employee) {
      final fullName = '${employee['nom']} ${employee['prenom']}';
      return fullName.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final employee = suggestions[index];
        return ListTile(
          title: Text('${employee['nom']} ${employee['prenom']}'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Email: ${employee['email']}'),
              Text('Téléphone: ${employee['telephone']}'),
              Text('Ville: ${employee['ville']}'),
              Text('Poste: ${employee['poste']}'),
            ],
          ),
          onTap: () {
            // Action lorsque l'on clique sur un employé
          },
        );
      },
    );
  }
}
