import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../configs/const.dart';
import '../../../configs/size_config.dart';
import '../../Component/button_widget.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: seaBlue,
      body: SafeArea(
        child: Center(
          child: Container(
            margin:
                EdgeInsets.symmetric(vertical: SizeConfig.screenHeight * 0.05),
            height: SizeConfig.screenHeight * 0.85,
            width: SizeConfig.screenWidth,
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.screenWidth * 0.1,
              vertical: SizeConfig.screenHeight * 0.04,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(SizeConfig.screenWidth * 0.1),
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Connectez-vous',
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      color: spaceCadet,
                      fontSize: SizeConfig.blockSizeVertical * 3.6),
                ),
                SvgPicture.asset(
                  'assets/arbpharm_logo.svg',
                  height: SizeConfig.screenHeight * 0.15,
                ),
                Text(
                  'vous êtes dans la category',
                  style: GoogleFonts.montserrat(
                    fontSize: 2.3 * SizeConfig.blockSizeVertical,
                    color: spaceCadet,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SvgPicture.asset(
                  'assets/letter_a.svg',
                  height: SizeConfig.screenHeight * 0.12,
                ),
                Text(
                  'vous êtes un fournisseur',
                  style: GoogleFonts.montserrat(
                    fontSize: 2.3 * SizeConfig.blockSizeVertical,
                    color: spaceCadet,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                CustomButton(
                    text: 'Commancer',
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/generale_home_view', (route) => false);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
