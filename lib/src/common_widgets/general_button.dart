import 'package:flutter/material.dart';

class GeneralButton extends StatelessWidget {
  const GeneralButton({
    super.key,
    required this.onTap,
    required this.buttonText,
    this.textStyle,
    this.buttonColor,
    this.borderColor,
  });

  final VoidCallback onTap;
  final String buttonText;
  final TextStyle? textStyle;
  final Color? buttonColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        height: 56,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: buttonColor ?? Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(14),
          border: borderColor != null
              ? Border.all(
                  color: borderColor!,
                  width: 2,
                )
              : null,
        ),
        alignment: Alignment.center,
        child: Text(
          buttonText,
          style:
              textStyle ??
              Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
        ),
      ),
    );
  }
}
