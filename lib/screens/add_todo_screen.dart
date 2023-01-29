import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/helpers/dbhelper.dart';

class AddTodoScreen extends StatefulWidget {
  AddTodoScreen({super.key});
  static const routeName = 'add-todo-screen';

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  DateTime? _notificationDate;

  final TextEditingController _controller = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  String dropValue = 'Work';

  void _picker() async {
    DateTime? nD = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (nD == null) {
      return;
    }
    final nT = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 09, minute: 09),
    );
    if (nT == null) {
      return;
    }
    nD = DateTime(nD.year, nD.month, nD.day, nT.hour, nT.minute);
    setState(() {
      _notificationDate = nD;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 30, right: 14, left: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'New Task',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      context.go('/');
                    },
                    icon: const Icon(Icons.clear),
                  ),
                ],
              ),
              const SizedBox(height: 27),
              const Text(
                'what are you planning?',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  letterSpacing: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, bottom: 18),
                child: TextField(
                  style: const TextStyle(fontSize: 21),
                  maxLines: 6,
                  controller: _controller,
                ),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.notifications,
                    size: 35,
                  ),
                  const SizedBox(width: 14),
                  Text(
                    DateFormat.d()
                        .add_MMMM()
                        .add_Hm()
                        .format(_notificationDate ?? DateTime.now())
                        .toString(),
                    style: const TextStyle(fontSize: 20),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: _picker,
                    icon: const Icon(Icons.edit),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  const Icon(
                    Icons.note_alt_sharp,
                    size: 35,
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: TextField(
                      controller: _noteController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Add Note',
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.category,
                    size: 35,
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: DropdownButton(
                        // hint: const Padding(
                        //   padding: EdgeInsets.all(8.0),
                        //   child: Text('Category'),
                        // ),
                        value: dropValue,
                        
                        style: const TextStyle(fontSize: 18, color: Colors.black),
                        isExpanded: true,
                        iconSize: 42,
                        dropdownColor: Colors.white,
                        
                        // selectedItemBuilder: (context) => ,
                        underline: const Divider(
                          endIndent: 0,
                          indent: 0,
                          height: 0,
                          thickness: 2,
                        ),
                        items: const [
                          DropdownMenuItem(value: 'Work', child: Text('Work')),
                          DropdownMenuItem(
                              value: 'Music', child: Text('Music')),
                          DropdownMenuItem(
                              value: 'Travel', child: Text('Travel')),
                          DropdownMenuItem(
                              value: 'Study', child: Text('Study')),
                          DropdownMenuItem(value: 'Home', child: Text('Home')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            
                          dropValue = value!;
                          });
                        }),
                  ),
                  const Spacer(
                    flex: 2,
                  )
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_notificationDate == null ||
                            _controller.text.isEmpty ||
                            _noteController.text.isEmpty) {
                          return;
                        }
                        await Provider.of<DBHelper>(context, listen: false)
                            .addTodo(
                          date: _notificationDate!,
                          title: _controller.text,
                          note: _noteController.text,
                        );

                        context.go('/');
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(10),
                      ),
                      child: const Text(
                        'Create',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
