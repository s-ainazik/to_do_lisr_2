import 'package:flutter/material.dart';
import 'package:to_do_list_2/database/todo.dart';

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
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: Text(
          isEdit ? 'Изменить задачу' : 'Новая задача',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
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
              onPressed: saveTodo,
              child: Text(
                isEdit ? 'Сохранить изменения' : 'Сохранить',
              ),
            ),
          ),
        ),
      ),
    );
  }

  void saveTodo() {
    final title = textController.text.trim();

    if (title.isEmpty) {
      return;
    }

    if (isEdit) {
      final todo = Todo(
        id: widget.todo!.id,
        title: title,
        createdAt: widget.todo!.createdAt,
        isDone: widget.todo!.isDone,
      );

      Navigator.pop(context, todo);
    } else {
      Navigator.pop(context, title);
    }
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}