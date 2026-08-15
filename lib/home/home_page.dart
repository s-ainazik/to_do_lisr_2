import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list_2/add/add_page.dart';
import 'package:to_do_list_2/database/app_database.dart';
import 'package:to_do_list_2/database/app_repository.dart';
import 'package:to_do_list_2/database/todo.dart';
import 'package:to_do_list_2/home/home_cubit.dart';
import 'package:to_do_list_2/home/home_state.dart';
import 'package:to_do_list_2/settings/settings_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomeCubit(repo: AppRepositoryImpl(db: AppDatabase()))..getTodoList(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: const Color(0xfff5f3fa),
              title: const Text(
                'Мои задачи',
                style: TextStyle(
                  color: Color(0xff222222),
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    openSettingsPage(context);
                  },
                  icon: const Icon(Icons.settings),
                ),
              ],
            ),
            body: getBody(context, state),
            floatingActionButton: FloatingActionButton(
              backgroundColor: const Color(0xff0d83f6),
              foregroundColor: Colors.white,
              onPressed: () {
                openAddPage(context);
              },
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }

  Widget getBody(BuildContext context, HomeState state) {
    if (state.status == TodoStatus.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.status == TodoStatus.empty) {
      return const Center(
        child: Text(
          'Список задач пустой',
          style: TextStyle(color: Color(0xff222222), fontSize: 16),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(left: 18, right: 18, top: 40, bottom: 90),
      itemCount: state.todoList.length,
      itemBuilder: (context, index) {
        return TodoItem(
          todo: state.todoList[index],
          onChanged: (value) {
            context.read<HomeCubit>().changeTodoStatus(
              index: index,
              isDone: value ?? false,
            );
          },
        );
      },
    );
  }

  Future<void> openAddPage(BuildContext context) async {
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (context) => const AddPage()),
    );

    if (!context.mounted) {
      return;
    }

    if (result != null && result.trim().isNotEmpty) {
      context.read<HomeCubit>().addTodo(
        Todo(
          id: DateTime.now().millisecondsSinceEpoch,
          title: result.trim(),
          createdAt: getDate(),
          isDone: false,
        ),
      );
    }
  }

  void openSettingsPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SettingsPage()),
    );
  }

  String getDate() {
    final now = DateTime.now();
    final day = now.day.toString().padLeft(2, '0');
    final month = now.month.toString().padLeft(2, '0');
    final year = now.year.toString().substring(2);

    return '$day.$month.$year';
  }
}

class TodoItem extends StatelessWidget {
  const TodoItem({super.key, required this.todo, required this.onChanged});

  final Todo todo;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 49,
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.only(left: 8, right: 8),
      decoration: BoxDecoration(
        color: const Color(0xff0d83f6),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 28,
            child: Checkbox(
              value: todo.isDone,
              onChanged: onChanged,
              checkColor: Colors.black,
              activeColor: Colors.white,
              side: const BorderSide(color: Colors.black, width: 2),
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              todo.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white, fontSize: 13),
            ),
          ),
          const SizedBox(width: 8),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.white,
                    size: 8,
                  ),
                  const SizedBox(width: 3),
                  Text(
                    todo.createdAt,
                    style: const TextStyle(color: Colors.white, fontSize: 8),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        ],
      ),
    );
  }
}

//
