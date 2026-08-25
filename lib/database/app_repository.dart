import 'app_database.dart';
import 'todo.dart';

class AppRepositoryImpl {
  final AppDatabase db;

  AppRepositoryImpl({
    required this.db,
  });

  Future<void> addTodo(Todo todo) async {
    await db.addTodo(todo);
  }

  Future<List<Todo>> getTodoList() async {
    return await db.getTodoList();
  }

  Future<void> updateTodo(
      int index,
      Todo todo,
      ) async {
    await db.updateTodo(
      index,
      todo,
    );
  }

  Future<void> deleteTodo(int index) async {
    await db.deleteTodo(index);
  }
}