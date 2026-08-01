class Task {
  Task({required this.title, required this.date, this.isDone = false});

  final String title;
  final String date;
  bool isDone;
}
