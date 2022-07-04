import 'package:arbpharm/ViewModels/demande/request_viewmodel.dart';
import 'package:arbpharm/Views/Component/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../configs/const.dart';
import '../../configs/size_config.dart';
import '../Component/text_field_widget.dart';
import '../Component/upload_file_field.dart';

class AddRequestDialog extends StatefulWidget {
  const AddRequestDialog({Key? key}) : super(key: key);

  @override
  State<AddRequestDialog> createState() => _AddDemadeDialogState();
}

class _AddDemadeDialogState extends State<AddRequestDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SizeConfig.screenHeight * 0.03),
      ),
      child: SingleChildScrollView(
        child: Container(
          width: SizeConfig.screenWidth * 0.9,
          height: SizeConfig.screenHeight * 0.66,
          padding:
              EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * 0.05),
          child: Consumer<RequestViewModel>(
            builder: (context, value, child) => Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'J\'ai besoin de',
                    style: GoogleFonts.montserrat(
                      fontSize: 2.5 * SizeConfig.blockSizeVertical,
                      fontWeight: FontWeight.bold,
                      color: spaceCadet,
                    ),
                  ),
                  CustomTextField(
                    label: 'Produit *',
                    controller: value.nameController,
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
                    label: 'Marque *',
                    controller: value.marqueController,
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
                    label: 'Quantité *',
                    controller: value.quantityController,
                    type: TextInputType.number,
                    validator: (value) {
                      if (value == null) return '';
                      if (value.isEmpty) {
                        return 'champ obligatoire';
                      }
                      return null;
                    },
                  ),
                  CustomUploadFileField(
                    label: 'Ajouter une photo',
                    file: value.photo,
                    size: Size(
                      SizeConfig.screenWidth * 0.85,
                      SizeConfig.screenHeight * 0.08,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          SizeConfig.screenHeight * 0.007),
                      side: BorderSide(
                        width: 0.8,
                        color: brightGrey,
                      ),
                    ),
                    uploadPhoto: () => value.getPic(),
                  ),
                  CustomButton(
                      working: value.working,
                      text: 'publier',
                      onPressed: () {
                        if (_formKey.currentState!.validate() &&
                            value.photo != null) {
                          value.postRequest(context);
                        }
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
