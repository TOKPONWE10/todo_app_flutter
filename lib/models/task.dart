import 'package:freezed_annotation/freezed_annotation.dart';

part 'task.freezed.dart';
part 'task.g.dart';

// Modèle de tâche immuable pour l'application Todo
@freezed
class Task with _$Task {
  const factory Task({
    required String id,       
    required String title,    
    @Default(false) bool done, 
  }) = _Task;

  // Crée une tâche à partir d'un JSON
  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}
