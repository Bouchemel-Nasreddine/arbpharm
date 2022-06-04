import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final double? height;
  final double? width;
  final Widget icon;
  final Color? iconColor;
  final Color? backColor;
  final void Function() onPressed;
  final EdgeInsets? margin;
  const CustomIconButton({
    Key? key,
    this.height,
    this.width,
    required this.icon,
    this.iconColor,
    this.backColor,
    this.margin,
    required this.onPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: height,
      width: width,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backColor,
      ),
      child: IconButton(onPressed: onPressed, color: iconColor, icon: icon),
    );
  }
}
