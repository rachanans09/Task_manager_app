import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskProvider with ChangeNotifier {
  final List<Task> _tasks = [];

  List<Task> get tasks => [..._tasks];

  void addTask(String title, DateTime date, TimeOfDay time) {
    final newTask = Task(
      id: DateTime.now().toString(),
      title: title,
      date: date,
      time: time,
    );
    _tasks.add(newTask);
    notifyListeners();
  }

  void deleteTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
    notifyListeners();
  }
}
