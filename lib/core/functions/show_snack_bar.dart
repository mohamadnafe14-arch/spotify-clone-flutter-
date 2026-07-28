import 'package:flutter/material.dart';

void showSnackBar(String message, BuildContext context) => ScaffoldMessenger.of(context)
..hideCurrentSnackBar()
..showSnackBar(SnackBar(content: Text(message)));