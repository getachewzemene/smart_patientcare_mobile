import 'package:flutter/material.dart';
import '/constants/widget_params.dart';

void customSnackBar(bool isError, context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Color.fromARGB(255, 33, 172, 236),
      margin: const EdgeInsets.only(bottom: 30.0, left: 20.0, right: 20.0),
      padding: const EdgeInsets.all(10.0),
      elevation: 4.0,
      content: Wrap(children: [
        Icon(
          isError ? Icons.dangerous : Icons.info,
          color: isError ? Colors.red : Colors.white,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            message,
            style: isError ? errorTextStyle : successtextStyle,
          ),
        ),
      ])));
}
