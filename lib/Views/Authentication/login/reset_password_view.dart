import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../ViewModels/Authentication/login_viewmodel.dart';
import '../../../configs/const.dart';
import '../../../configs/size_config.dart';
import '../../Component/button_widget.dart';
import '../../Component/text_field_widget.dart';

class ResetPasswordView extends StatelessWidget {
  ResetPasswordView({Key? key}) : super(key: key);

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
                        'rĂ©initialiser votre mot de passe',
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                            color: spaceCadet,
                            fontSize: SizeConfig.blockSizeVertical * 2),
                      ),
                      CustomTextField(
                        label: 'code de vĂ©rification *',
                        controller: value.verificationCodeController,
                        type: TextInputType.text,
                        validator: (value) {
                          if (value == null) return '';
                          if (value.isEmpty) {
                            return 'champ obligatoire';
                          }
                          return null;
                        },
                      ),
                      CustomTextField(
                        label: 'nouvelle mot de passe *',
                        controller: value.newPasswordController,
                        type: TextInputType.text,
                        isObscure: true,
                        validator: (val) {
                          if (val == null) return '';
                          if (val.isEmpty) {
                            return 'champ obligatoire';
                          }
                          return null;
                        },
                      ),
                      CustomTextField(
                        label: 'confirmer le mot de passe *',
                        controller: value.confirmPasswordController,
                        type: TextInputType.text,
                        isObscure: true,
                        validator: (val) {
                          if (val == null) return '';
                          if (val.isEmpty) {
                            return 'champ obligatoire';
                          } else if (val != value.newPasswordController.text) {
                            return 'les deux mots de passes ne sont pas identiques';
                          }
                          return null;
                        },
                      ),
                      CustomButton(
                          working: value.working,
                          text: 'rĂ©initialiser',
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              value.ressetPassword(context);
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
