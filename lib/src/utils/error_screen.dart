import 'package:flutter/material.dart';
import '../constants/colors.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text('Error'),
        centerTitle: true,
      ),
    );
  }
}
