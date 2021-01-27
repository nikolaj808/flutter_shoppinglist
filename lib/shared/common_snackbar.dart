import 'package:flutter/material.dart';

class CommonSnackBar {
  static SnackBar success(String message) => SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            Text(
              message,
            ),
            const Icon(
              Icons.check_circle,
              color: Colors.green,
            ),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        elevation: 8.0,
      );

  static SnackBar error(String message) => SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            Text(
              message,
            ),
            const Icon(
              Icons.cancel,
              color: Colors.red,
            ),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        elevation: 8.0,
      );
}
