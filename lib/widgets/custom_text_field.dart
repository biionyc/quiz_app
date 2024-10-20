import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.labelText,
    this.keyboardType,
    this.validator,
    this.hidePassword = false,
    this.isPassword = false,
    this.onPressHidePassword,
    required this.controller,
  });

  final String labelText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool hidePassword;
  final bool isPassword;
  final VoidCallback? onPressHidePassword;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        labelText: labelText,
        floatingLabelStyle: const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w400,
          height: 1,
        ),
        labelStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 1,
        ),
        counterText: '',
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Colors.grey[600]!,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1,
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1,
            color: Colors.red,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1,
            color: Colors.red,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        errorStyle: const TextStyle(
          color: Colors.red,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 1,
        ),
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 1,
        ),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  hidePassword ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  if (onPressHidePassword != null) {
                    onPressHidePassword!();
                  }
                },
              )
            : null,
      ),
      keyboardType: keyboardType,
      cursorColor: Colors.black,
      cursorHeight: 18,
      onTapOutside: (e) {
        FocusScope.of(context).unfocus();
      },
      validator: validator,
      obscureText: hidePassword,
    );
  }
}
