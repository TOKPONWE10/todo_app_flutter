import 'package:flutter/material.dart';
import '../models/task.dart';

// Widget représentant une tâche individuelle dans la liste
class TaskTile extends StatelessWidget {
  final Task task;
  final VoidCallback onToggleDone; 
  final VoidCallback onDelete; 
  final VoidCallback onEdit;

  const TaskTile({
    super.key,
    required this.task,
    required this.onToggleDone,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.done ? TextDecoration.lineThrough : null, 
          ),
        ),
        leading: Checkbox(
          value: task.done,
          onChanged: (_) => onToggleDone(), 
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(icon: const Icon(Icons.edit), onPressed: onEdit),
            IconButton(icon: const Icon(Icons.delete), onPressed: onDelete),
          ],
        ),
      ),
    );
  }
}
