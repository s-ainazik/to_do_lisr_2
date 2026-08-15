import 'package:to_do_list_2/database/todo.dart';

class AppDatabase {
  List<Todo> todoList = [
    Todo(id: 1, createdAt: '28.02.2026', isDone: true, title: 'Купить книгу'),
    Todo(
      id: 2,
      createdAt: '28.02.2026',
      isDone: false,
      title: 'Купить телефон',
    ),
    Todo(id: 3, createdAt: '28.02.2026', isDone: true, title: 'Пойти в зал'),
  ];

  List<Todo> getTodoList() {
    return todoList;
  }

  void addTodo(Todo todo) {
    todoList.insert(0, todo);
  }

  void changeTodoStatus({required int index, required bool isDone}) {
    todoList[index].isDone = isDone;
  }
}
