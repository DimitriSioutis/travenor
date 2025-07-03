import 'package:flutter/material.dart';

import '../../../../constants/constants.dart';

class PasswordTextFormField extends StatefulWidget {
  const PasswordTextFormField({
    super.key,
    required this.passwordController,
    this.helper,
  });

  final TextEditingController passwordController;
  final Widget? helper;

  @override
  State<PasswordTextFormField> createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  bool _isPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.passwordController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(14)),
          borderSide: BorderSide.none,
        ),
        hintText: 'password',
        helper: widget.helper,
        hintStyle: const TextStyle(color: grey),
        fillColor: lightGrey,
        filled: true,
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility_off_outlined : Icons.visibility_outlined,
            color: grey,
          ),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        ),
      ),
      style: const TextStyle(color: grey),
      obscureText: _isPasswordVisible,
      obscuringCharacter: '∗',
      validator: (value) {
        if (value != null && value.length < 6) {
          return 'Password must be at least 6 characters';
        }
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        return null;
      },
    );
  }
}
