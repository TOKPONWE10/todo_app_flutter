import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/repository/task_repository.dart';
import 'package:todo_app/models/task.dart';

void main() {
  late TaskRepository repository;

  setUp(() async {
    repository = TaskRepository();
    await repository.init(); // Initialise les tâches
  });

  test('Ajout d\'une tâche', () async {
    final task = Task(id: '1', title: 'Test tâche', done: false);
    await repository.addTask(task);
    final tasks = await repository.getTasks();
    expect(tasks.length, 1);
    expect(tasks[0].title, 'Test tâche');
  });

  test('Suppression d\'une tâche', () async {
    final task = Task(id: '2', title: 'À supprimer', done: false);
    await repository.addTask(task);
    await repository.deleteTask('2');
    final tasks = await repository.getTasks();
    expect(tasks.any((t) => t.id == '2'), false);
  });

  test('Modification du titre d\'une tâche', () async {
    final task = Task(id: '3', title: 'Ancien titre', done: false);
    await repository.addTask(task);
    await repository.updateTaskTitle('3', 'Nouveau titre');
    final tasks = await repository.getTasks();
    expect(tasks.first.title, 'Nouveau titre');
  });

  test('Toggle done', () async {
    final task = Task(id: '4', title: 'Tâche à cocher', done: false);
    await repository.addTask(task);
    await repository.toggleDone(task);
    final tasks = await repository.getTasks();
    expect(tasks.first.done, true);
  });
}
