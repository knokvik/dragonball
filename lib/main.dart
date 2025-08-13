import 'package:flutter/material.dart';
import 'package:fquery/fquery.dart';
import 'package:go_router/go_router.dart';
import 'package:knokvik/backend/persistence/disk.dart';
import 'package:knokvik/backend/persistence/preferences.dart';
import 'package:knokvik/backend/persistence/sqlite.dart';
import 'package:knokvik/backend/provider.dart';
import 'package:knokvik/backend/repository/fquery.dart';
import 'package:knokvik/backend/state.dart';
import 'package:knokvik/backend/web/websocket.dart';
import 'package:knokvik/bloc/bloc_counter.dart';
import 'package:knokvik/bloc/cubit_example.dart';
import 'package:knokvik/guide/layout.dart';
import 'package:provider/provider.dart';

void main() {

  final client = new QueryClient();
  runApp(QueryClientProvider(
    queryClient: client, 
    child: MaterialApp.router(
    routerConfig: router,
  ))); 
}

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const Home(),
      routes: [
        GoRoute(
          path: 'layout',
          builder: (context, state) => Layout(),
        ),
        GoRoute(
          path: 'backend',
          builder: (context, state) => Scaffold( appBar: AppBar( title: Text('Hello')),),
          routes: [
            GoRoute(
              path: 'state',
              builder: (context, state) => ChangeNotifierProvider(
                create: (context) => Counter(),
                child: const StateMangagement(), 
              ),
            ),
            GoRoute(
              path: 'bloc',
              builder: (context, state) => ChangeNotifierProvider(
                create: (context) => Counter(),
                child:  BlocCounter(label: 'BlocCounter'), 
              ),
            ),
            GoRoute(
              path: 'cubit',
              builder: (context, state) => CubitExample(),
            ),
            GoRoute(
              path: 'fquery',
              builder: (context, state) => UserListPage(),
            ),
            GoRoute(
              path: 'websocket',
              builder: (context, state) => WebSocketDemo()
            ),
            GoRoute(
              path: 'disk',
              builder: (context, state) => DiskDataExample()
            ),
            GoRoute(
              path: 'preferences',
              builder: (context, state) => Preferences()
            ),
            GoRoute(
              path: 'sqlite',
              builder: (context, state) => SQLite()
            ),
          ],
        ),
      ],
    ),
  ],
);


class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter-Docs'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                context.go('/layout');
              }, 
              child: Text('Layout Example')
            ),
            ElevatedButton(
              onPressed: () {
                context.go('/backend/state');
              }, 
              child: Text('State Example')),
            ElevatedButton(
            onPressed: () {
              context.go('/backend/bloc');  
            }, 
            child: Text('Bloc Example')),
            ElevatedButton(
            onPressed: () {
              context.go('/backend/cubit');  
            }, 
            child: Text('Cubit Example')),
            ElevatedButton(
            onPressed: () {
              context.go('/backend/fquery');  
            }, 
            child: Text('Fquery Example')),
            ElevatedButton(
            onPressed: () { 
              context.go('/backend/websocket');  
            }, 
            child: Text('WebSockets  Example')),
            ElevatedButton(
            onPressed: () { 
              context.go('/backend/disk');  
            }, 
            child: Text('DiskData  Example')),
            ElevatedButton(
            onPressed: () { 
              context.go('/backend/preferences');  
            }, 
            child: Text('SharedPreferences  Example')),
            ElevatedButton(
            onPressed: () { 
              context.go('/backend/sqlite');  
            }, 
            child: Text('SQLite  Example')),
          ],
        )
      ),
    );
  }
}
