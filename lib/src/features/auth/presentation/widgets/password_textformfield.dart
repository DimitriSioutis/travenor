import 'package:flutter/material.dart';
import '../../../../extensions/color_scheme_extension.dart';

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
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
        color: Theme.of(context).extension<CustomColorsExtension>()!.onSurfaceSecondary,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(14)),
          borderSide: BorderSide.none,
        ),
        hintText: 'password',
        helper: widget.helper,
        hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: Theme.of(context).extension<CustomColorsExtension>()!.onSurfaceSecondary,
        ),
        fillColor: Theme.of(context).extension<CustomColorsExtension>()!.onSurfaceBlock,
        filled: true,
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility_off_outlined : Icons.visibility_outlined,
            color: Theme.of(context).extension<CustomColorsExtension>()!.onSurfaceSecondary,
          ),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        ),
      ),

      obscureText: _isPasswordVisible,
      obscuringCharacter: '∗',
      validator: (value) {
        if (value != null && value.length < 8) {
          return 'Password must be at least 8 characters';
        }
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        return null;
      },
    );
  }
}
