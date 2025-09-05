import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/task_viewmodel.dart';
import '../models/task.dart';
import 'task_tile.dart';

// Écran affichant la liste des tâches et la zone d'ajout
class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskVM = context.watch<TaskViewModel>(); 
    final TextEditingController controller = TextEditingController();

    return Container(
      color: const Color(0xFF0d0d0d), 
      child: Column(
        children: [
          const SizedBox(height: 20),

          // Titre centré
          Center(
            child: Text(
              'Mes Tâches',
              style: TextStyle(
                color: const Color(0xFF00ffcc), 
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Zone d'ajout de tâche
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Ecrivez la tâche et appuyez sur entrer pour ajouter...',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      filled: true,
                      fillColor: const Color(0xFF222222),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    ),
                    onSubmitted: (_) async {
                      await taskVM.addTaskFromController(controller);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Tâche ajoutée !')),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 10),

                // Bouton Ajouter
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00ffcc),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  ),
                  onPressed: () async {
                    await taskVM.addTaskFromController(controller);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Tâche ajoutée !')),
                    );
                  },
                  child: const Text(
                    'AJOUTER',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Liste des tâches
          Expanded(
            child: ListView.builder(
              itemCount: taskVM.tasks.length,
              itemBuilder: (context, index) {
                final task = taskVM.tasks[index];
                return GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Tâche sélectionnée: ${task.title}')),
                    );
                  },
                  child: TaskTile(
                    task: task,
                    onToggleDone: () => taskVM.toggleDone(task),
                    onDelete: () => taskVM.deleteTask(task.id),
                    onEdit: () => _showEditDialog(context, taskVM, task),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Affiche un dialogue pour modifier le titre d'une tâche
  void _showEditDialog(BuildContext context, TaskViewModel vm, Task task) {
    final controller = TextEditingController(text: task.title);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF1a1a1a),
        title: const Text(
          "Modifier la tâche",
          style: TextStyle(color: Colors.white),
        ),
        content: TextField(
          controller: controller,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: "Modifier le titre",
            hintStyle: TextStyle(color: Colors.grey),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              await vm.editTaskTitle(task, controller.text);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Tâche modifiée !')));
            },
            child: const Text("Modifier", style: TextStyle(color: Color(0xFF00ffcc))),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Annuler", style: TextStyle(color: Colors.grey)),
          ),
        ],
      ),
    );
  }
}
