import 'package:parse_server_sdk/parse_server_sdk.dart';
import '../models/user_model.dart';
class TaskModel {
  static const String _keyTableName = 'Task';
  static const String _keyTitle = 'title';
  static const String _keyDescription = 'description';
  static const String _keyIsCompleted = 'isCompleted';
  static const String _keyDueDate = 'dueDate';
  static const String _keyCreatedBy = 'createdBy';

  String? id;
  String title;
  String description;
  bool isCompleted;
  DateTime? dueDate;
  ParseUser createdBy;

  TaskModel({
    this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
    this.dueDate,
    required this.createdBy,
  });

  // Convert to Parse Object
  ParseObject toParseObject() {
    final parseObject = ParseObject(_keyTableName);
    
    if (id != null) {
      parseObject.objectId = id;
    }
    
    parseObject.set<String>(_keyTitle, title);
    parseObject.set<String>(_keyDescription, description);
    parseObject.set<bool>(_keyIsCompleted, isCompleted);
    parseObject.set<ParseUser>(_keyCreatedBy, createdBy);
    
    if (dueDate != null) {
      parseObject.set<DateTime>(_keyDueDate, dueDate!);
    }
    
    return parseObject;
  }

  // Create from Parse Object
  static TaskModel fromParseObject(ParseObject parseObject) {
    return TaskModel(
      id: parseObject.objectId,
      title: parseObject.get<String>(_keyTitle) ?? '',
      description: parseObject.get<String>(_keyDescription) ?? '',
      isCompleted: parseObject.get<bool>(_keyIsCompleted) ?? false,
      dueDate: parseObject.get<DateTime>(_keyDueDate),
      createdBy: parseObject.get<ParseUser>(_keyCreatedBy)!,
    );
  }

  // CRUD Operations
  static Future<List<TaskModel>> getTasks() async {
    final currentUser = await UserModel.getCurrentUser();
    if (currentUser == null) throw Exception('User not logged in');

    final query = QueryBuilder<ParseObject>(ParseObject(_keyTableName))
      ..whereEqualTo(_keyCreatedBy, currentUser)
      ..orderByDescending('createdAt');

    final response = await query.query();
    
    if (response.success && response.results != null) {
      return response.results!
          .map((parseObject) => fromParseObject(parseObject as ParseObject))
          .toList();
    } else {
      throw Exception('Failed to fetch tasks: ${response.error!.message}');
    }
  }

  Future<void> save() async {
    final parseObject = toParseObject();
    final response = await parseObject.save();
    
    if (!response.success) {
      throw Exception('Failed to save task: ${response.error!.message}');
    }
    
    id = response.result.objectId;
  }

  Future<void> update() async {
    if (id == null) throw Exception('Task ID is required for update');
    
    final parseObject = toParseObject();
    final response = await parseObject.save();
    
    if (!response.success) {
      throw Exception('Failed to update task: ${response.error!.message}');
    }
  }

  Future<void> delete() async {
    if (id == null) throw Exception('Task ID is required for deletion');
    
    final parseObject = ParseObject(_keyTableName)..objectId = id;
    final response = await parseObject.delete();
    
    if (!response.success) {
      throw Exception('Failed to delete task: ${response.error!.message}');
    }
  }
}