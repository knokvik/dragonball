import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fquery/fquery.dart';
import 'package:knokvik/backend/repository/data.dart';

class UserListPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final query = useQuery(
      ['data'], 
      fetchUsers,
      refetchInterval: Duration(seconds: 10),
      cacheDuration: Duration(seconds: 10),
      );

    Widget bodyContent;

    if (query.isLoading) {
      bodyContent = Center(child: CircularProgressIndicator());
    } else if (query.isError) {
      bodyContent = Center(child: Text('Error: ${query.error}'));
    } else {
      final users = query.data!;
      bodyContent = ListView.builder(
        itemCount: users.length,
        itemBuilder: (_, index) {
          return ListTile(
            title: Text(users[index].title),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('FQuery'),
      ),
      body: bodyContent,
    );
  }
}
