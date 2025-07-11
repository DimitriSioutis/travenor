import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/colors.dart';

class TravenorBackButton extends StatelessWidget {
  const TravenorBackButton({super.key, this.iconColor = blackText});
  final Color iconColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: Container(
        height: 44,
        width: 44,
        decoration: BoxDecoration(
          color: grey.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SvgPicture.asset(
              'assets/icons/back.svg',
              color: iconColor,
            ),
          ),
        ),
      ),
    );
  }
}
