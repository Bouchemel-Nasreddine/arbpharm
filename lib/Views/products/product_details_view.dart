import 'package:arbpharm/Views/Component/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../configs/const.dart';
import '../../configs/size_config.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: CustomIconButton(
          iconColor: seaBlue,
          backColor: Colors.white,
          height: SizeConfig.screenHeight * 0.04,
          width: SizeConfig.screenHeight * 0.04,
          icon: SvgPicture.asset('assets/arrow_back.svg'),
          margin: EdgeInsets.all(SizeConfig.screenHeight * 0.01),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Ajouter un produit',
          style: GoogleFonts.montserrat(
            fontSize: 2 * SizeConfig.blockSizeVertical,
            fontWeight: FontWeight.bold,
            color: spaceCadet,
          ),
        ),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('hello'),
      ),
    );
  }
}
