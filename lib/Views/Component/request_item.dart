import 'package:arbpharm/Data%20Models/request.dart';
import 'package:arbpharm/configs/const.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../configs/size_config.dart';

class RequestItem extends StatelessWidget {
  final Request request;
  const RequestItem({Key? key, required this.request}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight * 0.2,
      margin: EdgeInsets.only(
        bottom: SizeConfig.screenHeight * 0.02,
        left: SizeConfig.screenWidth * 0.05,
        right: SizeConfig.screenWidth * 0.05,
      ),
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
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          request.image != null
              ? Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      SizeConfig.screenHeight * 0.02,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x06000000),
                        spreadRadius: 1,
                        blurRadius: 3,
                        blurStyle: BlurStyle.normal,
                      ),
                    ],
                  ),
                  child: CachedNetworkImage(
                    imageUrl: request.image!,
                    fit: BoxFit.cover,
                    errorWidget: (context, str, dyn) =>
                        SvgPicture.asset("assets/arbpharm_logo.svg"),
                    progressIndicatorBuilder: (context, str, progress) =>
                        SizedBox(
                      height: SizeConfig.screenHeight * 0.2,
                      width: SizeConfig.screenWidth * 0.45,
                      child: const LinearProgressIndicator(),
                    ),
                    height: SizeConfig.screenHeight * 0.2,
                    width: SizeConfig.screenWidth * 0.45,
                  ),
                )
              : SvgPicture.asset("assets/arbpharm_logo.svg"),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.screenWidth * 0.015,
              vertical: SizeConfig.screenHeight * 0.01,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: SizeConfig.screenHeight * 0.06,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        request.productName,
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w600,
                          fontSize: 2 * SizeConfig.blockSizeVertical,
                          color: spaceCadet,
                        ),
                      ),
                      Text(
                        'quantité: ${request.amount}',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w600,
                          fontSize: 2 * SizeConfig.blockSizeVertical,
                          color: spaceCadet,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: SizeConfig.screenWidth * 0.4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: SizeConfig.screenHeight * 0.03,
                        width: SizeConfig.screenWidth * 0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              SizeConfig.screenHeight * 0.007),
                          color: elictricBlue,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'vous avez ${request.countOffers} offres',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600,
                            fontSize: 2.7 * SizeConfig.blockSizeHorizontal,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
