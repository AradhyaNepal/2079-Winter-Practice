
import 'package:flutter/material.dart';

class OpenSettingSnackBar extends SnackBar {
  final String snackBarMessage;
  OpenSettingSnackBar({
    required this.snackBarMessage,
    Key? key,
  }):super(
    key: key,
    content:Text(
      snackBarMessage,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
    backgroundColor: Colors.blue,
  );
}