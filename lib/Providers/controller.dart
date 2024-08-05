import 'package:flutter/cupertino.dart';
import 'package:todoapp/utils/date_preferences.dart';
import 'package:todoapp/utils/list_preferences.dart';

class Controller extends ChangeNotifier {
  List<String> date = [];

  addList({required String text,required List<String> list}){
    list.add(text);
    ListPreferences.saveList(list: list);
  }

  deleteList({required String word,required List<String> list}){
      list.remove(word);
      ListPreferences.saveList(list: list);
  }
}