import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task.dart';

class TaskProvider with ChangeNotifier {
  final List<Task> _tasks = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Task> get tasks => _tasks;

  TaskProvider() {
    // This constantly listens to the cloud. When your friend adds a task, 
    // it automatically updates your screen instantly!
    _firestore.collection('tasks').orderBy('createdAt', descending: true).snapshots().listen((snapshot) {
      _tasks.clear();
      for (var doc in snapshot.docs) {
        final data = doc.data();
        _tasks.add(Task(
          id: doc.id,
          title: data['title'] ?? '',
          isCompleted: data['isCompleted'] ?? false,
        ));
      }
      notifyListeners();
    });
  }

  // Pushes a brand new task up to the internet database
  Future<void> addTask(String title) async {
    if (title.trim().isEmpty) return;
    await _firestore.collection('tasks').add({
      'title': title,
      'isCompleted': false,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // Toggles checking/unchecking a task for everyone
  Future<void> toggleTaskStatus(String id, bool isCompleted) async {
    await _firestore.collection('tasks').doc(id).update({
      'isCompleted': isCompleted,
    });
  }

  // Deletes a task from everyone's screens
  Future<void> deleteTask(String id) async {
    await _firestore.collection('tasks').doc(id).delete();
  }
}
