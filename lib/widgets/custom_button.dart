import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    required this.onTap,
    this.titlePadding = const EdgeInsets.symmetric(
      vertical: 18,
      horizontal: 60,
    ),
    this.fontSize = 18,
  });

  final String title;
  final void Function() onTap;
  final EdgeInsetsGeometry titlePadding;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(58),
      child: InkWell(
        borderRadius: BorderRadius.circular(58),
        onTap: onTap,
        child: Ink(
          padding: titlePadding,
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(58),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: fontSize,
              fontWeight: FontWeight.w700,
              height: 1,
            ),
          ),
        ),
      ),
    );
  }
}
