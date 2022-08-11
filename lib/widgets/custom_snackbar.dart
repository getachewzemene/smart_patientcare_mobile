import 'package:flutter/material.dart';
import '/constants/widget_params.dart';

void customSnackBar(bool isError, context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.grey,
      margin: const EdgeInsets.all(20.0),
      padding: const EdgeInsets.all(10.0),
      elevation: 4.0,
      content: Text(
        message,
        style: isError ? errorTextStyle : successtextStyle,
      )));
}
