import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../constants/constants.dart';

class MenuIconButton extends StatelessWidget {
  const MenuIconButton({
    super.key,
    required this.assetPath,
    required this.onTap,
    required this.iconText,
    required this.isSelected,
  });

  final String assetPath;
  final VoidCallback onTap;
  final String iconText;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(assetPath, width: 24, height: 24, color: isSelected ? mainColor : grey),
          SizedBox(height: 8),
          Text(
            iconText,
            style: TextStyle(fontSize: 12, fontWeight: isSelected ? FontWeight.w500 : FontWeight.w500, color: isSelected ? mainColor : grey),
          ),
        ],
      ),
    );
  }
}
