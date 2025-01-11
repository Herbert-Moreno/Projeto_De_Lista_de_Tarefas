import 'package:flutter/material.dart';

class Marker extends StatelessWidget {
  final Color color;
  const Marker({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 25.0,
        height: 25.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
    );
  }
}


class MarkerButton extends StatefulWidget {
  final Color color;
  final value;
  final groupvalue;
  final Function setfunc;
  const MarkerButton({super.key, required this.color, required this.value, required this.groupvalue, required this.setfunc});

  @override
  State<MarkerButton> createState() => _MarkerButtonState();
}

class _MarkerButtonState extends State<MarkerButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30.0,
      height: 30.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: widget.color,
      ),
      child: Radio(
        value: widget.value,
        groupValue: widget.groupvalue,
        onChanged: (value){
          setState(() {
            widget.setfunc();
          });
        },
        fillColor: WidgetStateColor.transparent,
      ),
    );
  }
}