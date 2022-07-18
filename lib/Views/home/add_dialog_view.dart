import 'package:arbpharm/Views/Component/coming_soon_view.dart';
import 'package:arbpharm/Views/products/add_product_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../configs/const.dart';
import '../../configs/size_config.dart';
import '../request/add_request_dialog_box.dart';

class AddDialogView extends StatelessWidget {
  const AddDialogView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: SizeConfig.screenHeight * 0.25,
      ),
      child: Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SizeConfig.screenHeight * 0.03),
        ),
        child: SizedBox(
          width: SizeConfig.screenWidth * 0.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () => goToAddProduct(context),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(SizeConfig.screenHeight * 0.025),
                    color: metalicSeaweed,
                  ),
                  width: SizeConfig.screenWidth * 0.65,
                  height: SizeConfig.screenHeight * 0.15,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/products.svg",
                        height: SizeConfig.screenHeight * 0.07,
                        width: SizeConfig.screenHeight * 0.07,
                      ),
                      Container(
                        width: SizeConfig.screenWidth * 0.4,
                        alignment: Alignment.center,
                        child: Text(
                          'Publier un produit',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            fontSize: SizeConfig.blockSizeVertical * 1.7,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => displayAddDemandeDialog(context),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(SizeConfig.screenHeight * 0.025),
                    color: metalicSeaweed,
                  ),
                  width: SizeConfig.screenWidth * 0.65,
                  height: SizeConfig.screenHeight * 0.15,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/gift.svg",
                        height: SizeConfig.screenHeight * 0.07,
                        width: SizeConfig.screenHeight * 0.07,
                      ),
                      Container(
                        width: SizeConfig.screenWidth * 0.4,
                        alignment: Alignment.center,
                        child: Text(
                          'Une demande',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            fontSize: SizeConfig.blockSizeVertical * 1.7,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

displayAddDemandeDialog(context) {
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
        return const AddRequestDialog();
      });
}

goToAddProduct(context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const AddProductView()));
}
