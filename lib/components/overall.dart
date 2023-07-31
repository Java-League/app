import 'package:flutter/material.dart';

class Overall extends StatelessWidget {
  final int overall;

  Overall({required this.overall});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor;

    if (overall > 80) {
      backgroundColor = const Color.fromRGBO(12, 133, 57, 1);
      textColor = Colors.black;
    } else if (overall > 70) {
      backgroundColor = const Color.fromRGBO(102, 168, 15, 1);
      textColor = Colors.black;
    } else if (overall > 60) {
      backgroundColor = const Color.fromRGBO(230, 182, 0, 1);
      textColor = Colors.black;
    } else if (overall > 50) {
      backgroundColor = const Color.fromRGBO(217, 92, 15, 1);
      textColor = Colors.black;
    } else {
      backgroundColor = const Color.fromRGBO(201, 42, 42, 1);
      textColor = Colors.black;
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
      ),
      child: Text(
        '$overall',
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
        ),
      ),
    );
  }
}