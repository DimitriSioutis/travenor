import 'package:flutter/material.dart';
import 'package:travenor/constants/constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Explore the',
                  style: TextStyle(
                    fontSize: 38,
                    color: blackText,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                TextSpan(
                  text: '\nBeautiful',
                  style: TextStyle(
                    fontSize: 38,
                    color: blackText,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: ' world!',
                  style: TextStyle(
                    fontSize: 38,
                    color: forgetPasswordColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
