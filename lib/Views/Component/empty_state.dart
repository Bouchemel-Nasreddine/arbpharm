import 'package:arbpharm/configs/const.dart';
import 'package:arbpharm/configs/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class EmptyStateView extends StatelessWidget {
  const EmptyStateView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight * 0.65,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.hourglass_empty_rounded),
          Text(
            'la liste est vide!',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: SizeConfig.blockSizeVertical * 2.5,
              color: spaceCadet,
            ),
          ),
        ],
      ),
    );
  }
}
