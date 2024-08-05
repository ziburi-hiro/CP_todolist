import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/Providers/controller.dart';
import 'package:todoapp/Screen/list_add_page.dart';
import 'package:todoapp/main.dart';
import 'package:todoapp/utils/list_preferences.dart';

class TodoListPage extends StatefulWidget{
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> with RouteAware{

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 画面遷移イベントを購読
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }
  @override
  void dispose() {
    // 画面遷移イベントを購読解除
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    // 一度、別の画面に遷移したあとで、再度この画面に戻ってきた時にコールされます。
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TodoList',style: TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 22,
          color: Colors.white,
        ),),
        elevation: 5,
        backgroundColor: Colors.green,
      ),

      body: Column(
        children: [
          FutureBuilder(
            future: ListPreferences.getList(),
            builder: (context,snapshot) {
              List<String> list = [];
              if(snapshot.hasData) {
                list = snapshot.data as List<String>;
              }
              return Flexible(
                child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: SizedBox(
                        height: 70,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0),
                              child: Text('${index + 1} : ${list[index]!}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 26,
                                ),),
                            ),

                            Expanded(
                              child: Container(),),

                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    Provider.of<Controller>(context, listen: false).deleteList(word: list[index], list: list);
                                  });
                                },
                                icon: const Icon(Icons.delete),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          )
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {return const ListAddPage();}));
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add,color: Colors.white,),
      ),
    );
  }
}
