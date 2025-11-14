import 'package:parse_server_sdk/parse_server_sdk.dart';

class UserModel {
  static const String _keyTableName = '_User';
  static const String _keyUsername = 'username';
  static const String _keyEmail = 'email';
  static const String _keyPassword = 'password';

  static Future<ParseUser> signUp(String email, String password, String username) async {
    final user = ParseUser(email, password, email);
    user.set<String>('username', username);
    
    final response = await user.signUp();
    if (response.success) {
      return response.result as ParseUser;
    } else {
      throw Exception(response.error!.message);
    }
  }

  static Future<ParseUser> login(String email, String password) async {
    final user = ParseUser(email, password, email);
    final response = await user.login();
    
    if (response.success) {
      return response.result as ParseUser;
    } else {
      throw Exception(response.error!.message);
    }
  }

  static Future<void> logout() async {
    final currentUser = await ParseUser.currentUser() as ParseUser?;
    if (currentUser != null) {
      final response = await currentUser.logout();
      if (!response.success) {
        throw Exception(response.error!.message);
      }
    }
  }

  static Future<ParseUser?> getCurrentUser() async {
    return await ParseUser.currentUser() as ParseUser?;
  }
}