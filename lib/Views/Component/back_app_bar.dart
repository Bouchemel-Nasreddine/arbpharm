import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../configs/const.dart';
import '../../configs/size_config.dart';
import './custom_icon_button.dart';

class CustomBackAppBar extends StatelessWidget {
  final String title;
  final Color color;
  final Color titleColor;

  const CustomBackAppBar({
    Key? key,
    required this.title,
    this.color = Colors.transparent,
    this.titleColor = const Color(0xff15224f), //spaceCadet
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: color,
      leading: CustomIconButton(
        iconColor: titleColor,
        height: SizeConfig.screenHeight * 0.07,
        width: SizeConfig.screenHeight * 0.07,
        icon: const Icon(Icons.arrow_back_ios_rounded),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      centerTitle: true,
      title: Text(
        title,
        style: GoogleFonts.inter(
          fontWeight: FontWeight.w600,
          fontSize: 2.3 * SizeConfig.blockSizeVertical,
          color: titleColor,
        ),
      ),
    );
  }
}
