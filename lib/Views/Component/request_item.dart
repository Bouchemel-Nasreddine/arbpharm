import 'package:arbpharm/Data%20Models/request.dart';
import 'package:arbpharm/Views/request/add_offer.dart';
import 'package:arbpharm/configs/const.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../configs/size_config.dart';

class RequestItem extends StatelessWidget {
  final Request request;
  final int viewMode;
  const RequestItem({Key? key, required this.request, this.viewMode = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight * 0.2,
      margin: EdgeInsets.only(
        bottom: SizeConfig.screenHeight * 0.02,
        left: SizeConfig.screenWidth * viewMode == 0 ? 0.05 : 0.02,
        right: SizeConfig.screenWidth * viewMode == 0 ? 0.05 : 0.02,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(viewMode == 0
            ? SizeConfig.screenHeight * 0.02
            : SizeConfig.screenHeight * 0.015),
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
                      width: viewMode == 0
                          ? SizeConfig.screenWidth * 0.45
                          : SizeConfig.screenHeight * 0.2,
                      child: const LinearProgressIndicator(),
                    ),
                    height: SizeConfig.screenHeight * 0.2,
                    width: viewMode == 0
                        ? SizeConfig.screenWidth * 0.45
                        : SizeConfig.screenHeight * 0.2,
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
                          fontSize: (viewMode == 0 ? 2 : 1.8) *
                              SizeConfig.blockSizeVertical,
                          color: spaceCadet,
                        ),
                      ),
                      Text(
                        'quantité: ${request.amount}',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w600,
                          fontSize: (viewMode == 0 ? 2 : 1.8) *
                              SizeConfig.blockSizeVertical,
                          color: spaceCadet,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: SizeConfig.screenWidth * (viewMode == 0 ? 0.41 : 0.45),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: viewMode == 0
                            ? () {}
                            : () {
                                displayAddOfferDialog(context, request.id);
                              },
                        child: Text(
                          viewMode == 0
                              ? 'vous avez ${request.countOffers ?? 0} offres'
                              : 'disponible',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600,
                            fontSize: 2.4 * SizeConfig.blockSizeHorizontal,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          splashFactory: viewMode == 0
                              ? NoSplash.splashFactory
                              : InkSplash.splashFactory,
                          primary: elictricBlue,
                          elevation: 0,
                          fixedSize: Size(
                            viewMode == 0
                                ? SizeConfig.screenWidth * 0.35
                                : SizeConfig.screenWidth * 0.3,
                            SizeConfig.screenHeight * 0.05,
                          ),
                        ),
                      ),
                      // Container(
                      //   padding: EdgeInsets.symmetric(
                      //     horizontal: SizeConfig.screenWidth * 0.012,
                      //     vertical: SizeConfig.screenHeight * 0.01,
                      //   ),
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(
                      //         SizeConfig.screenHeight * 0.007),
                      //     color: elictricBlue,
                      //   ),
                      //   alignment: Alignment.center,
                      //   child: Text(
                      //     'vous avez ${request.countOffers ?? 0} offres',
                      //     style: GoogleFonts.montserrat(
                      //       fontWeight: FontWeight.w600,
                      //       fontSize: 2.7 * SizeConfig.blockSizeHorizontal,
                      //       color: Colors.white,
                      //     ),
                      //   ),
                      // ),
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

  void displayAddOfferDialog(context, int id) {
    showGeneralDialog(
      context: context,
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(opacity: a1.value, child: widget),
        );
      },
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return AddOfferDialog(requestId: id);
      },
    );
  }
}
