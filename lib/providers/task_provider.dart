import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> _tasks = [];
  List<Task> get tasks => _tasks;

  TaskProvider() {
    _loadTasks();
  }

  // This now correctly requires both title and deadline
  void addTask(String title, DateTime deadline) {
    if (title.trim().isEmpty) return;
    
    final newTask = Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      createdAt: deadline,
    );
    _tasks.add(newTask);
    notifyListeners();
    _saveTasks();
  }

  void toggleTaskStatus(String id) {
    final index = _tasks.indexWhere((task) => task.id == id);
    if (index != -1) {
      _tasks[index].toggleCompleted();
      notifyListeners();
      _saveTasks();
    }
  }

  void deleteTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
    notifyListeners();
    _saveTasks();
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = jsonEncode(_tasks.map((task) => task.toJson()).toList());
    await prefs.setString('user_tasks', encodedData);
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? encodedData = prefs.getString('user_tasks');
    if (encodedData != null) {
      final List<dynamic> decodedList = jsonDecode(encodedData);
      _tasks = decodedList.map((item) => Task.fromJson(item)).toList();
      notifyListeners();
    }
  }
}

