import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:travenor/src/extensions/color_scheme_extension.dart';

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
          SvgPicture.asset(
            assetPath,
            width: 24,
            height: 24,
            color: _getColor(context),
          ),
          SizedBox(height: 8),
          Text(
            iconText,
            style: _getTextTheme(context)!.copyWith(color: _getColor(context)),
          ),
        ],
      ),
    );
  }

  TextStyle? _getTextTheme(BuildContext context) => isSelected ? Theme.of(context).textTheme.labelMedium : Theme.of(context).textTheme.labelSmall;

  Color? _getColor(BuildContext context) => isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).extension<CustomColorsExtension>()!.onSurfaceSecondary;
}
