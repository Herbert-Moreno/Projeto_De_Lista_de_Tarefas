import 'package:flutter/material.dart';
import 'package:todolist/widgets/marker.dart';
import 'map_tasks.dart';
import 'package:todolist/file_reader.dart';

Future setjson() async {
  final data = MapTasks.instancia.get_mapa();
  writeJsonFile(data);
}

class TaskWidget extends StatefulWidget {
  final String name;
  final String desc;
  final int dia;
  final int mes;
  final int marcador;
  final int index;
  final bool tarefacompleta;

  const TaskWidget({super.key, required this.name, required this.dia, 
    required this.mes, required this.marcador, required this.index, required this.desc, required this.tarefacompleta});

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  var completo = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () async{
        await showModalBottomSheet<void>(
          context: context,
          showDragHandle: true,
          backgroundColor: Color(0xffF4F4F4),
          builder: (BuildContext context) {
            return SizedBox(
              height: 300,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 267,
                    margin: EdgeInsets.all(5),
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 4, right: 4),
                            width: double.infinity,
                            height: 170,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                spacing: 2,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text("${widget.dia > 10 ? widget.dia : "0${widget.dia}"}/${widget.mes > 10 ? widget.mes : "0${widget.mes}"}",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff3E3E3E),
                                          )
                                      ),
                                      Marker(color: Color(widget.marcador))
                                    ],
                                  ),
                                  SizedBox(
                                    child: Text(widget.desc,
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff3E3E3E))
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          margin: EdgeInsets.only(left: 4, bottom: 10, right: 4),
                          width: double.infinity,
                          height: 45,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: IconButton(onPressed: (){
                              MapTasks.instancia.remove_elemento(widget.index);
                              setState(() {
                                completo = !completo;
                              });
                              Navigator.pop(context);
                            },
                              color: Colors.red,
                              icon: Icon(Icons.delete_forever)
                          )
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 4, right: 4),
                          width: double.infinity,
                          height: 45,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: IconButton(onPressed: (){
                            setState(() {
                              completo = !completo;
                            });
                          },
                              color: Colors.yellow,
                              icon: Icon(Icons.check_circle_outline)),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          });
        setState(() {
          setjson();
        });
      },
      child: Container(
        margin: EdgeInsets.only(top: 15),
        width: double.infinity,
        height: 65,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 12,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 1),
                ),
                Checkbox(
                  value: completo,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(200)),
                  activeColor: Colors.amber,
                  onChanged: (v){
                    setState(() {
                      completo = !completo;
                    });
                  },
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: 240,
                          child: Text("${widget.name}",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff3E3E3E),
                                decoration: completo
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none
                              )
                          )
                      ),
                      Text("${widget.dia > 10 ? widget.dia : "0${widget.dia}"}/${widget.mes > 10 ? widget.mes : "0${widget.mes}"}",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                              decoration: completo
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none
                          )
                      ),
                    ]),
                Marker(color: Color(widget.marcador))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
