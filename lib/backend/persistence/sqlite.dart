import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class SQLite extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<SQLite> {
  late Database _db;
  List<Map<String, dynamic>> _users = [];

  @override
  void initState() {
    super.initState();
    initDatabase();
  }

  Future<void> initDatabase() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'app_database.db');

    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            email TEXT
          )
        ''');
      },
    );

    await fetchUsers();
  }

  Future<void> insertUser(String name, String email) async {
    await _db.insert('users', {'name': name, 'email': email});
    await fetchUsers();
  }

  Future<void> fetchUsers() async {
    final users = await _db.query('users');
    setState(() {
      _users = users;
    });
  }

  Future<void> deleteUser(int id) async {
    await _db.delete('users', where: 'id = ?', whereArgs: [id]);
    await fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('SQLite Example')),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  final name = nameController.text.trim();
                  final email = emailController.text.trim();

                  if (name.isNotEmpty && email.isNotEmpty) {
                    await insertUser(name, email);
                    nameController.clear();
                    emailController.clear();
                  }
                },
                child: Text('Add User'),
              ),
              SizedBox(height: 20),
              Expanded(
                child: _users.isEmpty
                    ? Center(child: Text('No Users'))
                    : ListView.builder(
                        itemCount: _users.length,
                        itemBuilder: (context, index) {
                          final user = _users[index];
                          return ListTile(
                            title: Text(user['name']),
                            subtitle: Text(user['email']),
                            trailing: IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () async {
                                await deleteUser(user['id']);
                              },
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
