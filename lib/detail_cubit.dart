import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list_2/database/app_repository.dart';
import 'package:to_do_list_2/database/todo.dart';

class DetailCubit extends Cubit<Todo> {
  final AppRepositoryImpl repo;

  DetailCubit({
    required this.repo,
    required Todo todo,
  }) : super(todo);

  // UPDATE
  Future<void> updateTodo(String title) async {
    final newTodo = Todo(
      id: state.id,
      title: title,
      createdAt: state.createdAt,
      isDone: state.isDone,
    );

    await repo.updateTodo(
      state.id,
      newTodo,
    );

    emit(newTodo);
  }

  // DELETE
  Future<void> deleteTodo() async {
    await repo.deleteTodo(
      state.id,
    );
  }
}