import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_395/todo_model.dart';
import 'package:todo_app_395/todo_provider.dart';

class AddTodoPage extends StatelessWidget {
  var titleController = TextEditingController();
  var descController = TextEditingController();
  var selectedPriority = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(11.0),
        child: Column(
          children: [
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

                    Navigator.pop(context);

                    /*bool check = await dbHelper!.addTodo(
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
                            }*/
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
      ),
    );
  }
}
