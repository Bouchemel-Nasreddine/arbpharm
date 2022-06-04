import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../ViewModels/Authentication/register_viewmodel.dart';
import '../../../configs/const.dart';
import '../../../configs/size_config.dart';
import '../../Component/button_widget.dart';
import '../../Component/text_field_widget.dart';

class RegisterInformationView extends StatelessWidget {
  RegisterInformationView({Key? key}) : super(key: key);

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
                  child: SizedBox(
                    height: SizeConfig.screenHeight * 0.85,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.01,
                        ),
                        CustomTextField(
                          label: 'Nom social *',
                          controller: value.socialNameController,
                          type: TextInputType.name,
                          validator: (value) {
                            if (value == null) return '';
                            if (value.isEmpty) {
                              return 'required field';
                            }
                            return null;
                          },
                        ),
                        CustomTextField(
                          label: 'Numéro de RC *',
                          controller: value.nrcController,
                          type: TextInputType.number,
                          validator: (value) {
                            if (value == null) return '';
                            if (value.isEmpty) {
                              return 'required field';
                            }
                            return null;
                          },
                        ),
                        CustomTextField(
                          label: 'NIF *',
                          controller: value.nifController,
                          type: TextInputType.number,
                          validator: (value) {
                            if (value == null) return '';
                            if (value.isEmpty) {
                              return 'required field';
                            }
                            return null;
                          },
                        ),
                        CustomTextField(
                          label: 'NIS',
                          controller: value.nisController,
                          type: TextInputType.number,
                          validator: (value) {
                            if (value == null) return '';
                            return null;
                          },
                        ),
                        CustomTextField(
                          label: 'Numéro AR',
                          controller: value.narController,
                          type: TextInputType.number,
                          validator: (value) {
                            if (value == null) return '';
                            return null;
                          },
                        ),
                        CustomTextField(
                          label: 'Siège social',
                          controller: value.adrController,
                          type: TextInputType.text,
                          validator: (value) {
                            if (value == null) return '';
                            return null;
                          },
                        ),
                        CustomTextField(
                          label: 'Code d\'activité *',
                          controller: value.actCodeController,
                          type: TextInputType.number,
                          validator: (value) {
                            if (value == null) return '';
                            if (value.isEmpty) {
                              return 'required field';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: SizeConfig.screenHeight * 0.05,
                              width: SizeConfig.screenWidth * 0.32,
                              child: CustomButton(
                                  text: 'suivant',
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      Navigator.pushNamed(
                                          context, '/add_photo_view');
                                    }
                                  }),
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
      ),
    );
  }
}
