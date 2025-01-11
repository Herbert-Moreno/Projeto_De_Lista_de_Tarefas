import 'package:flutter/material.dart';

class NumeroWidget extends StatelessWidget {
  final index;
  const NumeroWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      margin: EdgeInsets.all(2),
      child: Text(
        index.toString(),
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w900,
          fontSize: 60,
        ),
      ),
    );
  }
}
