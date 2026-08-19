import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list_2/database/app_repository.dart';
import 'package:to_do_list_2/database/todo.dart';
import 'package:to_do_list_2/home/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final AppRepositoryImpl repo;

  List<Todo> todoList = [];

  HomeCubit({required this.repo})
      : super(
    const HomeState(
      todoList: [],
      status: TodoStatus.isLoading,
    ),
  );

  // Получаем список задач из Repository
  Future<void> getTodoList() async {
    await repo.loadTodoList();

    todoList = repo.getTodoList();

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

  // Добавляем новую задачу
  Future<void> addTodo(Todo todo) async {
    await repo.addTodo(todo);
    await getTodoList();
  }

  // Меняем состояние задачи
  Future<void> changeTodoStatus({
    required int index,
    required bool isDone,
  }) async {
    await repo.changeTodoStatus(
      index: index,
      isDone: isDone,
    );

    await getTodoList();
  }
}