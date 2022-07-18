import 'package:arbpharm/configs/const.dart';
import 'package:arbpharm/configs/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Data Models/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  final bool showFavorite;
  const ProductItem({Key? key, required this.product, this.showFavorite = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      height: SizeConfig.screenHeight * 0.35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SizeConfig.screenHeight * 0.03),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color(0x06000000),
            spreadRadius: 1,
            blurRadius: 3,
            blurStyle: BlurStyle.normal,
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              SizedBox(
                height: SizeConfig.screenHeight * 0.2,
                child: CachedNetworkImage(
                  imageUrl: product.image,
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              showFavorite
                  ? IconButton(
                      onPressed: () {
                        showSnackBar(
                          context: context,
                          message: '<comming soon :) />',
                          duration: const Duration(seconds: 2),
                        );
                      },
                      icon: const Icon(
                        Icons.bookmark,
                        color: Colors.white,
                      ),
                    )
                  : Container(),
            ],
          ),
          Container(
            height: SizeConfig.screenHeight * 0.15,
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.screenHeight * 0.015),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: SizeConfig.screenWidth * 0.3,
                          child: Text(
                            product.description,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.montserrat(
                              fontSize: 2.6 * SizeConfig.blockSizeVertical,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xff2E2E2E),
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: elictricBlue,
                          size: SizeConfig.screenHeight * 0.017,
                        ),
                      ],
                    ),
                    Container(
                      child: Text(
                        'publier par ${product.publishedBy}',
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.montserrat(
                          fontSize: 1.7 * SizeConfig.blockSizeVertical,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff7A7A7A),
                        ),
                      ),
                      width: SizeConfig.screenWidth * 0.26,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RatingBar.builder(
                      ignoreGestures: true,
                      onRatingUpdate: (_) {},
                      itemCount: 5,
                      itemSize: SizeConfig.screenWidth * 0.06,
                      itemBuilder: (context, index) => product.rating > index
                          ? Icon(
                              Icons.star_rounded,
                              color: amber,
                            )
                          : Icon(
                              Icons.star_border_rounded,
                              color: amber,
                            ),
                    ),
                    Text(
                      product.rating.toString(),
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w400,
                        fontSize: 4 * SizeConfig.blockSizeHorizontal,
                        color: const Color(0xff7A7A7A),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  showSnackBar(
      {required BuildContext context,
      required String message,
      Duration duration = const Duration(seconds: 4)}) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: elictricBlue,
      behavior: SnackBarBehavior.floating,
      duration: duration,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
