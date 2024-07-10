import 'package:flutter/material.dart';

class ListeAbsenceEmploye extends StatefulWidget {
  @override
  _ListeAbsenceEmployeState createState() => _ListeAbsenceEmployeState();
}

class _ListeAbsenceEmployeState extends State<ListeAbsenceEmploye> {
  final List<Map<String, String>> absences = [
    {
      'nom': 'Doe',
      'prenom': 'John',
      'type': 'Retard',
      'du': '2024-06-01 08:00',
      'jusqua': '2024-06-01 09:00',
    },
    {
      'nom': 'Smith',
      'prenom': 'Jane',
      'type': 'Abandon de poste',
      'du': '2024-07-01',
      'jusqua': '2024-07-05',
    },
    // Ajoutez plus de données fictives ici pour les tests
  ];

  String query = '';

  @override
  Widget build(BuildContext context) {
    final filteredAbsences = absences.where((absence) {
      final fullName = '${absence['nom']} ${absence['prenom']}';
      return fullName.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Liste des Absences',
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
                delegate: AbsenceSearchDelegate(absences),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: filteredAbsences.length,
        itemBuilder: (context, index) {
          final absence = filteredAbsences[index];
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
              title: Text('${absence['nom']} ${absence['prenom']}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Type: ${absence['type']}'),
                  Text('Du: ${absence['du']}'),
                  Text('Jusqu\'à: ${absence['jusqua']}'),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove_red_eye),
                    onPressed: () {
                      // Naviguer vers la page d'information d'absence de l'employé
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AbsenceDetailsPage(absence),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // Supprimer l'absence de la liste
                      setState(() {
                        absences.removeAt(index);
                      });
                    },
                  ),
                ],
              ),
              onTap: () {
                // Action lorsque l'on clique sur une absence
              },
            ),
          );
        },
      ),
    );
  }
}

class AbsenceSearchDelegate extends SearchDelegate {
  final List<Map<String, String>> absences;

  AbsenceSearchDelegate(this.absences);

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
    final results = absences.where((absence) {
      final fullName = '${absence['nom']} ${absence['prenom']}';
      return fullName.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final absence = results[index];
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
            title: Text('${absence['nom']} ${absence['prenom']}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Type: ${absence['type']}'),
                Text('Du: ${absence['du']}'),
                Text('Jusqu\'à: ${absence['jusqua']}'),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.remove_red_eye,color: Colors.blue),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AbsenceDetailsPage(absence),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete,color: Colors.red,),
                  onPressed: () {
                    //Delete data de l'absance liste boutton
                  },
                ),
              ],
            ),
            onTap: () {
              query = '${absence['nom']} ${absence['prenom']}';
              showResults(context);
            },
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = absences.where((absence) {
      final fullName = '${absence['nom']} ${absence['prenom']}';
      return fullName.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final absence = suggestions[index];
        return ListTile(
          title: Text('${absence['nom']} ${absence['prenom']}'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Type: ${absence['type']}'),
              Text('Du: ${absence['du']}'),
              Text('Jusqu\'à: ${absence['jusqua']}'),
            ],
          ),
          onTap: () {
            query = '${absence['nom']} ${absence['prenom']}';
            showResults(context);
          },
        );
      },
    );
  }
}

class AbsenceDetailsPage extends StatelessWidget {
  final Map<String, String> absence;

  AbsenceDetailsPage(this.absence);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Détails de l\'Absence',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 174, 17, 6),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nom: ${absence['nom']}', style: TextStyle(fontSize: 18)),
            Text('Prénom: ${absence['prenom']}', style: TextStyle(fontSize: 18)),
            Text('Type d\'absence: ${absence['type']}', style: TextStyle(fontSize: 18)),
            Text('Du: ${absence['du']}', style: TextStyle(fontSize: 18)),
            Text('Jusqu\'à: ${absence['jusqua']}', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
