import 'package:flutter/material.dart';
import 'package:travenor/src/features/onboarding/domain/models/onboarding_page.dart';

import '../../../../constants/colors.dart';

class BoardPage extends StatelessWidget {
  final OnboardingPageInfo info;

  const BoardPage({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
              image: DecorationImage(image: AssetImage(info.imageLocalPath), fit: BoxFit.cover),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(33.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: info.title,
                      style: TextStyle(
                        fontSize: 30,
                        color: blackText,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text: info.lastWord,
                      style: TextStyle(
                        fontSize: 30,
                        color: secondaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                info.description,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: grey, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
