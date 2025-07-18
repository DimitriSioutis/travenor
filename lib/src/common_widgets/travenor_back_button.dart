import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:travenor/src/extensions/color_scheme_extension.dart';

class TravenorBackButton extends StatelessWidget {
  const TravenorBackButton({super.key, this.iconColor});
  final Color? iconColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: () => Navigator.pop(context),
      child: Container(
        height: 44,
        width: 44,
        decoration: BoxDecoration(
          color: Theme.of(context).extension<CustomColorsExtension>()!.onSurfaceSecondary!.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SvgPicture.asset(
              'assets/icons/back.svg',
              color: iconColor ?? Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}
