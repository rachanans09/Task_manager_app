import 'package:flutter/material.dart';

class Task {
  final String id;
  final String title;
  final DateTime date;
  final TimeOfDay time;

  Task({
    required this.id,
    required this.title,
    required this.date,
    required this.time,
  });
}