import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list_2/database/app_repository.dart';
import 'package:to_do_list_2/database/todo.dart';
import 'package:to_do_list_2/home/home_state.dart';

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

  // READ
  Future<void> getTodoList() async {
    todoList = await repo.getTodoList();

    if (todoList.isEmpty) {
      emit(
        state.copyWith(
          todoList: todoList,
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

  // CREATE
  Future<void> addTodo(Todo todo) async {
    await repo.addTodo(todo);

    await getTodoList();
  }

  // UPDATE
  Future<void> updateTodo(Todo todo) async {
    await repo.updateTodo(
      todo.id,
      todo,
    );

    await getTodoList();
  }

  // DELETE
  Future<void> deleteTodo(int id) async {
    await repo.deleteTodo(id);

    await getTodoList();
  }
}