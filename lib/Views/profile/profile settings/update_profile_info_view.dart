import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../ViewModels/profile/profile_viewmodel.dart';
import '../../../configs/const.dart';
import '../../../configs/size_config.dart';
import '../../Component/back_app_bar.dart';
import '../../Component/button_widget.dart';
import '../../Component/text_field_widget.dart';

class UpdateProfileView extends StatelessWidget {
  UpdateProfileView({Key? key}) : super(key: key);
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
        child: SingleChildScrollView(
          child: Consumer<ProfileViewModel>(
            builder: (context, value, child) => Container(
              width: SizeConfig.screenWidth,
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.screenWidth * 0.1,
              ),
              child: Form(
                key: _formKey,
                child: FutureBuilder(
                  future: value.setFields(),
                  builder: (context, snapShot) => snapShot.connectionState ==
                          ConnectionState.waiting
                      ? const CircularProgressIndicator()
                      : Column(
                          children: [
                            Text(
                              'mettre a jour vos informations',
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold,
                                  color: spaceCadet,
                                  fontSize: SizeConfig.blockSizeVertical * 2),
                            ),
                            SizedBox(
                              height: SizeConfig.screenHeight * 0.035,
                            ),
                            CustomTextField(
                              label: 'email',
                              controller: value.emailController,
                              type: TextInputType.emailAddress,
                            ),
                            SizedBox(
                              height: SizeConfig.screenHeight * 0.02,
                            ),
                            CustomTextField(
                              label: 'Numéro de téléphone',
                              controller: value.phoneController,
                              type: TextInputType.phone,
                              validator: (val) {
                                if (val == null) return '';
                                if (val.length != 10) {
                                  return 'length must be 10';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: SizeConfig.screenHeight * 0.02,
                            ),
                            CustomTextField(
                              label: 'nom commercial',
                              controller: value.commercialNameController,
                              type: TextInputType.text,
                            ),
                            SizedBox(
                              height: SizeConfig.screenHeight * 0.035,
                            ),
                            CustomTextField(
                              label: 'nom social',
                              controller: value.socialNameController,
                              type: TextInputType.text,
                            ),
                            SizedBox(
                              height: SizeConfig.screenHeight * 0.02,
                            ),
                            CustomTextField(
                              label: 'Numero RC',
                              controller: value.nrcController,
                              type: TextInputType.number,
                            ),
                            SizedBox(
                              height: SizeConfig.screenHeight * 0.02,
                            ),
                            CustomTextField(
                              label: 'Nif',
                              controller: value.nifController,
                              type: TextInputType.number,
                            ),
                            SizedBox(
                              height: SizeConfig.screenHeight * 0.035,
                            ),
                            CustomTextField(
                              label: 'Nis',
                              controller: value.nisController,
                              type: TextInputType.number,
                            ),
                            SizedBox(
                              height: SizeConfig.screenHeight * 0.02,
                            ),
                            CustomTextField(
                              label: 'Numéro AR',
                              controller: value.narController,
                              type: TextInputType.number,
                            ),
                            SizedBox(
                              height: SizeConfig.screenHeight * 0.02,
                            ),
                            CustomTextField(
                              label: 'adresse',
                              controller: value.adrController,
                              type: TextInputType.text,
                            ),
                            SizedBox(
                              height: SizeConfig.screenHeight * 0.035,
                            ),
                            CustomTextField(
                              label: "Code d'activité",
                              controller: value.actCodeController,
                              type: TextInputType.number,
                            ),
                            SizedBox(
                              height: SizeConfig.screenHeight * 0.035,
                            ),
                            CustomButton(
                                working: value.working,
                                text: 'appliquer',
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    value.upadateProfileInfo(context);
                                  }
                                }),
                            SizedBox(
                              height: SizeConfig.screenHeight * 0.07,
                            )
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
