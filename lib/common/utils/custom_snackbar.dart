import 'package:flutter/material.dart';

class CustomSnackBar {
  static showSnack(context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: color,
        content: Text(
      message,
      style: const TextStyle(),
    )));
  }
}
