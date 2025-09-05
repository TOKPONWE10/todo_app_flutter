import 'package:flutter/material.dart';
import '../models/task.dart';
import '../repository/task_repository.dart';

// ViewModel pour gérer la logique de l'application Todo
class TaskViewModel extends ChangeNotifier {
  final TaskRepository repository;

  List<Task> _tasks = [];      // Liste locale des tâches
  List<Task> get tasks => _tasks;

  // Initialise le ViewModel avec un repository
  TaskViewModel({required this.repository}) {
    loadTasks();
  }

  // Charge les tâches depuis le repository
  Future<void> loadTasks() async {
    _tasks = await repository.getTasks();
    notifyListeners(); // Notifie la UI des changements
  }

  // Ajoute une nouvelle tâche
  Future<void> addTask(String title) async {
    if (title.isEmpty) return;
    final task = Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      done: false,
    );
    await repository.addTask(task);
    await loadTasks();
  }

  // Supprime une tâche par son id
  Future<void> deleteTask(String id) async {
    await repository.deleteTask(id);
    await loadTasks();
  }

  // Bascule le statut "done" d'une tâche
  Future<void> toggleDone(Task task) async {
    await repository.toggleDone(task);
    await loadTasks();
  }

  // Modifie le titre d'une tâche existante
  Future<void> editTaskTitle(Task task, String newTitle) async {
    if (newTitle.isEmpty) return;
    await repository.updateTaskTitle(task.id, newTitle);
    await loadTasks();
  }

  // Ajoute une tâche depuis un TextEditingController et vide le champ
  Future<void> addTaskFromController(TextEditingController controller) async {
    if (controller.text.isEmpty) return;
    await addTask(controller.text);
    controller.clear();
  }
}
