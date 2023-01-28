import 'package:flutter/material.dart';

class Overall {
  final Icon icon;
  final String title;
  final String tasks;
  final Function onPressed;

  Overall({
    required this.icon,
    required this.onPressed,
    required this.tasks,
    required this.title,
  });
}
