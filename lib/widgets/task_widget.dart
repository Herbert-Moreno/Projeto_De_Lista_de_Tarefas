import 'package:flutter/material.dart';
import 'package:todolist/widgets/marker.dart';

class TaskWidget extends StatefulWidget {
  final String name;
  final int dia;
  final int mes;
  final Color marcador;

  const TaskWidget({super.key, required this.name, required this.dia, required this.mes, required this.marcador});

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  var completo = false;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    Text("${widget.dia}/${widget.mes}",
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
              Marker(color: widget.marcador)
            ],
          ),
        ],
      ),
    );
  }
}
