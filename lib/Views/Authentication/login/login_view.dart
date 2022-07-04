import 'package:arbpharm/ViewModels/Authentication/login_viewmodel.dart';
import 'package:arbpharm/Views/Component/button_widget.dart';
import 'package:arbpharm/Views/Component/text_field_widget.dart';
import '../../../configs/const.dart';
import '../../../configs/size_config.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
                      CustomTextField(
                        label: 'Email/ Numéro de téléphone *',
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
                      CustomButton(
                          working: value.working,
                          text: 'Connexion',
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              value.login(context);
                            }
                          }),
                      Column(
                        children: [
                          RichText(
                            maxLines: 1,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'vous n\'avais pas de compte? ',
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                    fontSize:
                                        1.4 * SizeConfig.blockSizeVertical,
                                    color: jacarta,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Inscrivez-vous',
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                    fontSize:
                                        1.4 * SizeConfig.blockSizeVertical,
                                    color: metalicSeaweed,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = (() {
                                      Navigator.pushNamed(context, '/register');
                                    }),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.screenHeight * 0.02,
                          ),
                          RichText(
                            maxLines: 1,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'mot de passe oublié? ',
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                    fontSize:
                                        1.4 * SizeConfig.blockSizeVertical,
                                    color: jacarta,
                                  ),
                                ),
                                TextSpan(
                                  text: 'réinitialiser',
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                    fontSize:
                                        1.4 * SizeConfig.blockSizeVertical,
                                    color: metalicSeaweed,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = (() {
                                      Navigator.pushNamed(
                                          context, '/forgotten_password_view');
                                    }),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
