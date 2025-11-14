import '../models/task_model.dart';
import '../models/user_model.dart';

class TaskService {
  static Future<List<TaskModel>> fetchTasks() async {
    return await TaskModel.getTasks();
  }

  static Future<TaskModel> createTask({
    required String title,
    required String description,
    DateTime? dueDate,
  }) async {
    final currentUser = await UserModel.getCurrentUser();
    if (currentUser == null) throw Exception('User not logged in');

    final task = TaskModel(
      title: title,
      description: description,
      dueDate: dueDate,
      createdBy: currentUser,
    );

    await task.save();
    return task;
  }

  static Future<void> updateTask(TaskModel task) async {
    await task.update();
  }

  static Future<void> deleteTask(TaskModel task) async {
    await task.delete();
  }

  static Future<void> toggleTaskCompletion(TaskModel task) async {
    task.isCompleted = !task.isCompleted;
    await task.update();
  }
}