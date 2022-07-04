import 'package:arbpharm/Views/Component/button_widget.dart';
import 'package:arbpharm/Views/Component/text_field_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../ViewModels/Authentication/register_viewmodel.dart';
import '../../../configs/const.dart';
import '../../../configs/size_config.dart';
import '../../Component/button_widget.dart';

class Register extends StatelessWidget {
  Register({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: seaBlue,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Consumer<RegisterViewModel>(
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Inscription',
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold,
                              color: spaceCadet,
                              fontSize: SizeConfig.blockSizeVertical * 3.6),
                        ),
                      ],
                    ),
                    Form(
                      key: _formKey,
                      child: SizedBox(
                        height: SizeConfig.screenHeight * 0.42,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomTextField(
                              label: 'Nom commercial *',
                              controller: value.commercialNameController,
                              type: TextInputType.name,
                              validator: (value) {
                                if (value == null) return '';
                                if (value.isEmpty) {
                                  return 'champ obligatoire';
                                }
                                return null;
                              },
                            ),
                            CustomTextField(
                              label: 'Email *',
                              controller: value.emailController,
                              type: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null) return '';
                                if (value.isEmpty) {
                                  return 'champ obligatoire';
                                }
                                return null;
                              },
                            ),
                            CustomTextField(
                              label: 'Numéro de téléphone *',
                              controller: value.phoneController,
                              type: TextInputType.phone,
                              validator: (value) {
                                if (value == null) return '';
                                if (value.isEmpty) {
                                  return 'champ obligatoire';
                                } else if (value.length != 10) {
                                  return 'phone length must be 10 digits';
                                }
                                return null;
                              },
                            ),
                            CustomTextField(
                              label: 'Mot de passe *',
                              controller: value.passwordController,
                              type: TextInputType.visiblePassword,
                              isObscure: true,
                              validator: (value) {
                                if (value == null) return '';
                                if (value.isEmpty) {
                                  return 'champ obligatoire';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    CustomButton(
                        text: 's\'inscrire',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.pushNamed(
                                context, '/register_information');
                          }
                        }),
                    RichText(
                      maxLines: 1,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'vous avez deja un compte? ',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              fontSize: 1.1 * SizeConfig.blockSizeVertical,
                              color: jacarta,
                            ),
                          ),
                          TextSpan(
                            text: 'connexion',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              fontSize: 1.1 * SizeConfig.blockSizeVertical,
                              color: metalicSeaweed,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = (() {
                                Navigator.pop(context);
                              }),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
