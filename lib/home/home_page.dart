import 'package:flutter/material.dart';
import 'package:to_do_list_2/add/add_page.dart';
import 'package:to_do_list_2/models/task.dart';
import 'package:to_do_list_2/settings/settings_page.dart';

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
        actions: [
          IconButton(
            onPressed: openSettingsPage,
            icon: const Icon(Icons.settings),
          ),
        ],
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

  void openSettingsPage() {
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

// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:to_do_list_2/add/add_page.dart';
// import 'package:to_do_list_2/settings/settings_page.dart';
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   final String title;
//
//   //создать состояние - выделить память для stateful виджет
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   late int _counter;
//   bool _isTextVisible = true;
//   TextEditingController _textEditingController = TextEditingController();
//   Color _containerColor = Colors.blue;
//   List<Color> _colorList = [
//     Colors.blue,
//     Colors.red,
//     Colors.yellowAccent,
//     Colors.green,
//   ];
//
//   //создание в памяти - виджет появляется в оперативной памяти
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     //Запускать таймеры, анимации
//     //Инициализорвать свойства
//     _counter = 0;
//     //Подгружать данные с сети, с локального хранилища
//     print("Home Page - initState");
//   }
//
//   @override
//   void didChangeDependencies() {
//     // TODO: implement didChangeDependencies
//     super.didChangeDependencies();
//     //при обновлении тем, языков и т.д. (глобальные изменения)
//     print("Home Page - didChangeDepencies");
//   }
//
//   //рисует интерфейс с готовыми данными
//   @override
//   Widget build(BuildContext context) {
//     print("Home Page - build");
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//         actions: [
//           IconButton(
//             onPressed: _onSettingsTap,
//             icon: const Icon(Icons.settings),
//           ),
//         ],
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: .center,
//           children: [
//             Visibility(
//               child: const Text('You have pushed the button this many times:'),
//               visible: _isTextVisible,
//             ),
//
//             TextField(
//               decoration: InputDecoration(border: OutlineInputBorder()),
//               controller: _textEditingController,
//               onChanged: (value) {
//                 setState(() {
//                   _counter = _textEditingController.text.length;
//                 });
//               },
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//             TextButton(
//               onPressed: _toggleText,
//               child: Text(_isTextVisible ? "Скрыть" : "Поуказать"),
//             ),
//             Container(width: 300, height: 200, color: _containerColor),
//             TextButton(onPressed: _changeColors, child: Text("Поменять цвет")),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _onAddTap,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
//
//   void _toggleText() {
//     setState(() {
//       _isTextVisible = !_isTextVisible;
//     });
//   }
//
//   void _changeColors() {
//     setState(() {
//       _containerColor = _colorList[Random().nextInt(_colorList.length)];
//     });
//   }
//
//   void _onAddTap() async {
//     final result = await Navigator.push(
//       context,
//       MaterialPageRoute(builder: (_) => AddPage()),
//     );
//     if (result != null) {
//       print("$result");
//     }
//   }
//
//   void _onSettingsTap() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (_) => const SettingsPage()),
//     );
//   }
//
//   @override
//   void didUpdateWidget(covariant MyHomePage oldWidget) {
//     // TODO: implement didUpdateWidget
//     super.didUpdateWidget(oldWidget);
//     //обновить свойства в дочерних виджетах
//     print("Home Page didUpdateWidget");
//   }
//
//   @override
//   void deactivate() {
//     // TODO: implement deactivate
//     super.deactivate();
//     //ничего не делается
//     print("Home Page - deactivate");
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     //таймеры выключать
//     //слушателей (controller) выключать
//     //слушатели (stream)
//     print("Home Page - dispose");
//   }
// }
