import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// Use only ONE import for your provider, based on your file folder structure
import 'providers/task_provider.dart'; 
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // This wrapper allows the whole app to "see" the TaskProvider
    return ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const HomeScreen(),
      ),
    );
  }
}
