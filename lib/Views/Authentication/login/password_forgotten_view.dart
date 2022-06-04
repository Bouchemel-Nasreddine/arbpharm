import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../ViewModels/Authentication/login_viewmodel.dart';
import '../../../configs/const.dart';
import '../../../configs/size_config.dart';
import '../../Component/button_widget.dart';
import '../../Component/text_field_widget.dart';

class ForgottenPasswordView extends StatelessWidget {
  ForgottenPasswordView({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: seaBlue,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Consumer<LoginViewModel>(
              builder: (context, value, child) => Container(
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'réinitialiser votre mot de passe',
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                            color: spaceCadet,
                            fontSize: SizeConfig.blockSizeVertical * 2),
                      ),
                      SvgPicture.asset(
                        'assets/arbpharm_logo.svg',
                        height: SizeConfig.screenHeight * 0.15,
                      ),
                      CustomTextField(
                        label: 'Email *',
                        controller: value.forgottenEmailController,
                        type: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null) return '';
                          if (value.isEmpty) {
                            return 'required field';
                          }
                          return null;
                        },
                      ),
                      CustomButton(
                          working: value.working,
                          text: 'réinitialiser',
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              value.forgetPassword(context);
                            }
                          }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
