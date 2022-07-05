import 'package:arbpharm/ViewModels/demande/request_viewmodel.dart';
import 'package:arbpharm/Views/Component/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../configs/const.dart';
import '../../configs/size_config.dart';
import '../Component/text_field_widget.dart';
import '../Component/upload_file_field.dart';

class AddOfferDialog extends StatefulWidget {
  final int requestId;
  const AddOfferDialog({Key? key, required this.requestId}) : super(key: key);

  @override
  State<AddOfferDialog> createState() => _AddOfferDialogState();
}

class _AddOfferDialogState extends State<AddOfferDialog> {
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
          height: SizeConfig.screenHeight * 0.7,
          padding:
              EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * 0.05),
          child: Consumer<RequestViewModel>(
            builder: (context, value, child) => Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Devis',
                  style: GoogleFonts.montserrat(
                    fontSize: 2.5 * SizeConfig.blockSizeVertical,
                    fontWeight: FontWeight.bold,
                    color: spaceCadet,
                  ),
                ),
                CustomTextField(
                  label: 'Produit *',
                  controller: value.offerNameController,
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
                  controller: value.offerMarqueController,
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
                  controller: value.offerQuantityController,
                  type: TextInputType.number,
                  validator: (value) {
                    if (value == null) return '';
                    return null;
                  },
                ),
                CustomTextField(
                  label: 'Prix *',
                  controller: value.offerPriceController,
                  type: TextInputType.number,
                  validator: (value) {
                    if (value == null) return '';
                    return null;
                  },
                ),
                CustomUploadFileField(
                  label: 'Ajouter une photo',
                  file: value.offerPhoto,
                  size: Size(
                    SizeConfig.screenWidth * 0.85,
                    SizeConfig.screenHeight * 0.08,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(SizeConfig.screenHeight * 0.007),
                    side: BorderSide(
                      width: 0.8,
                      color: brightGrey,
                    ),
                  ),
                  uploadPhoto: () async {
                    value.getOfferPic();
                  },
                ),
                CustomButton(
                  text: 'publier',
                  working: value.working,
                  onPressed: () => value.postOffer(context, widget.requestId),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
