import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/screens/todo_list_screen.dart';

import './helpers/dbhelper.dart';
import './screens/add_todo_screen.dart';
import './screens/overview_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DBHelper(),
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routerConfig: GoRouter(
          routes: [
            GoRoute(
              path: '/',
              name: 'first',
              builder: (context, state) => OverviewScreen(),
              routes: [
                GoRoute(
                  name: 'second',
                  path: AddTodoScreen.routeName,
                  builder: (context, state) =>  AddTodoScreen(),
                ),
                GoRoute(
                  name: 'third',
                  path: TodoListScreen.routeName,
                  builder: (context, state) =>  TodoListScreen(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
