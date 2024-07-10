import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class UploadDownloadFilesPage extends StatefulWidget {
  final Function onBack;
  final Function onSubmit;

  UploadDownloadFilesPage({required this.onBack, required this.onSubmit});

  @override
  _UploadDownloadFilesPage createState() => _UploadDownloadFilesPage();
}

class _UploadDownloadFilesPage extends State<UploadDownloadFilesPage> {
  Map<String, String?> _files = {
    "Pièce justificative (image.png)": null,
    "Diplômes (diplomes.pdf)": null,
    "CV (cv.pdf)": null,
    "RIB (rib.pdf)": null,
    "Contrat (contrat.pdf)": null,
    "CIN (cin.pdf)": null, // Ajout du fichier CIN
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ..._files.keys.map((key) => _buildFilePicker(key)).toList(),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  widget.onSubmit();
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
                  widget.onBack();
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

  void _downloadFile(String label) {
    // Simulated download action
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Téléchargement du fichier $label')),
    );
  }

  Widget _buildFilePicker(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles();
              if (result != null) {
                setState(() {
                  _files[label] = result.files.single.name;
                });
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 174, 17, 6),
            ),
            child: const Icon(Icons.upload_file, color: Colors.white),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: () => _downloadFile(label),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
            ),
            child: const Icon(Icons.download, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
