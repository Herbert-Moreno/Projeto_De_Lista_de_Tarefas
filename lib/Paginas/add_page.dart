import 'package:flutter/material.dart';
import 'package:todolist/widgets/Numero_widget.dart';
import 'package:todolist/widgets/map_tasks.dart';
import 'package:todolist/widgets/marker.dart';
import 'package:todolist/file_reader.dart';

Future setjson() async {
  final data = MapTasks.instancia.get_mapa();
  writeJsonFile(data);
}

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  var nometarefa = "";
  var desctarefa = "";
  var dia = 1;
  var mes = 1;
  var cor = 0xffffc107;
  var completo = false;
  final controle_texto_tarefa = TextEditingController();
  final controle_texto_desc = TextEditingController();
  var _group_value = Colors.amber;

  void add_to_list(){
    if (_group_value == Colors.amber) {
      cor = 0xFFFFc107;
    } else if (_group_value == Colors.red) {
      cor = 0xFFF44336;
    } else if (_group_value == Colors.blue) {
      cor = 0xFF2196F3;
    } else if (_group_value == Colors.green) {
      cor = 0xFF4CAF50;
    } else if (_group_value == Colors.purple) {
      cor = 0xFF9C27B0;
    } else {
      cor = 0xFFFFc107;
    }

    Map<String, dynamic> dados = {
      "nome": nometarefa,
      "desc": desctarefa,
      "dia": dia,
      "mes": mes,
      "cor": cor,
      "tarefacompleta": completo
    };
    MapTasks.instancia.add_to_mapa(dados);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          backgroundColor: Color(0xffF4F4F4)
      ),
      body: Container(
        height: double.infinity,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 130,
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Nome da Tarefa:"),
                SizedBox(height: 20),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(2),
                    width: double.infinity,
                      height: 10,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                      child: TextField(
                        cursorColor: Colors.amber,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.amber),
                          ),
                        ),
                        onChanged: (value){
                          setState(() {
                            nometarefa = controle_texto_tarefa.text;
                          });
                        },
                        controller: controle_texto_tarefa,
                      ),
                    ),
                )])
            ), // seletor de nome
            Container(
                width: double.infinity,
                height: 130,
                padding: EdgeInsets.all(15),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Descrição da Tarefa:"),
                      SizedBox(height: 20),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(2),
                          width: double.infinity,
                          height: 10,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: TextField(
                            cursorColor: Colors.amber,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.amber),
                              ),
                            ),
                            onChanged: (value){
                              setState(() {
                                desctarefa = controle_texto_desc.text;
                              });
                            },
                            controller: controle_texto_desc,
                          ),
                        ),
                      )])
            ),
            Container(
                width: double.infinity,
                height: 300,
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.all(5),
                child: Column(
                  spacing: 20,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Data da Finalização:"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: 170,
                            height: 220,
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ListWheelScrollView.useDelegate(
                              itemExtent: 80,
                              squeeze: 1,
                              perspective: 0.005,
                              diameterRatio: 1.2,
                              physics: FixedExtentScrollPhysics(),
                              overAndUnderCenterOpacity: 0.5,
                              clipBehavior: Clip.antiAlias,
                              onSelectedItemChanged: (value){
                                setState(() {
                                  dia = (value+1);
                                });
                              },
                              childDelegate: ListWheelChildLoopingListDelegate(
                                children: List<Widget>.generate(
                                    31, (index) => NumeroWidget(index: index+=1),
                                )
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: 170,
                            height: 220,
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ListWheelScrollView.useDelegate(
                              itemExtent: 80,
                              squeeze: 1,
                              perspective: 0.005,
                              diameterRatio: 1.2,
                              physics: FixedExtentScrollPhysics(),
                              overAndUnderCenterOpacity: 0.5,
                              onSelectedItemChanged: (value){
                                setState(() {
                                  mes = (value+1);
                                });
                              },
                              childDelegate: ListWheelChildLoopingListDelegate(
                                  children: List<Widget>.generate(
                                    12, (index) => NumeroWidget(index: index+=1),
                                  )
                              ),
                            ),
                          )
                        ],
                      )
                ])
            ), // seletor de data
            Container(
                width: double.infinity,
                height: 130,
                padding: EdgeInsets.all(15),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Marcador da Tarefa:"),
                      Container(
                        width: double.infinity,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 40,
                          children: [
                            MarkerButton(
                                color: Colors.amber,
                                value: Colors.amber,
                                groupvalue: _group_value,
                                setfunc: (){
                                  _group_value = Colors.amber;
                                }),
                            MarkerButton(
                                color: Colors.red,
                                value: Colors.red,
                                groupvalue: _group_value,
                                setfunc: (){
                                  _group_value = Colors.red;
                                }),
                            MarkerButton(
                                color: Colors.green,
                                value: Colors.green,
                                groupvalue: _group_value,
                                setfunc: (){
                                  _group_value = Colors.green;
                                }),
                            MarkerButton(
                                color: Colors.blue,
                                value: Colors.blue,
                                groupvalue: _group_value,
                                setfunc: (){
                                  _group_value = Colors.blue;
                                }),
                            MarkerButton(
                                color: Colors.purple,
                                value: Colors.purple,
                                groupvalue: _group_value,
                                setfunc: (){
                                  _group_value = Colors.purple;
                                }),
                          ],
                        ),
                      ),
                    ])
            ), //seletor de cores
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.amber,
          onPressed: (){
            setState(() {
              add_to_list();
              setjson();
              Navigator.pop(context);
            });
          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(200)),
          child:Icon(
            Icons.add,
            size: 40,
            weight: 10,
            color: Color(0xff3E3E3E),
          ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}