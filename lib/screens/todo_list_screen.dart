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
  bool isInit = true;
  @override
  void initState() {
    Provider.of<DBHelper>(context, listen: false).getTodo().then((_) {
      setState(() {
        isInit = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('buildFunction');
    return Scaffold(
      appBar: AppBar(),
      body: isInit
          ? const Center(child: CircularProgressIndicator())
          : Consumer<DBHelper>(
              builder: (context, value, child) => ListView.builder(
                itemCount: value.todoList.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: ValueKey(index),
                    confirmDismiss: (direction) {
                      return showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: const Text(
                              'Really, Do you want to delete this todo?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('No'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  await value
                                      .deleteTodo(value.todoList[index]['id']);
                                },
                                child: const Text('Yes'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    direction: DismissDirection.endToStart,
                    child: ListTile(
                      title: Text(value.todoList[index]['title'] as String),
                      subtitle: Text(value.todoList[index]['id'] as String),
                      trailing: Checkbox(
                        value: (value.todoList[index]['done'] as int) == 1
                            ? true
                            : false,
                        onChanged: (v) async {
                          await value.updateTodo(
                              v!, value.todoList[index]['id'] as String, index);

                          await value.getTodo();
                          // print('object');
                          // value.useChecker(v);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
