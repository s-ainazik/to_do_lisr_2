import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list_2/database/app_database.dart';
import 'package:to_do_list_2/database/app_repository.dart';
import 'package:to_do_list_2/database/todo.dart';
import 'package:to_do_list_2/detail/detail_cubit.dart';
import 'package:to_do_list_2/detail/detail_state.dart';

class AddPage extends StatefulWidget {
  final Todo? todo;

  const AddPage({
    super.key,
    this.todo,
  });

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final TextEditingController textController =
  TextEditingController();

  bool get isEdit => widget.todo != null;

  @override
  void initState() {
    super.initState();

    if (widget.todo != null) {
      textController.text = widget.todo!.title;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkTheme =
        Theme.of(context).brightness == Brightness.dark;

    if (isEdit) {
      return BlocProvider(
        create: (context) => DetailCubit(
          repo: AppRepositoryImpl(
            db: AppDatabase(),
          ),
          todo: widget.todo!,
        ),
        child: Builder(
          builder: (context) {
            return BlocListener<DetailCubit, DetailState>(
              listener: (context, state) {
                if (state.status == DetailStatus.error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        state.errorMessage,
                      ),
                    ),
                  );
                }
              },
              child: buildPage(
                context,
                isDarkTheme,
              ),
            );
          },
        ),
      );
    }

    return buildPage(
      context,
      isDarkTheme,
    );
  }

  Widget buildPage(
      BuildContext context,
      bool isDarkTheme,
      ) {
    return Scaffold(
      backgroundColor: isDarkTheme
          ? const Color(0xff1b1726)
          : const Color(0xfff5f3fa),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: isDarkTheme
            ? const Color(0xff282338)
            : const Color(0xfff5f3fa),
        foregroundColor:
        isDarkTheme ? Colors.white : const Color(0xff222222),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
          ),
        ),
        title: Text(
          isEdit ? 'Детали задачи' : 'Новая задача',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
        actions: [
          if (isEdit)
            IconButton(
              onPressed: () {
                deleteTodo(context);
              },
              icon: const Icon(
                Icons.delete_outline,
              ),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 18,
          right: 18,
          top: 42,
        ),
        child: TextField(
          controller: textController,
          style: TextStyle(
            color: isDarkTheme ? Colors.white : Colors.black,
          ),
          decoration: InputDecoration(
            hintText: 'введите название задачи',
            hintStyle: TextStyle(
              color: isDarkTheme
                  ? const Color(0xff9ca3af)
                  : const Color(0xff555555),
            ),
            filled: true,
            fillColor: isDarkTheme
                ? const Color(0xff322d3d)
                : const Color(0xffe0e0e0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: BorderSide(
                color: isDarkTheme
                    ? const Color(0xff55505f)
                    : Colors.black,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: BorderSide(
                color: isDarkTheme
                    ? const Color(0xff0d83f6)
                    : Colors.black,
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 18,
            right: 18,
            bottom: 12,
          ),
          child: SizedBox(
            height: 38,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff0d83f6),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
              onPressed: () {
                saveTodo(context);
              },
              child: Text(
                isEdit
                    ? 'Сохранить изменения'
                    : 'Сохранить',
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> saveTodo(BuildContext context) async {
    final title = textController.text.trim();

    if (title.isEmpty) {
      return;
    }

    if (isEdit) {
      await context.read<DetailCubit>().updateTodo(
        title,
      );

      if (!mounted) {
        return;
      }

      if (context.read<DetailCubit>().state.status ==
          DetailStatus.error) {
        return;
      }

      Navigator.pop(context);
    } else {
      Navigator.pop(context, title);
    }
  }

  Future<void> deleteTodo(BuildContext context) async {
    final bool? shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        final bool isDarkTheme =
            Theme.of(context).brightness == Brightness.dark;

        return AlertDialog(
          backgroundColor: isDarkTheme
              ? const Color(0xff322d3d)
              : Colors.white,
          title: Text(
            'Удалить задачу?',
            style: TextStyle(
              color: isDarkTheme
                  ? Colors.white
                  : const Color(0xff222222),
            ),
          ),
          content: Text(
            'Вы точно хотите удалить задачу?',
            style: TextStyle(
              color: isDarkTheme
                  ? const Color(0xffb8b8c0)
                  : const Color(0xff555555),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Отмена'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text(
                'Удалить',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        );
      },
    );

    if (shouldDelete != true) {
      return;
    }

    await context.read<DetailCubit>().deleteTodo();

    if (!mounted) {
      return;
    }

    if (context.read<DetailCubit>().state.status ==
        DetailStatus.error) {
      return;
    }

    Navigator.pop(context);
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}