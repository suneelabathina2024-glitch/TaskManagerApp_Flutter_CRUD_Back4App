import 'package:parse_server_sdk/parse_server_sdk.dart';

class ParseService {
  static Future<void> initializeParse() async {
    await Parse().initialize(
      'kUCyLbI5AcOUhFwASML4b0SQNEI6NrcMA0weEooh', // From Back4App Dashboard
      'https://parseapi.back4app.com', // Back4App Server URL
      clientKey: 'NOcpAunha18DwzRed7JqaPyyY7u0nwy9aBg1N45a', // From Back4App Dashboard
      autoSendSessionId: true,
      debug: true, // Set to false in production
    );
  }
}