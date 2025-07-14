import 'package:flutter/material.dart';

class BoardingIndicator extends StatelessWidget {
  const BoardingIndicator({
    super.key,
    required this.isActive,
  });

  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
      margin: const EdgeInsets.symmetric(horizontal: 2.0),
      height: 7.0,
      width: isActive ? 35.0 : 6.0,
      decoration: BoxDecoration(
        color: _getColor(context),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  Color _getColor(BuildContext context) => isActive ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.primary.withValues(alpha: 0.4);
}
