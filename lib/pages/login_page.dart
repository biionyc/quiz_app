import 'package:flutter/material.dart';
import 'package:quiz_app/services/firebase_services.dart';
import 'package:quiz_app/widgets/custom_button.dart';
import 'package:quiz_app/widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController(
    text: '',
  );
  final TextEditingController _passwordController = TextEditingController(
    text: '',
  );
  bool _isSignUpPage = false;
  bool _hidePassword = true;

  String? _validateField(String? value, String fieldName) {
    final emailregex =
        RegExp('^[a-zA-Z0-9_.±]+@[a-zA-Z0-9-]+.[a-zA-Z0-9-.]+\$');
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    if (!emailregex.hasMatch(value) && fieldName != 'Password') {
      return 'Enter a valid email';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _isSignUpPage ? 'Sign Up' : 'Login',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    height: 1,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                CustomTextField(
                  labelText: 'Email',
                  controller: _emailController,
                  validator: (value) {
                    return _validateField(value, 'Email');
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  labelText: 'Password',
                  controller: _passwordController,
                  isPassword: true,
                  hidePassword: _hidePassword,
                  validator: (value) {
                    return _validateField(value, 'Password');
                  },
                  onPressHidePassword: () {
                    setState(() {
                      _hidePassword = !_hidePassword;
                    });
                  },
                ),
                const SizedBox(
                  height: 50,
                ),
                CustomButton(
                  title: _isSignUpPage ? 'Sign Up' : 'Login',
                  onTap: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      if (_isSignUpPage) {
                        signUp(
                          _emailController.text,
                          _passwordController.text,
                          context,
                        );
                      } else {
                        login(
                          _emailController.text,
                          _passwordController.text,
                          context,
                        );
                      }
                    }
                  },
                ),
                const SizedBox(
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _isSignUpPage ? 'Aleady a user?' : 'Not registered?',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        height: 1,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isSignUpPage = !_isSignUpPage;
                        });
                      },
                      child: Text(_isSignUpPage ? 'Login' : 'Sign Up'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
