import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'providers/task_provider.dart';
import 'screens/home_screen.dart';

void main() async {
  // 1. This ensures Flutter is fully ready before we connect to the cloud
  WidgetsFlutterBinding.ensureInitialized();

  // 2. This links your app directly to your Firebase Project keys from your screen
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAtMj6grLqexi0LYkwB0rkV1xvPPQjAqRs",
      authDomain: "taskmanagerapp-byrachana.firebaseapp.com",
      projectId: "taskmanagerapp-byrachana",
      storageBucket: "taskmanagerapp-byrachana.firebasestorage.app",
      messagingSenderId: "585866987476",
      appId: "1:585866987476:web:e73a3c04a907eb5fcfb841",
    ),
  );

  runApp(const TaskApp());
}

class TaskApp extends StatelessWidget {
  const TaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 3. This wraps your app with the TaskProvider so it can fetch the live database tasks
    return ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Task Manager',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
