import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xfff5f3fa),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: const Text(
          'Новая задача',
          style: TextStyle(
            color: Color(0xff222222),
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 18, right: 18, top: 42),
        child: TextField(
          controller: textController,
          decoration: InputDecoration(
            hintText: 'введите название задачи',
            filled: true,
            fillColor: const Color(0xffe0e0e0),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(7)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: const BorderSide(color: Colors.black),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: const BorderSide(color: Colors.black),
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 18, right: 18, bottom: 12),
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
              child: const Text('Сохранить'),
            ),
          ),
        ),
      ),
    );
  }

  void saveTodo() {
    Navigator.pop(context, textController.text);
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}
