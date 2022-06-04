import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../configs/const.dart';
import '../../configs/size_config.dart';

class CustomProfileRow extends StatelessWidget {
  final String icon;
  final String title;
  final Function() onPressed;
  const CustomProfileRow({
    Key? key,
    required this.icon,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: SizeConfig.screenHeight * 0.08,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SizeConfig.screenHeight * 0.01),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 2,
            blurRadius: 5,
            blurStyle: BlurStyle.normal,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(SizeConfig.screenHeight * 0.01),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressed,
          child: Container(
            height: SizeConfig.screenHeight * 0.07,
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.screenWidth * 0.05,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        icon,
                        height: SizeConfig.screenHeight * 0.025,
                        color: elictricBlue,
                      ),
                      SizedBox(
                        width: SizeConfig.screenWidth * 0.06,
                      ),
                      Text(
                        title,
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w400,
                          color: halaya,
                          fontSize: 1.6 * SizeConfig.blockSizeVertical,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios_rounded),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
