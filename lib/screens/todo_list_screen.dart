import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/helpers/dbhelper.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});
  static const routeName = 'todo-list-screen';

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: Provider.of<DBHelper>(context, listen: false).getTodo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Consumer<DBHelper>(

                  builder: (context, value, child) => ListTile(
                    title: Text(snapshot.data![index]['title'] as String),
                    subtitle: Text(snapshot.data![index]['id'] as String),
                    trailing: Checkbox(
                      value: (value.todoList[index]['done'] as int) == 1
                          ? true
                          : false,
                      onChanged: (v) async {
                        print(value.todoList);
                        await value.updateTodo(
                          v!,
                          snapshot.data![index]['id'] as String,
                          index
                        );
                        // print('object');
                        // value.useChecker(v);
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
