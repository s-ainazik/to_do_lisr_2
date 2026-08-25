import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list_2/database/app_repository.dart';
import 'package:to_do_list_2/database/todo.dart';
import 'package:to_do_list_2/home/home_state.dart';
import 'package:flutter/foundation.dart';

class HomeCubit extends Cubit<HomeState> {
  final AppRepositoryImpl repo;

  List<Todo> todoList = [];

  HomeCubit({
    required this.repo,
  }) : super(
    const HomeState(
      todoList: [],
      status: TodoStatus.isLoading,
    ),
  );

  Future<void> getTodoList() async {
    todoList = await repo.getTodoList();

    if (todoList.isEmpty) {
      emit(
        state.copyWith(
          todoList: [],
          status: TodoStatus.empty,
        ),
      );
    } else {
      emit(
        state.copyWith(
          todoList: todoList,
          status: TodoStatus.success,
        ),
      );
    }
  }

  Future<void> addTodo(Todo todo) async {
    debugPrint('СОХРАНЯЕМ: ${todo.title}');

    await repo.addTodo(todo);

    debugPrint('ЗАДАЧА СОХРАНЕНА');

    await getTodoList();

    debugPrint('ЗАДАЧ В БАЗЕ: ${todoList.length}');
  }

  Future<void> updateTodo(Todo todo) async {
    await repo.updateTodo(todo);

    await getTodoList();
  }

  Future<void> deleteTodo(int id) async {
    await repo.deleteTodo(id);

    await getTodoList();
  }
}