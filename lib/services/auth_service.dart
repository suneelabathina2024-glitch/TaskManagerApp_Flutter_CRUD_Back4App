import 'package:parse_server_sdk/parse_server_sdk.dart';
import '../models/user_model.dart';
class AuthService {
  static Future<ParseUser> register(String email, String password, String username) async {
    try {
      // Validate student email format
      // if (!_isValidStudentEmail(email)) {
      //   throw Exception('Please use a valid student email address');
      // }
      
      return await UserModel.signUp(email, password, username);
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  static Future<ParseUser> login(String email, String password) async {
    try {
      return await UserModel.login(email, password);
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  static Future<void> logout() async {
    await UserModel.logout();
  }

  static Future<bool> isLoggedIn() async {
    final currentUser = await UserModel.getCurrentUser();
    return currentUser != null;
  }

  // static bool _isValidStudentEmail(String email) {
  //   // Add specific student email validation logic
  //   final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@(student\.|ac\.|edu\.).*$');
  //   return emailRegex.hasMatch(email.toLowerCase());
  // }
}