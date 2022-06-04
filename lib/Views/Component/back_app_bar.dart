import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../configs/const.dart';
import '../../configs/size_config.dart';
import './custom_icon_button.dart';

class CustomBackAppBar extends StatelessWidget {
  final String title;

  const CustomBackAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).viewPadding.top;
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: CustomIconButton(
        iconColor: spaceCadet,
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
          fontWeight: FontWeight.w700,
          fontSize: 2.5 * SizeConfig.blockSizeVertical,
          color: spaceCadet,
        ),
      ),
    );
  }
}
