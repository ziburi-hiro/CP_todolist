import 'package:shared_preferences/shared_preferences.dart';

class ListPreferences {

  static saveList({required List<String> list}) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('List', list);
  }

  static Future<List<String>?> getList() async {

    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('List');

  }
}