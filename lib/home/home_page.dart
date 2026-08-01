import 'package:flutter/material.dart';
import 'package:to_do_list_2/add/add_page.dart';
import 'package:to_do_list_2/models/task.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Task> tasks = [
    Task(title: 'Сделать домашнее задание', date: '14.09.26'),
    Task(title: 'Сделать домашнее задание', date: '14.09.26', isDone: true),

  ];

  @override
  Widget build(BuildContext context) {
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
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(
          left: 18,
          right: 18,
          top: 40,
          bottom: 90,
        ),
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return TaskItem(
            task: tasks[index],
            onChanged: (value) {
              setState(() {
                tasks[index].isDone = value ?? false;
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff0d83f6),
        foregroundColor: Colors.white,
        onPressed: openAddPage,
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> openAddPage() async {
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (context) => const AddPage()),
    );

    if (result != null && result.trim().isNotEmpty) {
      setState(() {
        tasks.insert(0, Task(title: result.trim(), date: getDate()));
      });
    }
  }

  String getDate() {
    final now = DateTime.now();
    final day = now.day.toString().padLeft(2, '0');
    final month = now.month.toString().padLeft(2, '0');
    final year = now.year.toString().substring(2);

    return '$day.$month.$year';
  }
}

class TaskItem extends StatelessWidget {
  const TaskItem({super.key, required this.task, required this.onChanged});

  final Task task;
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
              value: task.isDone,
              onChanged: onChanged,
              checkColor: Colors.black,
              activeColor: Colors.white,
              side: const BorderSide(color: Colors.black, width: 2),
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              task.title,
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
                    task.date,
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
