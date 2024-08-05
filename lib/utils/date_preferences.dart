import 'package:shared_preferences/shared_preferences.dart';

class DatePreferences {

  static saveDate({required List<String> list}) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('Date', list);
  }

  static Future<List<String>?> getDate() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('Date');
  }
}