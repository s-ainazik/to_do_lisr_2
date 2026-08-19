import 'package:to_do_list_2/database/app_database.dart';
import 'package:to_do_list_2/database/todo.dart';

class AppRepositoryImpl {
  final AppDatabase db;

  AppRepositoryImpl({required this.db});

  Future<void> loadTodoList() async {
    await db.loadTodoList();
  }

  List<Todo> getTodoList() {
    return db.getTodoList();
  }

  Future<void> addTodo(Todo todo) async {
    await db.addTodo(todo);
  }

  Future<void> changeTodoStatus({
    required int index,
    required bool isDone,
  }) async {
    await db.changeTodoStatus(
      index: index,
      isDone: isDone,
    );
  }
}