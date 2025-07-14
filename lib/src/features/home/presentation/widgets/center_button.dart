import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CenterButton extends StatelessWidget {
  const CenterButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, '/search'),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 8),
              color: Color(0xff0d6efd).withValues(alpha: 0.17),
              spreadRadius: 0,
              blurRadius: 19,
            ),
          ],
        ),
        child: Center(child: SvgPicture.asset('assets/icons/search.svg', width: 24, height: 24)),
      ),
    );
  }
}
