import 'package:flutter/material.dart';

class ListeCongeEmploye extends StatefulWidget {
  @override
  _ListeCongeEmployeState createState() => _ListeCongeEmployeState();
}

class _ListeCongeEmployeState extends State<ListeCongeEmploye> {
  final List<Map<String, String>> conges = [
    {
      'nom': 'Doe',
      'prenom': 'John',
      'type': 'Maladie',
      'du': '2024-06-01',
      'jusqua': '2024-06-10',
    },
    {
      'nom': 'Smith',
      'prenom': 'Jane',
      'type': 'Vacances',
      'du': '2024-07-01',
      'jusqua': '2024-07-15',
    },
    // Ajoutez plus de données fictives ici pour les tests
  ];

  String query = '';

  @override
  Widget build(BuildContext context) {
    final filteredConges = conges.where((conge) {
      final fullName = '${conge['nom']} ${conge['prenom']}';
      return fullName.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Liste des Congés',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 174, 17, 6),
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
          ),
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CongeSearchDelegate(conges),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: filteredConges.length,
        itemBuilder: (context, index) {
          final conge = filteredConges[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 4,
            child: ListTile(
              leading: CircleAvatar(
                radius: 30.0,
                backgroundColor: Colors.grey.shade200,
                child: Icon(Icons.person, color: Colors.grey.shade700),
                // Remplacez par l'image de l'employé
              ),
              title: Text('${conge['nom']} ${conge['prenom']}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Type: ${conge['type']}'),
                  Text('Du: ${conge['du']}'),
                  Text('Jusqu\'à: ${conge['jusqua']}'),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove_red_eye,color: Colors.blue,),
                    onPressed: () {
                      // Naviguer vers la page d'information de congé de l'employé
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CongeDetailsPage(conge),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // Supprimer le congé de la liste
                      setState(() {
                        conges.removeAt(index);
                      });
                    },
                  ),
                ],
              ),
              onTap: () {
                // Action lorsque l'on clique sur un congé
              },
            ),
          );
        },
      ),
    );
  }
}

class CongeSearchDelegate extends SearchDelegate {
  final List<Map<String, String>> conges;

  CongeSearchDelegate(this.conges);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: AppBarTheme(
        color: Color.fromARGB(255, 174, 17, 6),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.grey.shade300),
        border: InputBorder.none,
      ),
      textTheme: TextTheme(
        titleLarge: TextStyle(color: Colors.white),
        bodyMedium: TextStyle(color: Colors.white),
      ),
    );
  }

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
    final results = conges.where((conge) {
      final fullName = '${conge['nom']} ${conge['prenom']}';
      return fullName.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final conge = results[index];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 4,
          child: ListTile(
            leading: CircleAvatar(
              radius: 30.0,
              backgroundColor: Colors.grey.shade200,
              child: Icon(Icons.person, color: Colors.grey.shade700),
            ),
            title: Text('${conge['nom']} ${conge['prenom']}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Type: ${conge['type']}'),
                Text('Du: ${conge['du']}'),
                Text('Jusqu\'à: ${conge['jusqua']}'),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.remove_red_eye),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CongeDetailsPage(conge),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete,color: Colors.red),
                  onPressed: () {
                    //OnPress Delete congé Action
                  },
                ),
              ],
            ),
            onTap: () {
              query = '${conge['nom']} ${conge['prenom']}';
              showResults(context);
            },
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = conges.where((conge) {
      final fullName = '${conge['nom']} ${conge['prenom']}';
      return fullName.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final conge = suggestions[index];
        return ListTile(
          title: Text('${conge['nom']} ${conge['prenom']}'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Type: ${conge['type']}'),
              Text('Du: ${conge['du']}'),
              Text('Jusqu\'à: ${conge['jusqua']}'),
            ],
          ),
          onTap: () {
            query = '${conge['nom']} ${conge['prenom']}';
            showResults(context);
          },
        );
      },
    );
  }
}

class CongeDetailsPage extends StatelessWidget {
  final Map<String, String> conge;

  CongeDetailsPage(this.conge);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Détails du Congé',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 174, 17, 6),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nom: ${conge['nom']}', style: TextStyle(fontSize: 18)),
            Text('Prénom: ${conge['prenom']}', style: TextStyle(fontSize: 18)),
            Text('Type de congé: ${conge['type']}', style: TextStyle(fontSize: 18)),
            Text('Du: ${conge['du']}', style: TextStyle(fontSize: 18)),
            Text('Jusqu\'à: ${conge['jusqua']}', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
