import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static storeTypeDatabase(bool typeDatabase) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("typeDatabase", typeDatabase);
  }

  static Future<bool> loadTypeDatabase() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? typeDatabase = prefs.getBool('typeDatabase');
    return typeDatabase ?? true;
  }
}