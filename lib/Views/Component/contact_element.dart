import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../configs/const.dart';
import '../../configs/size_config.dart';

class ContactElement extends StatelessWidget {
  final int type; //0 for phone, 1 for email
  final Widget icon;
  final String title;
  final double titleSizeFactor;
  const ContactElement(
      {Key? key,
      required this.type,
      required this.icon,
      required this.title,
      this.titleSizeFactor = 2.5})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight * 0.12,
      margin: EdgeInsets.symmetric(
          horizontal: SizeConfig.screenWidth * 0.05,
          vertical: SizeConfig.screenHeight * 0.02),
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * 0.03),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color(0x06000000),
            spreadRadius: 1,
            blurRadius: 3,
            blurStyle: BlurStyle.normal,
          ),
        ],
        borderRadius: BorderRadius.circular(SizeConfig.screenHeight * 0.012),
      ),
      alignment: Alignment.center,
      child: InkWell(
        onTap: () {
          Uri url;
          url = type == 0
              ? Uri.parse('tel:$title')
              : Uri.parse('mailto:$title?subject=&body=');
          _launchUrl(url);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                icon,
                SizedBox(
                  width: SizeConfig.screenWidth * 0.03,
                ),
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: SizeConfig.blockSizeVertical * titleSizeFactor,
                    color: spaceCadet,
                  ),
                )
              ],
            ),
            SvgPicture.asset(
              "assets/external.svg",
              color: spaceCadet,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }
}
