import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({Key? key, required this.text, required this.onPressed})
      : super(key: key);
  final onPressed, text;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Text(text),
      hoverColor: Colors.grey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      elevation: 4.0,
      color: Colors.blueGrey,
      onPressed: onPressed,
    );
  }
}
