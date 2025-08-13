import 'dart:convert';
import 'package:http/http.dart' as http;

class User {
  final int userId;
  final int id;
  final String title;
  final bool completed;

  User({ required this.userId, required this.id, required this.title , required this.completed});

  factory User.fromJson(Map<String, dynamic> json) {
    return User( userId: json['userId'], id: json['id'], title: json['title'] , completed: json['completed']);
  }
}

Future<List<User>> fetchUsers() async {
final response = await http.get(
  Uri.parse('https://jsonplaceholder.typicode.com/todos'),
  headers: {
    'Accept': 'application/json',
    'User-Agent': 'Mozilla/5.0 (Flutter; Dart)',
  },
);

  print(response.body);
  if (response.statusCode == 200) {
    final List<dynamic> jsonList = json.decode(response.body);
    return jsonList.map((json) => User.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load users: ${response.statusCode}');
  }
}