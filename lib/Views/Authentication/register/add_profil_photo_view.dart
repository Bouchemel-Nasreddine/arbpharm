// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:arbpharm/Views/Component/upload_file_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../ViewModels/Authentication/register_viewmodel.dart';
import '../../../configs/const.dart';
import '../../../configs/size_config.dart';
import '../../Component/button_widget.dart';

class AddProfilePicView extends StatelessWidget {
  const AddProfilePicView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterViewModel>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: seaBlue,
        body: SafeArea(
          child: Center(
            child: Container(
              margin: EdgeInsets.symmetric(
                  vertical: SizeConfig.screenHeight * 0.05),
              height: SizeConfig.screenHeight * 0.85,
              width: SizeConfig.screenWidth,
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.screenWidth * 0.1,
                vertical: SizeConfig.screenHeight * 0.04,
              ),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(SizeConfig.screenWidth * 0.1),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Inscription',
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                            color: spaceCadet,
                            fontSize: SizeConfig.blockSizeVertical * 3.6),
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'passer',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontSize: 1.4 * SizeConfig.blockSizeVertical,
                            color: metalicSeaweed,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = (() {
                              if (value.profilePic != null)
                                value.profilePic = null;
                              Navigator.pushNamed(
                                  context, '/payement_information');
                            }),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.1,
                  ),
                  Text(
                    'Ajouter une photo de profil',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      fontSize: 1.7 * SizeConfig.blockSizeVertical,
                      color: spaceCadet,
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.03,
                  ),
                  CustomUploadFileField(
                    size: Size(
                      SizeConfig.screenHeight * 0.2,
                      SizeConfig.screenHeight * 0.2,
                    ),
                    shape: CircleBorder(
                      side: BorderSide(
                        width: 0.8,
                        color: brightGrey,
                      ),
                    ),
                    file: value.profilePic,
                    uploadPhoto: () => value.getProfilePic(),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.1,
                  ),
                  CustomButton(
                      text: 's\'inscrire',
                      onPressed: () {
                        if (value.profilePic != null)
                          Navigator.pushNamed(context, '/payement_information');
                        else
                          value.showSnackBar(
                              context: context,
                              message:
                                  'vous devez choisir une photo, ou cliquer sur passer');
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
