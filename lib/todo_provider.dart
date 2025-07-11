import 'package:flutter/foundation.dart';
import 'package:todo_app_395/db_helper.dart';
import 'package:todo_app_395/todo_model.dart';

class TodoProvider extends ChangeNotifier{
  DBHelper dbHelper;
  TodoProvider({required this.dbHelper});

  List<TodoModel> _mData = [];
  List<TodoModel> getTodo() => _mData;

  ///events
  addTodo({required TodoModel todo}) async{
    bool isAdded = await dbHelper.addTodo(todo: todo);
    if(isAdded){
      fetchAllTodo();
    }
  }

  fetchAllTodo({int filterType = 0}) async{
    _mData = await dbHelper.fetchAllTodo(filterType: filterType);
    notifyListeners();
  }

  completeTask({required int id, required bool isCompleted}) async{
    bool isUpdated = await dbHelper.updateTaskCompletion(id: id, isCompleted: isCompleted);
    if(isUpdated){
      fetchAllTodo();
    }
  }

}