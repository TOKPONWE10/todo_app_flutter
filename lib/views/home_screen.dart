import 'package:flutter/material.dart';
import 'task_list_screen.dart';

// Écran principal de l'application Todo
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo App')),
      body: TaskListScreen(), 
    );
  }
}
