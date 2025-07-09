import 'package:todo_app_395/db_helper.dart';

class TodoModel {
  int? id;
  String title;
  String desc;
  int priority;
  String createdAt;
  bool isCompleted;

  TodoModel({
    this.id,
    required this.title,
    required this.desc,
    this.priority = 3,
    required this.createdAt,
    this.isCompleted = false,
  });

  Map<String, dynamic> toMap() {
    return {
      DBHelper.COLUMN_TODO_TITLE: title,
      DBHelper.COLUMN_TODO_DESC: desc,
      DBHelper.COLUMN_TODO_PRIORITY: priority,
      DBHelper.COLUMN_TODO_IS_COMPLETED: isCompleted ? 1 : 0,
      DBHelper.COLUMN_TODO_CREATED_AT: createdAt,
    };
  }

  static List<TodoModel> getAllTodo(List<Map<String, dynamic>> data) {
    List<TodoModel> mTodo = [];

    for (Map<String, dynamic> eachTodo in data) {
      TodoModel todo = TodoModel.fromMap(eachTodo);
      mTodo.add(todo);
    }

    return mTodo;
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map[DBHelper.COLUMN_TODO_ID],
      priority: map[DBHelper.COLUMN_TODO_PRIORITY],
      isCompleted: map[DBHelper.COLUMN_TODO_IS_COMPLETED] == 1,
      title: map[DBHelper.COLUMN_TODO_TITLE],
      desc: map[DBHelper.COLUMN_TODO_DESC],
      createdAt: map[DBHelper.COLUMN_TODO_CREATED_AT],
    );
  }
}

///
//{
//       COLUMN_TODO_TITLE : todo.title,
//       COLUMN_TODO_DESC : todo.desc,
//       COLUMN_TODO_PRIORITY : priority,
//       COLUMN_TODO_CREATED_AT : DateTime.now().millisecondsSinceEpoch.toString(),
//       COLUMN_TODO_IS_COMPLETED : 0,
//     }
