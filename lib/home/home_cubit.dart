import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list_2/database/app_repository.dart';
import 'package:to_do_list_2/database/todo.dart';
import 'package:to_do_list_2/home/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final AppRepositoryImpl repo;

  List<Todo> todoList = [];

  HomeCubit({required this.repo})
    : super(const HomeState(todoList: [], status: .isLoading));

  void getTodoList() {
    // просит у Repository список задач
    todoList = repo.getTodoList();

    if (todoList.isEmpty) {
      emit(state.copyWith(todoList: todoList, status: .empty));
    } else {
      emit(state.copyWith(todoList: todoList, status: .success));
    }
  }

  void addTodo(Todo todo) {
    repo.addTodo(todo);
    getTodoList();
  }

  void changeTodoStatus({required int index, required bool isDone}) {
    repo.changeTodoStatus(index: index, isDone: isDone);
    getTodoList();
  }
}
