import 'package:to_do_list_2/database/app_database.dart';
import 'package:to_do_list_2/database/todo.dart';

class AppRepositoryImpl {
  final AppDatabase db;

  AppRepositoryImpl({required this.db});

  List<Todo> getTodoList() {
    return db.getTodoList();
  }

  void addTodo(Todo todo) {
    db.addTodo(todo);
  }

  void changeTodoStatus({required int index, required bool isDone}) {
    db.changeTodoStatus(index: index, isDone: isDone);
  }
}
