import 'package:flutter/material.dart';

class CustomCircuarProgressIdicator extends StatelessWidget {
  const CustomCircuarProgressIdicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.white,
        strokeWidth: 0.7,
      ),
    );
  }
}
