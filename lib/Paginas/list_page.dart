import 'package:flutter/material.dart';
import 'package:todolist/Paginas/add_page.dart';
import 'package:todolist/widgets/map_tasks.dart';
import 'package:todolist/widgets/task_widget.dart';
import 'package:todolist/file_reader.dart';

Future setdata() async {
  final json = readJsonFile();
  Map<String, dynamic> data = await json as Map<String, dynamic>;
  MapTasks.instancia.tasks = data["tasks"];
  return data;
}

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: Colors.amber, scaffoldBackgroundColor: Color(0xffF4F4F4)),
        debugShowCheckedModeBanner: false,
        home: ListScaffold()
    );
  }
}

class ListScaffold extends StatefulWidget {
  const ListScaffold({super.key});

  @override
  State<ListScaffold> createState() => _ListScaffoldState();
}

class _ListScaffoldState extends State<ListScaffold> {
  var refresh = 0;

  @override
  void initState() {
    super.initState();
    setdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffF4F4F4),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.task_outlined,
                  size: 50,
                  weight: 20,
                  color: Color(0xff3E3E3E)
                ),
                SizedBox(width: 8),
                Text("Tarefas:",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff3E3E3E)
                    )
                ),
              ],
            ),
            IconButton(
              iconSize: 35,
                onPressed: (){
                  setState(() {
                    refresh++;
                  });
                },
                icon: Icon(Icons.refresh))
          ]
        )
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(15),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            for (int i=0; i < MapTasks.instancia.tasks.length; i++)
              TaskWidget(
                  name: MapTasks.instancia.retorne_elemento(i, "nome"),
                  desc: MapTasks.instancia.retorne_elemento(i, "desc"),
                  dia: MapTasks.instancia.retorne_elemento(i, "dia"),
                  mes: MapTasks.instancia.retorne_elemento(i, "mes"),
                  marcador: MapTasks.instancia.retorne_elemento(i, "cor"),
                  tarefacompleta: MapTasks.instancia.retorne_elemento(i, "tarefacompleta"),
                  index: i
              )
          ],
        )
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.amber,
        onPressed: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddPage())
          );
          setState(() {
            refresh++;
          });
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(200)),
        label:Row(
          children: [
            Icon(
              Icons.add, 
              size: 40,
              weight: 10,
              color: Color(0xff3E3E3E),
            ),
            Text("Adicionar Tarefa",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff3E3E3E)
            ))
          ],
        )
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
  }
}