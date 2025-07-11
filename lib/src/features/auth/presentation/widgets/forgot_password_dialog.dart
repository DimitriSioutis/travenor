import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../constants/colors.dart';

class ForgotPasswordDialog extends StatelessWidget {
  const ForgotPasswordDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      alignment: Alignment.center,
      backgroundColor: bgColor,
      child: InkWell(
        onTap: () => Navigator.pop(context),
        child: Container(
          height: 196,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: secondaryColor,
                child: SvgPicture.asset('assets/icons/email.svg'),
              ),
              Text(
                'Check your email',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: blackText),
              ),
              Text(
                'We have send password recovery instruction to your email',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
