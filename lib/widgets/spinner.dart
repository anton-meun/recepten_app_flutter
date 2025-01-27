import 'package:flutter/material.dart';

class Spinner extends StatelessWidget {
  const Spinner({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      width: 20,
      child: const CircularProgressIndicator.adaptive(
        strokeWidth: 2,
      ),
    );
  }
}
