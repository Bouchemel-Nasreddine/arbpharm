import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../configs/const.dart';
import '../../configs/size_config.dart';

class AboutUsElement extends StatelessWidget {
  final String title;
  final String description;
  const AboutUsElement(
      {Key? key, required this.title, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(SizeConfig.screenHeight * 0.02),
        boxShadow: const [
          BoxShadow(
            color: Color(0x06000000),
            spreadRadius: 1,
            blurRadius: 3,
            blurStyle: BlurStyle.normal,
          ),
        ],
      ),
      child: ExpandablePanel(
        header: Container(
          padding: EdgeInsets.only(
            top: SizeConfig.screenHeight * 0.015,
            left: SizeConfig.screenWidth * 0.02,
          ),
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              fontSize: SizeConfig.blockSizeVertical * 2.5,
              color: spaceCadet,
            ),
          ),
        ),
        expanded: Container(
          padding: EdgeInsets.only(
            left: SizeConfig.screenHeight * 0.015,
            right: SizeConfig.screenHeight * 0.015,
            bottom: SizeConfig.screenHeight * 0.015,
          ),
          child: Text(
            description,
            softWrap: true,
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w400,
              color: Colors.black87,
              fontSize: SizeConfig.blockSizeVertical * 1.9,
            ),
          ),
        ),
        collapsed: Container(),
      ),
    );
  }
}
