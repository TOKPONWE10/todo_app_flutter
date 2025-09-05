import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';

/// Repository pour gérer la persistance des tâches
class TaskRepository {
  static const String key = 'tasks'; // Clé pour SharedPreferences
  List<Task> _tasks = [];            // Liste locale de tâches
  late SharedPreferences _prefs;

  TaskRepository();

  // Initialisation du repository et chargement des tâches depuis SharedPreferences
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    await _loadTasks();
  }

  // Charge les tâches depuis SharedPreferences
  Future<void> _loadTasks() async {
    final jsonString = _prefs.getString(key);
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      _tasks = jsonList.map((e) => Task.fromJson(e)).toList();
    }
  }

  // Sauvegarde les tâches dans SharedPreferences
  Future<void> _saveTasks() async {
    final jsonString = json.encode(_tasks.map((e) => e.toJson()).toList());
    await _prefs.setString(key, jsonString);
  }

  // Récupère toutes les tâches
  Future<List<Task>> getTasks() async {
    return _tasks;
  }

  // Ajoute une nouvelle tâche et sauvegarde
  Future<void> addTask(Task task) async {
    _tasks.add(task);
    await _saveTasks();
  }

  // Met à jour le titre d'une tâche existante
  Future<void> updateTaskTitle(String id, String newTitle) async {
    final index = _tasks.indexWhere((t) => t.id == id);
    if (index != -1) {
      _tasks[index] = _tasks[index].copyWith(title: newTitle);
      await _saveTasks();
    }
  }

  // Supprime une tâche par son identifiant
  Future<void> deleteTask(String id) async {
    _tasks.removeWhere((t) => t.id == id);
    await _saveTasks();
  }

  // Bascule le statut "done" d'une tâche
  Future<void> toggleDone(Task task) async {
    final index = _tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      _tasks[index] = task.copyWith(done: !task.done);
      await _saveTasks();
    }
  }
}
