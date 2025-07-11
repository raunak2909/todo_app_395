import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_395/add_todo_page.dart';
import 'package:todo_app_395/db_helper.dart';
import 'package:todo_app_395/todo_model.dart';
import 'package:todo_app_395/todo_provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TodoModel> allTodo = [];

  ///DBHelper? dbHelper;
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  int selectedPriority = 3;

  @override
  void initState() {
    super.initState();
    context.read<TodoProvider>().fetchAllTodo(filterType: 4);

    ///dbHelper = DBHelper.getInstance();
    ///getAllTodo();
  }

  /*void getAllTodo() async {
    allTodo = await dbHelper!.fetchAllTodo();
    setState(() {});
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Todos')),
      body: Consumer<TodoProvider>(
        builder: (_, provider, __) {
          allTodo = provider.getTodo();
          return allTodo.isNotEmpty
              ? ListView.builder(
                  itemCount: allTodo.length,
                  itemBuilder: (_, index) {
                    Color bgColor = Colors.white;
                    int priority = allTodo[index].priority;

                    if (priority == 1) {
                      bgColor = Colors.blue.shade100;
                    } else if (priority == 2) {
                      bgColor = Colors.yellow.shade100;
                    } else if (priority == 3) {
                      bgColor = Colors.red.shade100;
                    }

                    return CheckboxListTile(
                      tileColor: bgColor,
                      value: allTodo[index].isCompleted,
                      onChanged: (value) async {
                        provider.completeTask(
                          id: allTodo[index].id!,
                          isCompleted: value ?? false,
                        );
                        /*bool check = await dbHelper!.updateTaskCompletion(
                          id: allTodo[index].id!,
                          isCompleted: value ?? false,
                        );
                        if (check) {
                          getAllTodo();
                        }*/
                      },
                      title: Text(
                        allTodo[index].title,
                        style: TextStyle(
                          decoration: allTodo[index].isCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      subtitle: Text(
                        allTodo[index].desc,
                        style: TextStyle(
                          decoration: allTodo[index].isCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                    );
                  },
                )
              : Center(child: Text('No Todos'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          Navigator.push(context, MaterialPageRoute(builder: (context) => AddTodoPage(),));

          /*showModalBottomSheet(
            context: context,
            builder: (_) {
              return Container(
                width: double.infinity,
                child: Column(
                  children: [
                    Text('Add Todo'),
                    TextField(controller: titleController),
                    TextField(controller: descController),
                    StatefulBuilder(
                      builder: (context, ss) {
                        return Row(
                          children: [
                            RadioMenuButton(
                              value: 1,
                              groupValue: selectedPriority,
                              onChanged: (value) {
                                selectedPriority = value!;
                                ss(() {});
                              },
                              child: Text('Low'),
                            ),
                            RadioMenuButton(
                              value: 2,
                              groupValue: selectedPriority,
                              onChanged: (value) {
                                selectedPriority = value!;
                                ss(() {});
                              },
                              child: Text('Med'),
                            ),
                            RadioMenuButton(
                              value: 3,
                              groupValue: selectedPriority,
                              onChanged: (value) {
                                selectedPriority = value!;
                                ss(() {});
                              },
                              child: Text("High"),
                            ),
                          ],
                        );
                      },
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            context.read<TodoProvider>().addTodo(
                              todo: TodoModel(
                                title: titleController.text,
                                desc: descController.text,
                                priority: selectedPriority,
                                createdAt: DateTime.now().millisecondsSinceEpoch
                                    .toString(),
                              ),
                            );

                            *//*bool check = await dbHelper!.addTodo(
                              todo: TodoModel(
                                title: titleController.text,
                                desc: descController.text,
                                priority: selectedPriority,
                                createdAt: DateTime.now().millisecondsSinceEpoch
                                    .toString(),
                              ),
                            );
                            if (check) {
                              getAllTodo();
                            }*//*
                            Navigator.pop(context);
                          },
                          child: Text('Add'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancel'),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );*/
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
