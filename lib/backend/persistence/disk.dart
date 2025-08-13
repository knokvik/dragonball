import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class FileStorageService {
  // Public getter for app's document directory path
  Future<String> get localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  // Creates file if not exists and returns it
  Future<File> createFileIfNotExists(String fileName) async {
    final path = await localPath;
    final file = File('$path/$fileName');

    final exists = await file.exists();
    if (!exists) {
      await file.create(recursive: true);
      print('File created at ${file.path}');
    } else {
      print('File already exists at ${file.path}');
    }
    return file;
  }

  // Returns a File instance for a specific file name
  Future<File> getFile(String fileName) async {
    final path = await localPath;
    return File('$path/$fileName');
  }

  // Writes string data to the file
  Future<File> writeData(String fileName, String data) async {
    final file = await getFile(fileName);
    return file.writeAsString(data);
  }

  // Reads string data from the file
  Future<String> readData(String fileName) async {
    try {
      final file = await getFile(fileName);
      return await file.readAsString();
    } catch (error) {
      throw error;
    }
  }
}

class DiskDataExample extends StatefulWidget {
  @override
  _DiskDataExampleState createState() => _DiskDataExampleState();
}

class _DiskDataExampleState extends State<DiskDataExample> {
  final fileService = FileStorageService();

  // To keep the displayed file content
  String? fileContent;

  final String fileName = 'data.txt';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Disk Data Example'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min, // adapt to content size
            children: [
              // Show app documents directory path
              FutureBuilder<String>(
                future: fileService.localPath,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return SelectableText('Error: ${snapshot.error}');
                  } else {
                    return SelectableText(
                      'App Document Directory:\n${snapshot.data}',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    );
                  }
                },
              ),
              SizedBox(height: 30),

              ElevatedButton(
                onPressed: () {
                  fileService.createFileIfNotExists(fileName).then((file) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('File created at:\n${file.path}')),
                    );
                  }).catchError((e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to create file: $e')),
                    );
                  });
                },
                child: Text('Create File'),
              ),
              SizedBox(height: 16),

              ElevatedButton(
                onPressed: () {
                  fileService.writeData(fileName, 'Hello from Flutter Disk Storage!')
                      .then((file) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Data written to file')),
                    );
                  }).catchError((e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to write data: $e')),
                    );
                  });
                },
                child: Text('Write Data'),
              ),
              SizedBox(height: 16),

              ElevatedButton(
                onPressed: () {
                  fileService.readData(fileName).then((data) {
                    setState(() {
                      fileContent = data;
                    });
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('File Contents'),
                        content: SingleChildScrollView(
                          child: SelectableText(data),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }).catchError((error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error reading file: $error')),
                    );
                  });
                },
                child: Text('Read Data'),
              ),
              SizedBox(height: 30),

              if (fileContent != null) ...[
                Text('Last read file content:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                SelectableText(fileContent!),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
  