import 'package:flutter/material.dart';

void showCustomSnackBar(BuildContext context, String content,
    {bool? isSuccess = false}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(
          content,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            height: 1,
          ),
        ),
        backgroundColor: Colors.redAccent,
        dismissDirection: DismissDirection.down,
      ),
    );
}
