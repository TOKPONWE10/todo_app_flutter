import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/viewmodels/task_viewmodel.dart';
import 'package:todo_app/repository/task_repository.dart';

void main() {
  late TaskRepository repository;
  late TaskViewModel viewModel;

  setUp(() async {
    repository = TaskRepository();
    await repository.init();
    viewModel = TaskViewModel(repository: repository);
    await viewModel.loadTasks();
  });

  test('Ajouter une tâche via ViewModel', () async {
    await viewModel.addTask('Nouvelle tâche');
    expect(viewModel.tasks.length, 1);
    expect(viewModel.tasks.first.title, 'Nouvelle tâche');
  });

  test('Supprimer une tâche via ViewModel', () async {
    await viewModel.addTask('À supprimer');
    final id = viewModel.tasks.first.id;
    await viewModel.deleteTask(id);
    expect(viewModel.tasks.isEmpty, true);
  });

  test('Modifier le titre via ViewModel', () async {
    await viewModel.addTask('Titre ancien');
    final task = viewModel.tasks.first;
    await viewModel.editTaskTitle(task, 'Titre nouveau');
    expect(viewModel.tasks.first.title, 'Titre nouveau');
  });

  test('Toggle done via ViewModel', () async {
    await viewModel.addTask('Tâche à cocher');
    final task = viewModel.tasks.first;
    await viewModel.toggleDone(task);
    expect(viewModel.tasks.first.done, true);
  });
}
