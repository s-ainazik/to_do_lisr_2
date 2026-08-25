import 'package:hive_flutter/hive_flutter.dart';
import 'todo.dart';

class AppDatabase {
  static const String boxName = 'todoBox';

  Future<Box> getBox() async {
    if (Hive.isBoxOpen(boxName)) {
      return Hive.box(boxName);
    }

    return await Hive.openBox(boxName);
  }

  // CREATE
  Future<void> addTodo(Todo todo) async {
    final box = await getBox();

    await box.put(todo.id, {
      'id': todo.id,
      'title': todo.title,
      'createdAt': todo.createdAt,
      'isDone': todo.isDone,
    });
  }

  // READ
  Future<List<Todo>> getTodoList() async {
    final box = await getBox();

    final List<Todo> todoList = [];

    for (final item in box.values) {
      final data = Map<String, dynamic>.from(item);

      todoList.add(
        Todo(
          id: data['id'] as int,
          title: data['title'] as String,
          createdAt: data['createdAt'] as String,
          isDone: data['isDone'] as bool,
        ),
      );
    }

    return todoList;
  }

  // UPDATE
  Future<void> updateTodo(Todo todo) async {
    final box = await getBox();

    await box.put(todo.id, {
      'id': todo.id,
      'title': todo.title,
      'createdAt': todo.createdAt,
      'isDone': todo.isDone,
    });
  }

  // DELETE
  Future<void> deleteTodo(int id) async {
    final box = await getBox();

    await box.delete(id);
  }
}