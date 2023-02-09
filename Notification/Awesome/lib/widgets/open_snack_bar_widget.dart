
import 'package:flutter/material.dart';

class OpenSettingSnackBar extends SnackBar {
  final String snackBarMessage;
  OpenSettingSnackBar({
    required this.snackBarMessage,
    super.key,
  }):super(
    content: SnackBar(
      content: Text(
        snackBarMessage,
      ),
    ),
  );
}