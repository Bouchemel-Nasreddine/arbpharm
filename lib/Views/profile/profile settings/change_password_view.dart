import 'package:arbpharm/ViewModels/profile/profile_viewmodel.dart';
import 'package:arbpharm/Views/Component/back_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../configs/const.dart';
import '../../../configs/size_config.dart';
import '../../Component/button_widget.dart';
import '../../Component/text_field_widget.dart';

class ChangePasswordView extends StatelessWidget {
  ChangePasswordView({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size(SizeConfig.screenWidth, SizeConfig.screenHeight * 0.07),
        child: const CustomBackAppBar(title: ''),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Consumer<ProfileViewModel>(
              builder: (context, value, child) => Container(
                height: SizeConfig.screenHeight * 0.75,
                width: SizeConfig.screenWidth,
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 0.1,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'changer votre mot de passe',
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                            color: spaceCadet,
                            fontSize: SizeConfig.blockSizeVertical * 2),
                      ),
                      CustomTextField(
                        label: 'ancien mot de passe',
                        controller: value.oldPasswordController,
                        type: TextInputType.text,
                        validator: (value) {
                          if (value == null) return '';
                          if (value.isEmpty) {
                            return 'required field';
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
                            return 'required field';
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
                            return 'required field';
                          } else if (val != value.newPasswordController.text) {
                            return 'les deux mots de passes ne sont pas identiques';
                          }
                          return null;
                        },
                      ),
                      CustomButton(
                          working: value.working,
                          text: 'appliquer',
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              value.changePassword(context);
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
