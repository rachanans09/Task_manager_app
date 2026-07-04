import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  TaskProvider() {
    loadTasks(); // Automatically load saved tasks when the app starts
  }

  // Add a new task and save it
  void addTask(String title, DateTime date, TimeOfDay time) async {
    final newTask = Task(
      id: DateTime.now().toString(),
      title: title,
      date: date,
      time: time,
    );
    _tasks.add(newTask);
    notifyListeners();
    await saveTasks(); // Save to local storage
  }

  // Delete a task and update storage
  void deleteTask(String id) async {
    _tasks.removeWhere((task) => task.id == id);
    notifyListeners();
    await saveTasks(); // Save updated list to local storage
  }

  // Save data locally
  Future<void> saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> taskMapList = _tasks.map((task) {
      return {
        'id': task.id,
        'title': task.title,
        'date': task.date.toIso8601String(),
        'hour': task.time.hour,
        'minute': task.time.minute,
      };
    }).toList();

    await prefs.setString('user_tasks', jsonEncode(taskMapList));
  }

  // Load data from local storage
  Future<void> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? cachedTasks = prefs.getString('user_tasks');

    if (cachedTasks != null) {
      final List<dynamic> decodedList = jsonDecode(cachedTasks);
      _tasks = decodedList.map((item) {
        return Task(
          id: item['id'],
          title: item['title'],
          date: DateTime.parse(item['date']),
          time: TimeOfDay(hour: item['hour'], minute: item['minute']),
        );
      }).toList();
      notifyListeners();
    }
  }
}

