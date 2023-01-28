import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_list/models/overall.dart';
import 'package:todo_list/screens/add_todo_screen.dart';
import 'package:todo_list/screens/todo_list_screen.dart';

class OverviewScreen extends StatelessWidget {
  OverviewScreen({super.key});
  static const routeName = '/';

  final List<Overall> items = [
    Overall(
      icon: const Icon(
        Icons.document_scanner,
        color: Colors.blue,
        size: 40,
      ),
      onPressed: (BuildContext context) {
        context.go("/${TodoListScreen.routeName}");
      },
      tasks: '12 tasks',
      title: 'All',
    ),
    Overall(
      icon: const Icon(
        Icons.work,
        color: Colors.orange,
        size: 40,
      ),
      onPressed: (BuildContext context) {},
      tasks: '14 tasks',
      title: 'Work',
    ),
    Overall(
      icon: const Icon(
        Icons.music_note,
        color: Colors.red,
        size: 40,
      ),
      onPressed: (BuildContext context) {},
      tasks: '6 tasks',
      title: "Music",
    ),
    Overall(
      icon: const Icon(
        Icons.travel_explore,
        color: Colors.green,
        size: 40,
      ),
      onPressed: (BuildContext context) {},
      tasks: '1 tasks',
      title: "Travel",
    ),
    Overall(
      icon: const Icon(
        Icons.menu_book_sharp,
        color: Colors.indigo,
        size: 40,
      ),
      onPressed: (BuildContext context) {},
      tasks: '12 tasks',
      title: 'Study',
    ),
    Overall(
      icon: const Icon(
        Icons.home,
        color: Colors.red,
        size: 40,
      ),
      onPressed: (BuildContext context) {},
      tasks: '14 tasks',
      title: 'Home',
    )
  ];

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 30, right: 13, left: 13),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const SizedBox(height: 15),
              GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.menu,
                  size: 35,
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'Lists',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 28),

              Expanded(
                child: GridView.builder(
                  itemCount: items.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    // mainAxisExtent: 86,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    childAspectRatio: 19 / 20,
                  ),
                  itemBuilder: (context, index) => InkWell(
                    onTap:() => items[index].onPressed(context),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            //rgba(0, 0, 0, 0.1);
                            color: Color.fromRGBO(0, 0, 0, 0.1),
                            offset: Offset(0.5, 1),
                            blurRadius: 3,
                            spreadRadius: 1,
                            blurStyle: BlurStyle.outer,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            items[index].icon,
                            const Spacer(),
                            Text(
                              items[index].title,
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(items[index].tasks),
                            const Spacer()
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: InkWell(
        onTap: () {
          context.go('/${AddTodoScreen.routeName}');
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 20, right: 15),
          height: deviceSize.width / (205 / 39),
          width: deviceSize.width / (205 / 39),
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.add,
            size: 40,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
