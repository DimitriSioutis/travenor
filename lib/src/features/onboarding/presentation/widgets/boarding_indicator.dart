import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';

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
        color: isActive ? mainColor : mainColor.withValues(alpha: 0.4),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}
