import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../configs/const.dart';
import '../../configs/size_config.dart';
import './custom_icon_button.dart';

class CustomAppBar extends StatelessWidget {
  final void Function() addPressed;

  const CustomAppBar({Key? key, required this.addPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).viewPadding.top;
    return Container(
      decoration: BoxDecoration(
        color: cultured,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(SizeConfig.screenHeight * 0.02),
          bottomRight: Radius.circular(SizeConfig.screenHeight * 0.02),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: topPadding + SizeConfig.screenHeight * 0.01,
          left: SizeConfig.screenWidth * 0.03,
          right: SizeConfig.screenWidth * 0.03,
          bottom: SizeConfig.screenHeight * 0.02,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomIconButton(
              iconColor: seaBlue,
              backColor: Colors.white,
              height: SizeConfig.screenHeight * 0.07,
              width: SizeConfig.screenHeight * 0.07,
              icon: SvgPicture.asset('assets/plus.svg'),
              onPressed: addPressed,
            ),
            SvgPicture.asset(
              'assets/arbpharm_logo.svg',
              height: SizeConfig.screenHeight * 0.05,
            ),
            CustomIconButton(
              iconColor: elictricBlue,
              backColor: Colors.white,
              height: SizeConfig.screenHeight * 0.07,
              width: SizeConfig.screenHeight * 0.07,
              icon: SvgPicture.asset(
                'assets/search.svg',
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
