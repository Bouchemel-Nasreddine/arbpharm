import 'package:flutter/material.dart';

class CustomCircuarProgressIdicator extends StatelessWidget {
  final Color color;
  const CustomCircuarProgressIdicator({Key? key, this.color = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color,
        strokeWidth: 0.7,
      ),
    );
  }
}
