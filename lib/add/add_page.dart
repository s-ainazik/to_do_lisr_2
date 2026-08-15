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
              onPressed: saveTask,
              child: const Text('Сохранить'),
            ),
          ),
        ),
      ),
    );
  }

  void saveTask() {
    Navigator.pop(context, textController.text);
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}


// import 'package:flutter/material.dart';
// import 'dart:async';
//
// class AddPage extends StatefulWidget {
//   const AddPage({super.key});
//
//   //создать состояние - выделить память для stateful виджет
//   @override
//   State<AddPage> createState() => _AddPageState();
// }
//
// class _AddPageState extends State<AddPage> {
//   late Timer _timer;
//   TextEditingController _textEditingController = TextEditingController();
//
//   //создание в памяти - виджет появляется в оперативной памяти
//    @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     //Запускать таймеры, анимации
//     //Инициализорвать свойства
//     //Подгружать данные с сети, с локального хранилища
//     print("Add Page - initState");
//
//     _timer = Timer.periodic(const Duration(seconds: 1), (_) {
//       final date = DateTime.now();
//       print("${date.minute} : ${date.second}");
//     });
//   }
//
//   @override
//   void didChangeDependencies() {
//     // TODO: implement didChangeDependencies
//     super.didChangeDependencies();
//     //при обновлении тем, языков и т.д. (глобальные изменения)
//     print("Add Page - didChangeDepencies");
//   }
//
// //рисует интерфейс с готовыми данными
//   @override
//   Widget build(BuildContext context) {
//     print("Add Page - build");
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(''),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: .center,
//           children: [
//            TextField(
//             decoration: InputDecoration(border: OutlineInputBorder()),
//             controller: _textEditingController,
//            ),
//            TextButton(onPressed: _onSaveTap, child: Text("Сохранить"))
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _onSaveTap() {
//     Navigator.pop(context, _textEditingController.text);
//   }
//
//   @override
//   void didUpdateWidget(covariant AddPage oldWidget) {
//     // TODO: implement didUpdateWidget
//     super.didUpdateWidget(oldWidget);
//     //обновить свойства в дочерних виджетах
//     print("Add Page didUpdateWidget");
//   }
//
//   @override
//   void deactivate() {
//     // TODO: implement deactivate
//     super.deactivate();
//     //ничего не делается
//     print("Add Page - deactivate");
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     //таймеры выключать
//     //слушателей (controller) выключать
//     //слушатели (stream)
//     _timer.cancel();
//     print("Add Page - dispose");
//   }
// }