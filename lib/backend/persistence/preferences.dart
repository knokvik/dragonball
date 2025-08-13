import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveUserName(String name) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('userName', name);
}

Future<String?> getUserName() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('userName');
}

class Preferences extends StatefulWidget {
  Preferences({super.key});

  @override
  State<Preferences> createState() => _PreferencesState();
}

class _PreferencesState extends State<Preferences> {
  var data = '';

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SharedPreferences Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await saveUserName('Niraj'); // Save a fixed value or get it from input
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Data Saved!')),
                );
              },
              child: Text('Save Preferences'),
            ),
            SizedBox(height: 20),
            Text('UserName : $data'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final value = await getUserName();
                setState(() {
                  data = value ?? 'No data found';
                });
                print(data);
              },
              child: Text('Get Preferences'),
            ),
          ],
        ),
      ),
    );
  }
}
