import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/Providers/controller.dart';
import 'package:todoapp/utils/list_preferences.dart';

class ListAddPage extends StatefulWidget {
  const ListAddPage({super.key});

  @override
  State<ListAddPage> createState() => _ListAddPageState();
}

class _ListAddPageState extends State<ListAddPage> {

  List<String> list = [];
  String text = '';
  String deadLine = '締切を入力してください';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add to List',style: TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 22,
          color: Colors.white,
        ),),
        elevation: 5,
        backgroundColor: Colors.green,
      ),

      body: Container(
        padding: const EdgeInsets.all(64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: const InputDecoration(
                  labelText: 'ToDoテキスト'
              ),
              onChanged: (String value){
                text = value;
              },
            ),

            const SizedBox(height: 8,),

            TextButton(
              onPressed: () {
                DatePicker.showDateTimePicker(context,
                    showTitleActions: true,
                    minTime: DateTime(2023, 1, 1,11,22),
                    maxTime: DateTime(2024, 12, 31, 11, 22),
                    onChanged: (date) {
                    },
                    onConfirm: (date) {
                      setState(() {
                        deadLine = date.toString();
                      });
                    },
                    currentTime: DateTime.now(),
                    locale: LocaleType.jp
                );
              },
              child: Text(deadLine,
                style: TextStyle(color: Colors.blue),
              ),
            ),

            FutureBuilder(
              future: ListPreferences.getList(),
              builder: (context,snapshot) {
                List<String> list = [];
                if(snapshot.hasData) {
                  list = snapshot.data as List<String>;
                }
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      Provider.of<Controller>(context, listen: false).addList(text: text, list: list);

                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Text('リスト追加',style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),),
                  ),
                );
              },
            ),

            const SizedBox(height: 8,),

            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('キャンセル'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
