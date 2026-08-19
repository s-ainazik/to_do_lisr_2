import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list_2/database/todo.dart';

class AppDatabase {
  List<Todo> todoList = [];

  // Получаем сохраненные задачи
  Future<void> loadTodoList() async {
    final preferences = await SharedPreferences.getInstance();

    final int count = preferences.getInt('todoCount') ?? 0;

    todoList = [];

    for (int i = 0; i < count; i++) {
      final title = preferences.getString('todoTitle$i') ?? '';
      final createdAt = preferences.getString('todoDate$i') ?? '';
      final isDone = preferences.getBool('todoDone$i') ?? false;
      final id = preferences.getInt('todoId$i') ?? 0;

      todoList.add(
        Todo(
          id: id,
          title: title,
          createdAt: createdAt,
          isDone: isDone,
        ),
      );
    }
  }

  List<Todo> getTodoList() {
    return todoList;
  }

  // Добавляем новую задачу в начало списка
  Future<void> addTodo(Todo todo) async {
    todoList.insert(0, todo);

    await saveTodoList();
  }

  // Меняем статус задачи
  Future<void> changeTodoStatus({
    required int index,
    required bool isDone,
  }) async {
    todoList[index].isDone = isDone;

    await saveTodoList();
  }

  // Сохраняем все задачи
  Future<void> saveTodoList() async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.setInt('todoCount', todoList.length);

    for (int i = 0; i < todoList.length; i++) {
      await preferences.setString(
        'todoTitle$i',
        todoList[i].title,
      );

      await preferences.setString(
        'todoDate$i',
        todoList[i].createdAt,
      );

      await preferences.setBool(
        'todoDone$i',
        todoList[i].isDone,
      );

      await preferences.setInt(
        'todoId$i',
        todoList[i].id,
      );
    }
  }
}