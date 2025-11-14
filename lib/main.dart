import 'package:flutter/material.dart';
import 'package:task_manager_app/config/parse_config.dart';
import 'package:task_manager_app/screens/auth_screen.dart';
import 'package:task_manager_app/screens/task_list_screen.dart';
import 'package:task_manager_app/services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Back4App Parse SDK
  await ParseService.initializeParse();
  
  runApp(TaskApp());
}

class TaskApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FutureBuilder(
        future: AuthService.isLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return snapshot.data == true ? TaskListScreen() : AuthScreen();
          }
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}