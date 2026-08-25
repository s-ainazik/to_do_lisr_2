import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list_2/database/app_repository.dart';
import 'package:to_do_list_2/database/todo.dart';
import 'detail_state.dart';

class DetailCubit extends Cubit<DetailState> {
  final AppRepositoryImpl repo;

  final Todo todo;

  DetailCubit({
    required this.repo,
    required this.todo,
  }) : super(
    const DetailState(
      status: DetailStatus.success,
    ),
  );

  // UPDATE
  Future<void> updateTodo(String title) async {
    try {
      emit(
        state.copyWith(
          status: DetailStatus.loading,
          errorMessage: '',
        ),
      );

      final newTodo = Todo(
        id: todo.id,
        title: title,
        createdAt: todo.createdAt,
        isDone: todo.isDone,
      );

      await repo.updateTodo(
        todo.id,
        newTodo,
      );

      emit(
        state.copyWith(
          status: DetailStatus.success,
          errorMessage: '',
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: DetailStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  // DELETE
  Future<void> deleteTodo() async {
    try {
      emit(
        state.copyWith(
          status: DetailStatus.loading,
          errorMessage: '',
        ),
      );

      await repo.deleteTodo(
        todo.id,
      );

      emit(
        state.copyWith(
          status: DetailStatus.success,
          errorMessage: '',
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: DetailStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}