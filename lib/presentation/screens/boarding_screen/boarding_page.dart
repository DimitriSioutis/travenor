import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class BoardPage extends StatelessWidget {
  final String title;
  final String lastWord;
  final String description;
  final String imageLocalPath;

  const BoardPage({
    super.key,
    required this.title,
    required this.description,
    required this.imageLocalPath,
    required this.lastWord,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
              image: DecorationImage(image: AssetImage(imageLocalPath), fit: BoxFit.cover),
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
                      text: title,
                      style: TextStyle(
                        fontSize: 30,
                        color: blackText,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text: lastWord,
                      style: TextStyle(
                        fontSize: 30,
                        color: forgetPasswordColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: grey,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
