import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  // final color, textColor;
  final String buttonText;
  final buttonTap;
  MyButton({this.buttonTap, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
            margin: const EdgeInsets.all(3),
            color: Colors.purple,
            child: Center(
              child: Text(
                buttonText,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            )),
      ),
    );
  }
}
